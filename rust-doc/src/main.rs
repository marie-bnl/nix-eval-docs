use std::sync::Arc;
use std::{env, path};

use indoc::*;

use nix_bindings::{
    Context,
    EvalStateBuilder,
    Store,
};

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let ctx = Arc::new(Context::new()?);
    let store = Arc::new(Store::open(&ctx, None)?);
    let state = EvalStateBuilder::new(&store)?.build()?;

    let path = path::absolute(path::Path::new(
        &env::args().nth(1)
            .expect("Expected path to example/<name>/ as first argument")
    ))?;

    let value = state.eval_from_string(
        "import ./default.nix",
        &path.to_string_lossy(),
    )?;

    for attr in value.attrs()? {
        if let Ok((key, mut value)) = attr {
            value.force()?;

            match value.get_doc() {
                Err(error) => {
                    eprintln!("Not generating doc for value `{}`: {}", key, error);
                    continue;
                },

                Ok(doc) => {
                    let pos = doc.get_pos()?;

                    let name = doc.get_name().unwrap_or("NO_DOC_NAME".to_string());
                    let source_path = pos.get_source_path().unwrap_or("NO_SOURCE_PATH".to_string());

                    let doc_content = doc.get_content()?;
                    let content =
                        if doc_content.is_empty() { "NO_DOC_CONTENT".to_string() }
                        else { doc_content };

                    printdoc!(
                        "
                            ## Documentation for `{}`

                            *Function `{}` defined at {}:{}:{}*

                            {}

                        ",
                        key,
                        name,
                        source_path, pos.get_line(), pos.get_column(),
                        content.trim(),
                    );
                }
            }
        }
    }

    Ok(())
}

use std::sync::Arc;

use nix_bindings::{Context, EvalStateBuilder, Store};

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let ctx = Arc::new(Context::new()?);
    let store = Arc::new(Store::open(&ctx, None)?);
    let state = EvalStateBuilder::new(&store)?.build()?;

    let result = state.eval_from_string("
        {
            /** Returns the sum of `a` and `b`. */
            sum = a: b: a + b;
        }
    ", "<eval>")?;

    let attr = result.get_attr("sum")?;
    let doc = attr.get_doc()?;
    let pos = doc.get_pos()?;

    println!(
        "
            Documentation for `sum`
            Position: {:?}:{}:{}
            Name: {:?}
            Args: {:?}
            Content: {:?}
        ",
        pos.get_source_path(), pos.get_line(), pos.get_column(),
        doc.get_name(),
        doc.get_args(),
        doc.get_content(),
    );

    Ok(())
}

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

    let sum_attr = result.get_attr("sum")?;
    let sum_doc = sum_attr.get_doc()?;

    println!(
        "
            Documentation for `sum`
            Name: {:?}
            Args: {:?}
            Content: {:?}
        ",
        sum_doc.get_name(),
        sum_doc.get_args(),
        sum_doc.get_content(),
    );

    Ok(())
}

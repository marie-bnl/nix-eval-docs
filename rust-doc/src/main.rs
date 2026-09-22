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
    let sum_doc_pos = sum_doc.get_pos()?;

    println!(
        "
            Documentation for `sum`
            Position: {}:{}
            Name: {:?}
            Args: {:?}
            Content: {:?}
        ",
        sum_doc_pos.get_line(), sum_doc_pos.get_column(),
        sum_doc.get_name(),
        sum_doc.get_args(),
        sum_doc.get_content(),
    );

    Ok(())
}

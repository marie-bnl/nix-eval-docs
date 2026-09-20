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

    println!("{}", result.get_attr("sum")?.get_doc()?);

    Ok(())
}

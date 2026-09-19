use std::sync::Arc;

use nix_bindings::{Context, EvalStateBuilder, Store};
use nix_bindings::sys;

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

    /*
        Something like:

            let fun = result.get_attr("sum");

            let doc = unsafe {
                sys::nix_get_value_doc(
                    ctx.as_ptr(),
                    state.as_ptr(),
                    fun.as_ptr(),
                );
            }

            println!("{}", doc.doc);

        Except it will probably need to be implemented in nix-bindings directly
        by patching it because `as_ptr`s are private.

        Also sys::nix_get_value_doc doesn't exist for some reason.
    */

    Ok(())
}

use nix_bindings::sys;

fn main() -> Result<(), Box<dyn std::error::Error>> {
    unsafe {
        let ctx_ptr = sys::nix_c_context_create();
        sys::nix_libexpr_init(ctx_ptr);

        let store_uri_ptr = std::ptr::null();
        let store_params_ptr = std::ptr::null_mut();
        let store_ptr = sys::nix_store_open(ctx_ptr, store_uri_ptr, store_params_ptr);

        let state_builder_ptr = sys::nix_eval_state_builder_new(ctx_ptr, store_ptr);
        let state_ptr = sys::nix_eval_state_build(ctx_ptr, state_builder_ptr);

        let path_c = std::ffi::CString::new("<eval>")?;
        let expr_c = std::ffi::CString::new("
            {
                /** Returns the sum of `a` and `b`. */
                sum = a: b: a + b;
            }
        ")?;

        let value_ptr = sys::nix_alloc_value(ctx_ptr, state_ptr);
        sys::nix_expr_eval_from_string(
          ctx_ptr,
          state_ptr,
          expr_c.as_ptr(),
          path_c.as_ptr(),
          value_ptr,
        );

        let key_c = std::ffi::CString::new("sum")?;
        let sum_attr_ptr = sys::nix_get_attr_byname(
            ctx_ptr,
            value_ptr,
            state_ptr,
            key_c.as_ptr(),
        );

        let sum_doc = sys::nix_get_value_doc(
            ctx_ptr,
            state_ptr,
            sum_attr_ptr,
        );

        let sum_doc_str = std::ffi::CStr::from_ptr(
            sys::nix_get_doc_content(sum_doc)
        );

        println!("{}", sum_doc_str.to_str()?);
    }

    Ok(())
}

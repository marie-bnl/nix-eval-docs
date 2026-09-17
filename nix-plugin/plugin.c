#include "nix/expr/attr-set.hh"
#include "nix/expr/eval-error.hh"
#include "nix/expr/eval.hh"
#include "nix/store/path.hh"
#include "nix/expr/primops.hh"
#include "nix/expr/value.hh"

#include "nix_api_expr.h"
#include "nix_api_expr_internal.h"
#include "nix_api_util.h"
#include "nix_api_util_internal.h"
#include "nix_api_store_internal.h"
#include "nix_api_value.h"

/*
  Includes above copied from `<nix>/src/libexpr-c/` for convenience.
  TODO: Once this plugin builds, remove unused ones.
*/

const char * nix_get_value_doc(nix_c_context * context, EvalState * state, const nix_value * value)
{
    if (context)
        context->last_err_code = NIX_OK;
    try {
        auto & v = check_value_in(value);
        // TODO: Also check if it's a PrimOps or a Functor
        // Or maybe both are also `nFunction`s?
        assert(v.type() == nix::nFunction);
        auto doc = state->getDoc();
        if (doc) *doc else ""; // FIXME: There sure is a better way
    }
    NIXC_CATCH_ERRS_NULL
}

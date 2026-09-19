#include <stdio.h>

#include "nix_api_util.h"
#include "nix_api_expr.h"
#include "nix_api_store.h"
#include "nix_api_value.h"

int main() {
   auto ctx = nix_c_context_create();
   nix_libexpr_init(ctx);

   auto store = nix_store_open(ctx, nullptr, nullptr);

   auto state_builder = nix_eval_state_builder_new(ctx, store);
   auto state = nix_eval_state_build(ctx, state_builder);

   auto value = nix_alloc_value(ctx, state);

   auto expr =
      "{"
         "/** Returns the sum of `a` and `b`. */"
         "sum = a: b: a + b;"
      "}";

   nix_expr_eval_from_string(
      ctx,
      state,
      expr,
      "<eval>",
      value
   );

   auto sum_attr = nix_get_attr_byname(
      ctx,
      value,
      state,
      "sum"
   );

   // error: 'nix_get_value_doc' was not declared in this scope
   auto sum_doc = nix_get_value_doc(
      ctx,
      state,
      sum_attr
   );

   printf(sum_doc->doc);

   return 0;
}
# Nix evaluation-based documentation

See https://github.com/nix-community/nixdoc/issues/167.

## Important notes

**Nix**

- Breaking changes introduced:
    - `EvalState::Doc::doc` renamed to `content`
    - Field does not contain the header anymore (it is generated in repl's `:doc` instead)

**Nix-bindings**

- All created functions need safety checks

## Roadmap

- [x] Functions to get a doc comment's content from a value after evaluation
    - [x] Rename Nix's `doc.doc` to smth more meaningful like `doc.content`
    - [x] Make `EvalState::getDoc` put only the content in it and move the "Function ... defined at ..." header generation to `nix repl`
- [x] Getters for other `doc` fields
    - [ ] Getter for `pos`
    - [x] Getter implemented and tested for `name`
    - [x] Not going to implement `arity` (see note below)
    - [x] Getter for `args`: Nix currently always returns `{}` for lambdas
        - [x] Working for PrimOps
        - [ ] Patch Nix so it returns the arguments for lambdas?
- [ ] Write Nix tests
- [ ] Port changes to master and open Nix PR
- [ ] Documentation for created nix-bindings functions
- [ ] **Safety in nix-bindings patch**
- [-] Docs for single lambda and non-lambda values
    - [x] Docs for single lambda already work
    - [ ] It seemed docs for non-lambdas was already implemented (search "constant" in https://github.com/NixOS/nix/commit/7fae378835534d2a17818fd7cd91aae91320aa03#diff-84f894eefa09f4d448f65ea95ec65bc8266f5f11ca67db66408a343ae9f8391bR26) but actually no
- [ ] Unit tests
- [ ] Implement in `nixdoc`

**Note:** Nix currently always returns `0` arity for lambdas and [who knows what the use of this field is](https://github.com/NixOS/nix/blob/5711f8fed2fcff91a52646e2e856648eca86c331/src/libexpr/eval.cc#L654).

## Building

> [!NOTE]  
> Building without CCache is untested. It should work because it's mainly just the same outputs as CCache but using `nix-patched` instead of `nix-patched-cccache` and both are generated the exact same way, just changing the `stdenv`. But if you get issues it might be worth trying building with CCache.

- Build the patched Nix: `nix build path:.#nix-patched`
- Build the Rust test doc generator: `nix build path:.#rust`

### CCache

> [!WARNING]  
> The `nix-patched-ccache-builder` will use the `/var/tmp/nix-eval-docs-ccache` directory which it will create if it doesn't exist and set its permissions to `777`.

- Build the patched Nix: `nix run path:.#nix-patched-ccache-builder "$CORE_NUMBER"`
- Build the Rust test doc generator `nix build path:.#rust-ccache`

Because `nix-patched-ccache-builder` uses a custom build script, building the Rust test requires having built the patched Nix once since the latest change to `nix-patched`. If you run into `ccache: error: Permission denied` that's why.

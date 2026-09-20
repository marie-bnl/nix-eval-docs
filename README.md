# Nix evaluation-based documentation

See https://github.com/nix-community/nixdoc/issues/167.

## Roadmap

- [x] Functions to get a doc comment's content from a value after evaluation
- [ ] Functions to access `doc` fields other than content
- [ ] **Safety in nix-bindings patch**
- [ ] Nix patch to generate `doc` on lambdas outside attrs
    - [ ] Generate `doc` on non-lambda values?
- [ ] Unit tests
- [ ] Implement in `nixdoc`

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

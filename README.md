# Nix evaluation-based documentation

See https://github.com/nix-community/nixdoc/issues/167.

## Building

- Build the patched Nix: `nix build path:.#nix-patched`
- Build the C example: `nix build path:.#c-doc`
- Enter the Rust devshell: `nix develop path:.#rust`

### CCache

> [!WARNING]
> The `nix-patched-ccache-builder` will use the `/var/tmp/nix-eval-docs-ccache` directory which it will create if it doesn't exist and set its permissions to `777`.

- Build the patched Nix: `nix run path:.#nix-patched-ccache-builder "$CORE_NUMBER"`
- Build the C example: `nix build path:.#c-doc-ccache`
- Enter the Rust devshell `nix develop path:.#rust-ccache`

> [!IMPORTANT]
> Because `nix-patched-ccache-builder` uses a custom build script, building the C example or entering the Rust devshell requires having built the patched Nix once since the latest change to `nix-patched`.

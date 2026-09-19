# Nix evaluation-based documentation

See https://github.com/nix-community/nixdoc/issues/167.

## Building

- Build the patched Nix: `nix build path:.#nix-patched`
- Enter the devshell: `nix develop path:.`

### CCache

> [!WARNING]
> The `nix-patched-ccache-builder` will use the `/var/tmp/nix-eval-docs-ccache` directory which it will create if it doesn't exist and set its permissions to `777`.

- Build the patched Nix: `nix run path:.#nix-patched-ccache-builder "$CORE_NUMBER"`
- Enter the devshell: `nix develop path:.#ccache`

Entering the devshell requires having built Nix before as it is built with a custom script.

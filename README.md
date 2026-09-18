## Building

### Normal

```
nix build path:.#nix-patched
```

### CCache

This will use `/var/tmp/nix-eval-docs-ccache` which it will create if it doesn't exist and set its permissions to `777`.

```
nix run path:.#nix-patched-ccache-builder 4
```

Where 4 is the number of cores to build with.

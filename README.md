## Building

```
nix build .#nix-patched
```

- Or use `path:.#nix-patched` to test uncommitted changes
- You can add `--option cores n` if the build eats too much RAM

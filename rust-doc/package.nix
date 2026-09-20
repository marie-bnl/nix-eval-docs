{
  rustPlatform,
  nix,
  pkg-config,
  rustc,
  makeSetupHook,
  applyPatches,
  nix-bindings,
}:

rustPlatform.buildRustPackage {
  name = "rust-doc";

  src = ./.;

  cargoHash = "sha256-rl1TB2Uzu+4fxB+JFU3K8doHmVuIvr8r0I0GvJ9NL60=";

  patchPhase = ''
    substituteInPlace Cargo.toml \
      --subst-var-by "patched-nix-bindings-path" "${nix-bindings}"
  '';

  strictDeps = true;

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    nix.dev
  ];

  LIBCLANG_PATH = "${rustc.llvmPackages.libclang.lib}/lib";
}

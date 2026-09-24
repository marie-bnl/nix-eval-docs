{
  pkg-config,
  rustc,
  rustPlatform,

  nix,
  nix-bindings,
}:

rustPlatform.buildRustPackage {
  name = "rust-doc";

  src = ./.;

  cargoHash = "sha256-FYxYB8EICInP3WZg6jDfXx5m9cw43aBbJpcgrZsCCQ0=";

  patchPhase = ''
    ln -s ${nix-bindings} nix-bindings
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

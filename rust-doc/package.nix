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

  cargoLock = ./Cargo.lock;

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

{
  lib,
  nix-patched,
  pkg-config,
  stdenv,
}:

stdenv.mkDerivation {
  name = "nix-eval-docs-c-doc";

  src = ./src;

  buildInputs = [
    nix-patched.dev
    pkg-config
  ];

  buildPhase =
    let
      pkg-config-pkgs = [
        "nix-util-c"
        "nix-expr-c"
        "nix-store-c"
      ];
    in
    ''
      g++ main.cc $(pkg-config ${lib.join " " pkg-config-pkgs} --libs) -o main
    '';

  installPhase = ''
    mkdir -p "$out/bin"
    cp main "$out/bin"
  '';
}

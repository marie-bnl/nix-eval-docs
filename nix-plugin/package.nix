{
  stdenv,
  nixVersions,
  pkg-config,
}:

stdenv.mkDerivation {
  name = "nix-plugin";

  src = ./.;

  buildInputs = [
    nixVersions.nix_2_35.dev
    pkg-config
  ];

  buildPhase = ''
    g++ --std=c++23 plugin.c $(pkg-config nix-expr nix-expr-c --libs --cflags) -shared -o plugin.so
  '';

  installPhase = ''
    mkdir -p "$out"/lib
    mv plugin.so "$out"/lib
  '';
}

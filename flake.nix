{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, nix, ... }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
      };
    in
    {
      packages.${system}.nix-patched = pkgs.nixVersions.nix_2_35.appendPatches [
        ./patches/nix-get-value-doc.patch
      ];
    };
}

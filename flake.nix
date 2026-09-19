{
  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-26.05/nixexprs.tar.xz";
    nix.url = "github:NixOS/nix/2.35.2";
  };

  outputs = { self, nixpkgs, nix, ... }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
      };
    in
    {
      packages.${system} =
        let
          disableChecks = nix:
            nix.overrideAllMesonComponents (_: _: {
              doCheck = false;
            });

          overrideStdenv = stdenv: nix:
            nix.overrideScope (_: _: {
              inherit stdenv;
            });

          patchSource = nix:
            nix.appendPatches [
              ./patches/nix-get-value-doc.patch
            ];

          nixForStdenv = stdenv:
            pkgs.lib.pipe nix.packages.${system}.nix-everything [
              disableChecks
              (overrideStdenv stdenv)
              patchSource
            ];
        in
        {
          nix-patched = nixForStdenv pkgs.stdenv;

          nix-patched-ccache = nixForStdenv (pkgs.ccacheStdenv.override {
            extraConfig = ''
              export CCACHE_COMPRESS=1
              export CCACHE_SLOPPINESS=random_seed
              export CCACHE_DIR=/ccache
              export CCACHE_UMASK=007
            '';
          });

          c-doc = pkgs.callPackage ./c-doc/package.nix {
            nix-patched = self.packages.${system}.nix-patched;
          };
        };

      apps.${system}.nix-patched-ccache-builder = {
        type = "app";
        program =
          let
            builder = pkgs.writeShellScript "nix-patched-ccache-builder" ''
              [ -z "$1" ] && echo "Please set number of cores (see README)" && exit 1

              ccache_dir="/var/tmp/nix-eval-docs-ccache"
              mkdir -p "$ccache_dir"
              chmod 777 "$ccache_dir"

              nix build \
                  --option cores $1 \
                  --option sandbox-paths "/ccache=$ccache_dir" \
                  path:.#nix-patched-ccache
            '';
          in
          "${builder}";
      };

      devShells.${system} = {
        rust = import ./rust-doc/flake/shell.nix {
          inherit pkgs;
          nix = self.packages.${system}.nix-patched;
        };
      };
    };
}

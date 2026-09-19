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
      packages.${system} = rec {
        nix-patched =
          nix.packages.${system}.nix-everything.overrideScope (final: prev: {
            patches = prev.patches ++ [
              ./patches/nix-get-value-doc.patch
            ];

            mesonComponentOverrides =
              pkgs.lib.composeExtensions prev.mesonComponentOverrides (_: _: {
                doCheck = false;
              });
          });

        nix-patched-ccache = nix-patched.overrideScope (_: _: {
          stdenv = pkgs.ccacheStdenv.override {
            extraConfig = ''
              export CCACHE_COMPRESS=1
              export CCACHE_SLOPPINESS=random_seed
              export CCACHE_DIR=/ccache
              export CCACHE_UMASK=007
            '';
          };
        });
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
        default = import ./flake/shell.nix {
          inherit pkgs;
          nix = self.packages.${system}.nix-patched;
        };

        ccache = import ./flake/shell.nix {
          inherit pkgs;
          nix = self.packages.${system}.nix-patched-ccache;
        };
      };
    };
}

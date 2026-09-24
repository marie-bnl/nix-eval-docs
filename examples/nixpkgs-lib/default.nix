let
  # nix eval --impure --expr "<nixpkgs>"
  nixpkgs = /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source;

  pkgs = import nixpkgs {
    system = "x86_64-linux";
  };
in
pkgs.lib

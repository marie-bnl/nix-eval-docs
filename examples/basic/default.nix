let
  # nix eval --impure --expr "<nixpkgs>"
  nixpkgs = /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source;

  pkgs = import nixpkgs {
    system = "x86_64-linux";
  };
in
{
  /** Return the sum of `a` and `b`. */
  simpleLambda = a: b: a + b;

  simpleUndocumentedLambda = a: b: a * b;

  primOp = builtins.div;

  funFromImport = import ./import.nix;

  funFromCallPackage = pkgs.callPackage ./package.nix {};

  notAFunctor.definitelyNot = true;

  funFromNixpkgsLib = pkgs.lib.converge;
}

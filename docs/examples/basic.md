## Documentation for `simpleLambda`

*Function `simpleLambda` defined at /home/marie/dev/nix-eval-doc/examples/basic/default.nix:11:18*

Return the sum of `a` and `b`.

## Documentation for `simpleUndocumentedLambda`

*Function `simpleUndocumentedLambda` defined at /home/marie/dev/nix-eval-doc/examples/basic/default.nix:13:30*

NO_DOC_CONTENT

## Documentation for `primOp`

*Function `div` defined at NO_SOURCE_PATH:0:0*

Return the quotient of the numbers *e1* and *e2*.

## Documentation for `funFromImport`

*Function `` defined at /home/marie/dev/nix-eval-doc/examples/basic/import.nix:6:1*

Return a customised greeting :)

I'm a single lambda in a file and I've been imported.

## Documentation for `funFromCallPackage`

*Function `` defined at /home/marie/dev/nix-eval-doc/examples/basic/package.nix:11:1*

Return the hello package, but with a custom name.

I've been called with callPackage, and I'm a functor by the way.

## Documentation for `funFromNixpkgsLib`

*Function `converge` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/fixed-points.nix:153:5*

Returns the fixpoint that `f` converges to when called iteratively, starting
with the input `x`.

```
nix-repl> converge (x: x / 2) 16
0
```

# Inputs

`f`

: 1\. Function argument

`x`

: 2\. Function argument

# Type

```
converge :: (a -> a) -> a -> a
```


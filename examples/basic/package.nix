{
  hello,
}:

/**
  Return the hello package, but with a custom name.

  I've been called with callPackage, and I'm a functor by the way.
*/

name:

hello.overrideAttrs {
  pname = name;
}

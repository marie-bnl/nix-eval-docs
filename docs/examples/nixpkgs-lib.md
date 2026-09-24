## Documentation for `or`

*Function `or` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/trivial.nix:212:10*

boolean “or”

# Inputs

`x`

: 1\. Function argument

`y`

: 2\. Function argument

# Type

```
or :: Bool -> Bool -> Bool
```

## Documentation for `typeOf`

*Function `typeOf` defined at NO_SOURCE_PATH:0:0*

Return a string representing the type of the value *e*, namely
      `"int"`, `"bool"`, `"string"`, `"path"`, `"null"`, `"set"`,
      `"list"`, `"lambda"` or `"float"`.

## Documentation for `isFunction`

*Function `` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/trivial.nix:1131:5*

NO_DOC_CONTENT

## Documentation for `isInt`

*Function `isInt` defined at NO_SOURCE_PATH:0:0*

Return `true` if *e* evaluates to an integer, and `false` otherwise.

## Documentation for `isFloat`

*Function `isFloat` defined at NO_SOURCE_PATH:0:0*

Return `true` if *e* evaluates to a float, and `false` otherwise.

## Documentation for `isString`

*Function `isString` defined at NO_SOURCE_PATH:0:0*

Return `true` if *e* evaluates to a string, and `false` otherwise.

## Documentation for `isBool`

*Function `isBool` defined at NO_SOURCE_PATH:0:0*

Return `true` if *e* evaluates to a bool, and `false` otherwise.

## Documentation for `isPath`

*Function `isPath` defined at NO_SOURCE_PATH:0:0*

Return `true` if *e* evaluates to a path, and `false` otherwise.

## Documentation for `genericClosure`

*Function `genericClosure` defined at NO_SOURCE_PATH:0:0*

`builtins.genericClosure` iteratively computes the transitive closure over an arbitrary relation defined by a function.

      It takes *attrset* with two attributes named `startSet` and `operator`, and returns a list of attribute sets:

      - `startSet`:
        The initial list of attribute sets.

      - `operator`:
        A function that takes an attribute set and returns a list of attribute sets.
        It defines how each item in the current set is processed and expanded into more items.

      Each attribute set in the list `startSet` and the list returned by `operator` must have an attribute `key`, which must support equality comparison.
      The value of `key` can be one of the following types:

      - [Int](@docroot@/language/types.md#type-int)
      - [Float](@docroot@/language/types.md#type-float)
      - [Boolean](@docroot@/language/types.md#type-bool)
      - [String](@docroot@/language/types.md#type-string)
      - [Path](@docroot@/language/types.md#type-path)
      - [List](@docroot@/language/types.md#type-list)

      The result is produced by calling the `operator` on each `item` that has not been called yet, including newly added items, until no new items are added.
      Items are compared by their `key` attribute.

      Common usages are:

      - Generating unique collections of items, such as dependency graphs.
      - Traversing through structures that may contain cycles or loops.
      - Processing data structures with complex internal relationships.

      > **Example**
      >
      > ```nix
      > builtins.genericClosure {
      >   startSet = [ {key = 5;} ];
      >   operator = item: [{
      >     key = if (item.key / 2 ) * 2 == item.key
      >          then item.key / 2
      >          else 3 * item.key + 1;
      >   }];
      > }
      > ```
      >
      > evaluates to
      >
      > ```nix
      > [ { key = 5; } { key = 16; } { key = 8; } { key = 4; } { key = 2; } { key = 1; } ]
      > ```

## Documentation for `addErrorContext`

*Function `addErrorContext` defined at NO_SOURCE_PATH:0:0*

Evaluate *context*, which can be coerced to a string,
            and append it to any error or stack traces displayed while evaluating *value*.
            Then return *value*.

            This function is useful for providing helpful context in complex Nix expressions
            when the evaluation of *value* fails.
            The additional context is applied when evaluating *value* itself fails,
            not when attributes or elements of *value* are evaluated.

            For example, the module system from nixpkgs uses this to show
            the relevant information about the options that were evaluating
            when an error occurs.

            ```nix-repl
            nix-repl> addErrorContext "while evaluating foo" (throw "bar")
            error:
                   … while evaluating foo

                   … while calling the 'throw' builtin
                     at «string»:1:56:
                        1| with builtins; addErrorContext "while evaluating foo" (throw "bar")
                         |                                                        ^

                   error: bar
            ```

## Documentation for `ceil`

*Function `ceil` defined at NO_SOURCE_PATH:0:0*

Rounds and converts *number* to the next higher NixInt value if possible, i.e. `ceil *number* >= *number*` and
        `ceil *number* - *number* < 1`.

        An evaluation error is thrown, if there exists no such NixInt value `ceil *number*`.
        Due to bugs in previous Nix versions an evaluation error might be thrown, if the datatype of *number* is
        a NixInt and if `*number* < -9007199254740992` or `*number* > 9007199254740992`.

        If the datatype of *number* is neither a NixInt (signed 64-bit integer) nor a NixFloat
        (IEEE-754 double-precision floating-point number), an evaluation error is thrown.

## Documentation for `floor`

*Function `floor` defined at NO_SOURCE_PATH:0:0*

Rounds and converts *number* to the next lower NixInt value if possible, i.e. `floor *number* <= *number*` and
        `*number* - floor *number* < 1`.

        An evaluation error is thrown, if there exists no such NixInt value `floor *number*`.
        Due to bugs in previous Nix versions an evaluation error might be thrown, if the datatype of *number* is
        a NixInt and if `*number* < -9007199254740992` or `*number* > 9007199254740992`.

        If the datatype of *number* is neither a NixInt (signed 64-bit integer) nor a NixFloat
        (IEEE-754 double-precision floating-point number), an evaluation error will be thrown.

## Documentation for `tryEval`

*Function `tryEval` defined at NO_SOURCE_PATH:0:0*

Try to shallowly evaluate *e*. Return a set containing the
      attributes `success` (`true` if *e* evaluated successfully,
      `false` if an error was thrown) and `value`, equalling *e* if
      successful and `false` otherwise. `tryEval` only prevents
      errors created by `throw` or `assert` from being thrown.
      Errors `tryEval` doesn't catch are, for example, those created
      by `abort` and type errors generated by builtins. Also note that
      this doesn't evaluate *e* deeply, so `let e = { x = throw ""; };
      in (builtins.tryEval e).success` is `true`. Using
      `builtins.deepSeq` one can get the expected result:
      `let e = { x = throw ""; }; in
      (builtins.tryEval (builtins.deepSeq e e)).success` is
      `false`.

      `tryEval` intentionally does not return the error message, because that risks bringing non-determinism into the evaluation result, and it would become very difficult to improve error reporting without breaking existing expressions.
      Instead, use [`builtins.addErrorContext`](@docroot@/language/builtins.md#builtins-addErrorContext) to add context to the error message, and use a Nix unit testing tool for testing.

## Documentation for `seq`

*Function `seq` defined at NO_SOURCE_PATH:0:0*

Evaluate *e1*, then evaluate and return *e2*. This ensures that a
      computation is strict in the value of *e1*.

## Documentation for `deepSeq`

*Function `deepSeq` defined at NO_SOURCE_PATH:0:0*

This is like `seq e1 e2`, except that *e1* is evaluated *deeply*:
      if it’s a list or set, its elements or attributes are also
      evaluated recursively.

## Documentation for `trace`

*Function `trace` defined at NO_SOURCE_PATH:0:0*

Evaluate *e1* and print its abstract syntax representation on
      standard error. Then return *e2*. This function is useful for
      debugging.

      If the
      [`debugger-on-trace`](@docroot@/command-ref/conf-file.md#conf-debugger-on-trace)
      option is set to `true` and the `--debugger` flag is given, the
      interactive debugger is started when `trace` is called (like
      [`break`](@docroot@/language/builtins.md#builtins-break)).

## Documentation for `warn`

*Function `warn` defined at NO_SOURCE_PATH:0:0*

Evaluate *e1*, which must be a string, and print it on standard error as a warning.
      Then return *e2*.
      This function is useful for non-critical situations where attention is advisable.

      If the
      [`debugger-on-trace`](@docroot@/command-ref/conf-file.md#conf-debugger-on-trace)
      or [`debugger-on-warn`](@docroot@/command-ref/conf-file.md#conf-debugger-on-warn)
      option is set to `true` and the `--debugger` flag is given, the
      interactive debugger will be started when `warn` is called (like
      [`break`](@docroot@/language/builtins.md#builtins-break)).

      If the
      [`abort-on-warn`](@docroot@/command-ref/conf-file.md#conf-abort-on-warn)
      option is set, the evaluation is aborted after the warning is printed.
      This is useful to reveal the stack trace of the warning, when the context is non-interactive and a debugger can not be launched.

## Documentation for `placeholder`

*Function `placeholder` defined at NO_SOURCE_PATH:0:0*

Return an
      [output placeholder string](@docroot@/store/derivation/index.md#output-placeholder)
      for the specified *output* that will be substituted by the corresponding
      [output path](@docroot@/glossary.md#gloss-output-path)
      at build time.

      Typical outputs would be `"out"`, `"bin"` or `"dev"`.

## Documentation for `pathExists`

*Function `pathExists` defined at NO_SOURCE_PATH:0:0*

Return `true` if the path *path* exists at evaluation time, and
      `false` otherwise.

## Documentation for `baseNameOf`

*Function `baseNameOf` defined at NO_SOURCE_PATH:0:0*

Return the *base name* of either a [path value](@docroot@/language/types.md#type-path) *x* or a string *x*, depending on which type is passed, and according to the following rules.

      For a path value, the *base name* is considered to be the part of the path after the last directory separator, including any file extensions.
      This is the simple case, as path values don't have trailing slashes.

      When the argument is a string, a more involved logic applies. If the string ends with a `/`, only this one final slash is removed.

      After this, the *base name* is returned as previously described, assuming `/` as the directory separator. (Note that evaluation must be platform independent.)

      This is somewhat similar to the [GNU `basename`](https://www.gnu.org/software/coreutils/manual/html_node/basename-invocation.html) command, but GNU `basename` strips any number of trailing slashes.

## Documentation for `dirOf`

*Function `dirOf` defined at NO_SOURCE_PATH:0:0*

Return the directory part of the string *s*, that is, everything
      before the final slash in the string. This is similar to the GNU
      `dirname` command.

## Documentation for `readFile`

*Function `readFile` defined at NO_SOURCE_PATH:0:0*

Return the contents of the file *path* as a string.

## Documentation for `hashFile`

*Function `hashFile` defined at NO_SOURCE_PATH:0:0*

Return a base-16 representation of the cryptographic hash of the
      file at path *p*. The hash algorithm specified by *type* must be one
      of `"md5"`, `"sha1"`, `"sha256"` or `"sha512"`.

## Documentation for `readFileType`

*Function `readFileType` defined at NO_SOURCE_PATH:0:0*

Determine the directory entry type of a filesystem node, being
      one of `"directory"`, `"regular"`, `"symlink"`, or `"unknown"`.

## Documentation for `readDir`

*Function `readDir` defined at NO_SOURCE_PATH:0:0*

Return the contents of the directory *path* as a set mapping
      directory entries to the corresponding file type. For instance, if
      directory `A` contains a regular file `B` and another directory
      `C`, then `builtins.readDir ./A` returns the set

      ```nix
      { B = "regular"; C = "directory"; }
      ```

      The possible values for the file type are `"regular"`,
      `"directory"`, `"symlink"` and `"unknown"`.

## Documentation for `toXML`

*Function `toXML` defined at NO_SOURCE_PATH:0:0*

Return a string containing an XML representation of *e*. The main
      application for `toXML` is to communicate information with the
      builder in a more structured format than plain environment
      variables.

      Here is an example where this is the case:

      ```nix
      { stdenv, fetchurl, libxslt, jira, uberwiki }:

      stdenv.mkDerivation (rec {
        name = "web-server";

        buildInputs = [ libxslt ];

        builder = builtins.toFile "builder.sh" "
          source $stdenv/setup
          mkdir $out
          echo "$servlets" | xsltproc ${stylesheet} - > $out/server-conf.xml ①
        ";

        stylesheet = builtins.toFile "stylesheet.xsl" ②
         "<?xml version='1.0' encoding='UTF-8'?>
          <xsl:stylesheet xmlns:xsl='http://www.w3.org/1999/XSL/Transform' version='1.0'>
            <xsl:template match='/'>
              <Configure>
                <xsl:for-each select='/expr/list/attrs'>
                  <Call name='addWebApplication'>
                    <Arg><xsl:value-of select=\"attr[@name = 'path']/string/@value\" /></Arg>
                    <Arg><xsl:value-of select=\"attr[@name = 'war']/path/@value\" /></Arg>
                  </Call>
                </xsl:for-each>
              </Configure>
            </xsl:template>
          </xsl:stylesheet>
        ";

        servlets = builtins.toXML [ ③
          { path = "/bugtracker"; war = jira + "/lib/atlassian-jira.war"; }
          { path = "/wiki"; war = uberwiki + "/uberwiki.war"; }
        ];
      })
      ```

      The builder is supposed to generate the configuration file for a
      [Jetty servlet container](http://jetty.mortbay.org/). A servlet
      container contains a number of servlets (`*.war` files) each
      exported under a specific URI prefix. So the servlet configuration
      is a list of sets containing the `path` and `war` of the servlet
      (①). This kind of information is difficult to communicate with the
      normal method of passing information through an environment
      variable, which just concatenates everything together into a
      string (which might just work in this case, but wouldn’t work if
      fields are optional or contain lists themselves). Instead the Nix
      expression is converted to an XML representation with `toXML`,
      which is unambiguous and can easily be processed with the
      appropriate tools. For instance, in the example an XSLT stylesheet
      (at point ②) is applied to it (at point ①) to generate the XML
      configuration file for the Jetty server. The XML representation
      produced at point ③ by `toXML` is as follows:

      ```xml
      <?xml version='1.0' encoding='utf-8'?>
      <expr>
        <list>
          <attrs>
            <attr name="path">
              <string value="/bugtracker" />
            </attr>
            <attr name="war">
              <path value="/nix/store/d1jh9pasa7k2...-jira/lib/atlassian-jira.war" />
            </attr>
          </attrs>
          <attrs>
            <attr name="path">
              <string value="/wiki" />
            </attr>
            <attr name="war">
              <path value="/nix/store/y6423b1yi4sx...-uberwiki/uberwiki.war" />
            </attr>
          </attrs>
        </list>
      </expr>
      ```

      Note that we used the `toFile` built-in to write the builder and
      the stylesheet “inline” in the Nix expression. The path of the
      stylesheet is spliced into the builder using the syntax `xsltproc
      ${stylesheet}`.

## Documentation for `toJSON`

*Function `toJSON` defined at NO_SOURCE_PATH:0:0*

Return a string containing a JSON representation of *e*. Strings,
      integers, floats, booleans, nulls and lists are mapped to their JSON
      equivalents. Sets (except derivations) are represented as objects.
      Derivations are translated to a JSON string containing the
      derivation’s output path. Paths are copied to the store and
      represented as a JSON string of the resulting store path.

## Documentation for `fromJSON`

*Function `fromJSON` defined at NO_SOURCE_PATH:0:0*

Convert a JSON string to a Nix value. For example,

      ```nix
      builtins.fromJSON ''{"x": [1, 2, 3], "y": null}''
      ```

      returns the value `{ x = [ 1 2 3 ]; y = null; }`.

## Documentation for `toFile`

*Function `toFile` defined at NO_SOURCE_PATH:0:0*

Store the string *s* in a file in the Nix store and return its
      path.  The file has suffix *name*. This file can be used as an
      input to derivations. One application is to write builders
      “inline”. For instance, the following Nix expression combines the
      Nix expression for GNU Hello and its build script into one file:

      ```nix
      { stdenv, fetchurl, perl }:

      stdenv.mkDerivation {
        name = "hello-2.1.1";

        builder = builtins.toFile "builder.sh" "
          source $stdenv/setup

          PATH=$perl/bin:$PATH

          tar xvfz $src
          cd hello-*
          ./configure --prefix=$out
          make
          make install
        ";

        src = fetchurl {
          url = "http://ftp.nluug.nl/pub/gnu/hello/hello-2.1.1.tar.gz";
          sha256 = "1md7jsfd8pa45z73bz1kszpp01yw6x5ljkjk2hx7wl800any6465";
        };
        inherit perl;
      }
      ```

      It is even possible for one file to refer to another, e.g.,

      ```nix
      builder = let
        configFile = builtins.toFile "foo.conf" "
          # This is some dummy configuration file.
          ...
        ";
      in builtins.toFile "builder.sh" "
        source $stdenv/setup
        ...
        cp ${configFile} $out/etc/foo.conf
      ";
      ```

      Note that `${configFile}` is a
      [string interpolation](@docroot@/language/types.md#type-string), so the result of the
      expression `configFile`
      (i.e., a path like `/nix/store/m7p7jfny445k...-foo.conf`) will be
      spliced into the resulting string.

      It is however *not* allowed to have files mutually referring to each
      other, like so:

      ```nix
      let
        foo = builtins.toFile "foo" "...${bar}...";
        bar = builtins.toFile "bar" "...${foo}...";
      in foo
      ```

      This is not allowed because it would cause a cyclic dependency in
      the computation of the cryptographic hashes for `foo` and `bar`.

      It is also not possible to reference the result of a derivation. If
      you are using Nixpkgs, the `writeTextFile` function is able to do
      that.

## Documentation for `filterSource`

*Function `filterSource` defined at NO_SOURCE_PATH:0:0*

> **Warning**
      >
      > `filterSource` should not be used to filter store paths. Since
      > `filterSource` uses the name of the input directory while naming
      > the output directory, doing so produces a directory name in
      > the form of `<hash2>-<hash>-<name>`, where `<hash>-<name>` is
      > the name of the input directory. Since `<hash>` depends on the
      > unfiltered directory, the name of the output directory
      > indirectly depends on files that are filtered out by the
      > function. This triggers a rebuild even when a filtered out
      > file is changed. Use `builtins.path` instead, which allows
      > specifying the name of the output directory.

      This function allows you to copy sources into the Nix store while
      filtering certain files. For instance, suppose that you want to use
      the directory `source-dir` as an input to a Nix expression, e.g.

      ```nix
      stdenv.mkDerivation {
        ...
        src = ./source-dir;
      }
      ```

      However, if `source-dir` is a Subversion working copy, then all of
      those annoying `.svn` subdirectories are also copied to the
      store. Worse, the contents of those directories may change a lot,
      causing lots of spurious rebuilds. With `filterSource` you can
      filter out the `.svn` directories:

      ```nix
      src = builtins.filterSource
        (path: type: type != "directory" || baseNameOf path != ".svn")
        ./source-dir;
      ```

      Thus, the first argument *e1* must be a predicate function that is
      called for each regular file, directory or symlink in the source
      tree *e2*. If the function returns `true`, the file is copied to the
      Nix store, otherwise it is omitted. The function is called with two
      arguments. The first is the full path of the file. The second is a
      string that identifies the type of the file, which is either
      `"regular"`, `"directory"`, `"symlink"` or `"unknown"` (for other
      kinds of files such as device nodes or fifos — but note that those
      cannot be copied to the Nix store, so if the predicate returns
      `true` for them, the copy fails). If you exclude a directory,
      the entire corresponding subtree of *e2* is excluded.

## Documentation for `attrNames`

*Function `attrNames` defined at NO_SOURCE_PATH:0:0*

Return the names of the attributes in the set *set* in an
      alphabetically sorted list. For instance, `builtins.attrNames { y
      = 1; x = "foo"; }` evaluates to `[ "x" "y" ]`.

      Has `O(n log n)` time complexity, where `n` is number of attributes in the *set*.

## Documentation for `attrValues`

*Function `attrValues` defined at NO_SOURCE_PATH:0:0*

Return the values of the attributes in the set *set* in the order
      corresponding to the sorted attribute names.

      Has `O(n log n)` time complexity, where `n` is number of attributes in the *set*.

## Documentation for `getAttr`

*Function `getAttr` defined at NO_SOURCE_PATH:0:0*

`getAttr` returns the attribute named *s* from *set*. Evaluation
      aborts if the attribute doesn’t exist. This is a dynamic version of
      the `.` operator, since *s* is an expression rather than an
      identifier.

      Has `O(log n)` time complexity, where `n` is number of attributes in the *set*.

## Documentation for `unsafeGetAttrPos`

*Function `unsafeGetAttrPos` defined at NO_SOURCE_PATH:0:0*

`unsafeGetAttrPos` returns the position of the attribute named *s*
      from *set*. This is used by Nixpkgs to provide location information
      in error messages.

## Documentation for `hasAttr`

*Function `hasAttr` defined at NO_SOURCE_PATH:0:0*

`hasAttr` returns `true` if *set* has an attribute named *s*, and
      `false` otherwise. This is a dynamic version of the `?` operator,
      since *s* is an expression rather than an identifier.

      Has `O(log n)` time complexity, where `n` is number of attributes in the *set*.

## Documentation for `isAttrs`

*Function `isAttrs` defined at NO_SOURCE_PATH:0:0*

Return `true` if *e* evaluates to a set, and `false` otherwise.

## Documentation for `removeAttrs`

*Function `removeAttrs` defined at NO_SOURCE_PATH:0:0*

Remove the attributes listed in *list* from *set*. The attributes
      don’t have to exist in *set*. For instance,

      ```nix
      removeAttrs { x = 1; y = 2; z = 3; } [ "a" "x" "z" ]
      ```

      evaluates to `{ y = 2; }`.

      Has `O(n + k log k)` time complexity, where `n` is number of attributes in the *set* and `k` is the size of *list*.

## Documentation for `listToAttrs`

*Function `listToAttrs` defined at NO_SOURCE_PATH:0:0*

Construct a set from a list specifying the names and values of each
      attribute. Each element of the list should be a set consisting of a
      string-valued attribute `name` specifying the name of the attribute,
      and an attribute `value` specifying its value.

      In case of duplicate occurrences of the same name, the first
      takes precedence.

      Example:

      ```nix
      builtins.listToAttrs
        [ { name = "foo"; value = 123; }
          { name = "bar"; value = 456; }
          { name = "bar"; value = 420; }
        ]
      ```

      evaluates to

      ```nix
      { foo = 123; bar = 456; }
      ```

      Has `O(n log n)` time complexity, where `n` is size of the list.

## Documentation for `intersectAttrs`

*Function `intersectAttrs` defined at NO_SOURCE_PATH:0:0*

Return a set consisting of the attributes in the set *e2* which have the
      same name as some attribute in *e1*.

      Has `O(n log m)` time complexity, where `n` and `m` are the sizes of the smallest and largest set respectively.

## Documentation for `catAttrs`

*Function `catAttrs` defined at NO_SOURCE_PATH:0:0*

Collect each attribute named *attr* from a list of attribute
      sets.  Attrsets that don't contain the named attribute are
      ignored. For example,

      ```nix
      builtins.catAttrs "a" [{a = 1;} {b = 0;} {a = 2;}]
      ```

      evaluates to `[1 2]`.

      Has `O(n)` time complexity, where `n` is the size of the *list*.

## Documentation for `functionArgs`

*Function `` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/trivial.nix:1109:5*

NO_DOC_CONTENT

## Documentation for `mapAttrs`

*Function `mapAttrs` defined at NO_SOURCE_PATH:0:0*

Apply function *f* to every element of *attrset*. For example,

      ```nix
      builtins.mapAttrs (name: value: value * 10) { a = 1; b = 2; }
      ```

      evaluates to `{ a = 10; b = 20; }`.

      Has `O(n)` time complexity, where `n` is the size of the *attrset*.
      Note that no calls to *f* are performed by the builtin.
      The function *f* is called on demand when a resulting attribute value is evaluated.

## Documentation for `zipAttrsWith`

*Function `zipAttrsWith` defined at NO_SOURCE_PATH:0:0*

Transpose a list of attribute sets into an attribute set of lists,
      then apply `mapAttrs`.

      `f` receives two arguments: the attribute name and a non-empty
      list of all values encountered for that attribute name.

      The result is an attribute set where the attribute names are the
      union of the attribute names in each element of `list`. The attribute
      values are the return values of `f`.

      ```nix
      builtins.zipAttrsWith
        (name: values: { inherit name values; })
        [ { a = "x"; } { a = "y"; b = "z"; } ]
      ```

      evaluates to

      ```
      {
        a = { name = "a"; values = [ "x" "y" ]; };
        b = { name = "b"; values = [ "z" ]; };
      }
      ```

      Has `O(n log n)` time complexity, where `n` is the number of attributes across all sets.

## Documentation for `isList`

*Function `isList` defined at NO_SOURCE_PATH:0:0*

Return `true` if *e* evaluates to a list, and `false` otherwise.

## Documentation for `elemAt`

*Function `elemAt` defined at NO_SOURCE_PATH:0:0*

Return element *n* from the list *xs*. Elements are counted starting
      from 0. A fatal error occurs if the index is out of bounds.

## Documentation for `head`

*Function `head` defined at NO_SOURCE_PATH:0:0*

Return the first element of a list; abort evaluation if the argument
      isn’t a list or is an empty list. You can test whether a list is
      empty by comparing it with `[]`.

      Has constant time complexity.

## Documentation for `tail`

*Function `tail` defined at NO_SOURCE_PATH:0:0*

Return the list without its first item; abort evaluation if
      the argument isn’t a list or is an empty list.

      > **Warning**
      >
      > This function should generally be avoided since it's inefficient:
      > unlike Haskell's `tail`, it takes O(n) time, so recursing over a
      > list by repeatedly calling `tail` takes O(n^2) time.

## Documentation for `map`

*Function `map` defined at NO_SOURCE_PATH:0:0*

Apply the function *f* to each element in the list *list*. For
      example,

      ```nix
      map (x: "foo" + x) [ "bar" "bla" "abc" ]
      ```

      evaluates to `[ "foobar" "foobla" "fooabc" ]`.

      Has `O(n)` time complexity, where `n` is the size of the *list*.
      Note that no calls to *f* are performed by the builtin, but *f* itself is evaluated and its type is checked eagerly.
      The function *f* is called on demand when a resulting list element is evaluated.

## Documentation for `filter`

*Function `filter` defined at NO_SOURCE_PATH:0:0*

Return a list consisting of the elements of *list* for which the
      function *f* returns `true`.
      Has linear time complexity in the size of the input *list*.

## Documentation for `elem`

*Function `elem` defined at NO_SOURCE_PATH:0:0*

Return `true` if a value equal to *x* occurs in the list *xs*, and
      `false` otherwise.
      Short-circuits and does not evaluate elements that occur in the list after the first match.

## Documentation for `concatLists`

*Function `concatLists` defined at NO_SOURCE_PATH:0:0*

Concatenate a list of lists into a single list.

## Documentation for `length`

*Function `length` defined at NO_SOURCE_PATH:0:0*

Return the length of the list *e*.

## Documentation for `foldl'`

*Function `` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:282:5*

NO_DOC_CONTENT

## Documentation for `any`

*Function `any` defined at NO_SOURCE_PATH:0:0*

Return `true` if the function *pred* returns `true` for at least one
      element of *list*, and `false` otherwise.
      Short-circuits and does not evaluate elements that appear later in the list if `pred` evaluates to `true`.

## Documentation for `all`

*Function `all` defined at NO_SOURCE_PATH:0:0*

Return `true` if the function *pred* returns `true` for all elements
      of *list*, and `false` otherwise.
      Short-circuits and does not evaluate elements that appear later in the list if `pred` evaluates to `false`.

## Documentation for `genList`

*Function `genList` defined at NO_SOURCE_PATH:0:0*

Generate list of size *length*, with each element *i* equal to the
      value returned by *generator* `i`. For example,

      ```nix
      builtins.genList (x: x * x) 5
      ```

      returns the list `[ 0 1 4 9 16 ]`.

      Has linear time complexity.

## Documentation for `sort`

*Function `sort` defined at NO_SOURCE_PATH:0:0*

Return *list* in sorted order. It repeatedly calls the function
      *comparator* with two elements. The comparator should return `true`
      if the first element is less than the second, and `false` otherwise.
      For example,

      ```nix
      builtins.sort builtins.lessThan [ 483 249 526 147 42 77 ]
      ```

      produces the list `[ 42 77 147 249 483 526 ]`.

      This is a stable sort: it preserves the relative order of elements
      deemed equal by the comparator.

      *comparator* must impose a strict weak ordering on the set of values
      in the *list*. This means that for any elements *a*, *b* and *c* from the
      *list*, *comparator* must satisfy the following relations:

        1. Transitivity

        If a is less than b and b is less than c, then it follows that a is less than c.

        ```nix
        comparator a b && comparator b c -> comparator a c
        ```

        1. Irreflexivity

        ```nix
        comparator a a == false
        ```

        1. Transitivity of equivalence

        First, two values a and b are considered equivalent with respect to the comparator if:

        ```
        !comparator a b && !comparator b a
        ```

        In other words, neither is considered "less than" the other.

        Transitivity of equivalence means:

        If a is equivalent to b, and b is equivalent to c, then a must also be equivalent to c.

        ```nix
        let
          equiv = x: y: (!comparator x y && !comparator y x);
        in
          equiv a b && equiv b c -> equiv a c
        ```

      If the *comparator* violates any of these properties, then `builtins.sort`
      reorders elements in an unspecified manner.

      Runs in `O(n log n)` time on average, where `n` is the size of the *list*.
      Uses an adaptive sort that exploits existing sorted runs in the input, down to `O(n)` when the list is already sorted.

## Documentation for `partition`

*Function `partition` defined at NO_SOURCE_PATH:0:0*

Given a predicate function *pred*, this function returns an
      attrset containing a list named `right`, containing the elements
      in *list* for which *pred* returned `true`, and a list named
      `wrong`, containing the elements for which it returned
      `false`. For example,

      ```nix
      builtins.partition (x: x > 10) [1 23 9 3 42]
      ```

      evaluates to

      ```nix
      { right = [ 23 42 ]; wrong = [ 1 9 3 ]; }
      ```

      Runs in linear time in the size of the *list*.

## Documentation for `groupBy`

*Function `groupBy` defined at NO_SOURCE_PATH:0:0*

Groups elements of *list* together by the string returned from the
      function *f* called on each element. It returns an attribute set
      where each attribute value contains the elements of *list* that are
      mapped to the same corresponding attribute name returned by *f*.

      For example,

      ```nix
      builtins.groupBy (builtins.substring 0 1) ["foo" "bar" "baz"]
      ```

      evaluates to

      ```nix
      { b = [ "bar" "baz" ]; f = [ "foo" ]; }
      ```

      Has `O(n log n)` time complexity, where `n` is the size of the input *list*.

## Documentation for `concatMap`

*Function `concatMap` defined at NO_SOURCE_PATH:0:0*

This function is equivalent to `builtins.concatLists (map f list)`
      but is more efficient.

## Documentation for `add`

*Function `add` defined at NO_SOURCE_PATH:0:0*

Return the sum of the numbers *e1* and *e2*.

## Documentation for `sub`

*Function `sub` defined at NO_SOURCE_PATH:0:0*

Return the difference between the numbers *e1* and *e2*.

## Documentation for `mul`

*Function `mul` defined at NO_SOURCE_PATH:0:0*

Return the product of the numbers *e1* and *e2*.

## Documentation for `div`

*Function `div` defined at NO_SOURCE_PATH:0:0*

Return the quotient of the numbers *e1* and *e2*.

## Documentation for `bitAnd`

*Function `bitAnd` defined at NO_SOURCE_PATH:0:0*

Return the bitwise AND of the integers *e1* and *e2*.

## Documentation for `bitOr`

*Function `bitOr` defined at NO_SOURCE_PATH:0:0*

Return the bitwise OR of the integers *e1* and *e2*.

## Documentation for `bitXor`

*Function `bitXor` defined at NO_SOURCE_PATH:0:0*

Return the bitwise XOR of the integers *e1* and *e2*.

## Documentation for `lessThan`

*Function `lessThan` defined at NO_SOURCE_PATH:0:0*

Return `true` if the value *e1* is less than the value *e2*, and `false` otherwise.
      Evaluation aborts if either *e1* or *e2* does not evaluate to a number, string or path.
      Furthermore, it aborts if *e2* does not match *e1*'s type according to the aforementioned classification of number, string or path.

## Documentation for `toString`

*Function `toString` defined at NO_SOURCE_PATH:0:0*

Convert the expression *e* to a string. *e* can be:

        - A string (in which case the string is returned unmodified).

        - A path (e.g., `toString /foo/bar` yields `"/foo/bar"`.

        - A set containing `{ __toString = self: ...; }` or `{ outPath = ...; }`.

        - An integer.

        - A list, in which case the string representations of its elements
          are joined with spaces.

        - A Boolean (`false` yields `""`, `true` yields `"1"`).

        - `null`, which yields the empty string.

## Documentation for `substring`

*Function `substring` defined at NO_SOURCE_PATH:0:0*

Return the substring of *s* from byte position *start*
      (zero-based) up to but not including *start + len*. If *start* is
      greater than the length of the string, an empty string is returned.
      If *start + len* lies beyond the end of the string or *len* is `-1`,
      only the substring up to the end of the string is returned.
      *start* must be non-negative.
      For example,

      ```nix
      builtins.substring 0 3 "nixos"
      ```

      evaluates to `"nix"`.

## Documentation for `stringLength`

*Function `stringLength` defined at NO_SOURCE_PATH:0:0*

Return the number of bytes of the string *e*. If *e* is not a string,
      evaluation is aborted.

## Documentation for `hashString`

*Function `hashString` defined at NO_SOURCE_PATH:0:0*

Return a base-16 representation of the cryptographic hash of string
      *s*. The hash algorithm specified by *type* must be one of `"md5"`,
      `"sha1"`, `"sha256"` or `"sha512"`.

## Documentation for `convertHash`

*Function `convertHash` defined at NO_SOURCE_PATH:0:0*

Return the specified representation of a hash string, based on the attributes presented in *args*:

      - `hash`

        The hash to be converted.
        The hash format is detected automatically.

      - `hashAlgo`

        The algorithm used to create the hash. Must be one of
        - `"md5"`
        - `"sha1"`
        - `"sha256"`
        - `"sha512"`

        The attribute may be omitted when `hash` is an [SRI hash](https://www.w3.org/TR/SRI/#the-integrity-attribute) or when the hash is prefixed with the hash algorithm name followed by a colon.
        That `<hashAlgo>:<hashBody>` syntax is supported for backwards compatibility with existing tooling.

      - `toHashFormat`

        The format of the resulting hash. Must be one of
        - `"base16"`
        - `"nix32"`
        - `"base32"` (deprecated alias for `"nix32"`)
        - `"base64"`
        - `"sri"`

      The result hash is the *toHashFormat* representation of the hash *hash*.

      > **Example**
      >
      >   Convert a SHA256 hash in Base16 to SRI:
      >
      > ```nix
      > builtins.convertHash {
      >   hash = "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855";
      >   toHashFormat = "sri";
      >   hashAlgo = "sha256";
      > }
      > ```
      >
      >     "sha256-47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU="

      > **Example**
      >
      >   Convert a SHA256 hash in SRI to Base16:
      >
      > ```nix
      > builtins.convertHash {
      >   hash = "sha256-47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=";
      >   toHashFormat = "base16";
      > }
      > ```
      >
      >     "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

      > **Example**
      >
      >   Convert a hash in the form `<hashAlgo>:<hashBody>` in Base16 to SRI:
      >
      > ```nix
      > builtins.convertHash {
      >   hash = "sha256:e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855";
      >   toHashFormat = "sri";
      > }
      > ```
      >
      >     "sha256-47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU="

## Documentation for `match`

*Function `match` defined at NO_SOURCE_PATH:0:0*

Returns a list if the [extended POSIX regular
      expression](http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap09.html#tag_09_04)
      *regex* matches *str* precisely, otherwise returns `null`. Each item
      in the list is a regex group.

      ```nix
      builtins.match "ab" "abc"
      ```

      Evaluates to `null`.

      ```nix
      builtins.match "abc" "abc"
      ```

      Evaluates to `[ ]`.

      ```nix
      builtins.match "a(b)(c)" "abc"
      ```

      Evaluates to `[ "b" "c" ]`.

      ```nix
      builtins.match "[[:space:]]+([[:upper:]]+)[[:space:]]+" "  FOO   "
      ```

      Evaluates to `[ "FOO" ]`.

## Documentation for `split`

*Function `split` defined at NO_SOURCE_PATH:0:0*

Returns a list composed of non matched strings interleaved with the
      lists of the [extended POSIX regular
      expression](http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap09.html#tag_09_04)
      *regex* matches of *str*. Each item in the lists of matched
      sequences is a regex group.

      ```nix
      builtins.split "(a)b" "abc"
      ```

      Evaluates to `[ "" [ "a" ] "c" ]`.

      ```nix
      builtins.split "([ac])" "abc"
      ```

      Evaluates to `[ "" [ "a" ] "b" [ "c" ] "" ]`.

      ```nix
      builtins.split "(a)|(c)" "abc"
      ```

      Evaluates to `[ "" [ "a" null ] "b" [ null "c" ] "" ]`.

      ```nix
      builtins.split "([[:upper:]]+)" " FOO "
      ```

      Evaluates to `[ " " [ "FOO" ] " " ]`.

## Documentation for `concatStringsSep`

*Function `concatStringsSep` defined at NO_SOURCE_PATH:0:0*

Concatenate a list of strings with a separator between each
      element, e.g. `concatStringsSep "/" ["usr" "local" "bin"] ==
      "usr/local/bin"`.

## Documentation for `replaceStrings`

*Function `replaceStrings` defined at NO_SOURCE_PATH:0:0*

Given string *s*, replace every occurrence of the strings in *from*
      with the corresponding string in *to*.

      The argument *to* is lazy, that is, it is only evaluated when its corresponding pattern in *from* is matched in the string *s*

      Example:

      ```nix
      builtins.replaceStrings ["oo" "a"] ["a" "i"] "foobar"
      ```

      evaluates to `"fabir"`.

      Has `O(n k)` time complexity, where `n` is the length of *s* and `k` is the number of replacements.

## Documentation for `parseDrvName`

*Function `parseDrvName` defined at NO_SOURCE_PATH:0:0*

Split the string *s* into a package name and version. The package
      name is everything up to but not including the first dash not followed
      by a letter, and the version is everything following that dash. The
      result is returned in a set `{ name, version }`. Thus,
      `builtins.parseDrvName "nix-0.12pre12876"` returns `{ name =
      "nix"; version = "0.12pre12876"; }`.

## Documentation for `compareVersions`

*Function `compareVersions` defined at NO_SOURCE_PATH:0:0*

Compare two strings representing versions and return `-1` if
      version *s1* is older than version *s2*, `0` if they are the same,
      and `1` if *s1* is newer than *s2*. The version comparison
      algorithm is the same as the one used by [`nix-env
      -u`](../command-ref/nix-env/upgrade.md).

## Documentation for `splitVersion`

*Function `splitVersion` defined at NO_SOURCE_PATH:0:0*

Split a string representing a version into its components, by the
      same version splitting logic underlying the version comparison in
      [`nix-env -u`](../command-ref/nix-env/upgrade.md).

## Documentation for `unsafeDiscardStringContext`

*Function `unsafeDiscardStringContext` defined at NO_SOURCE_PATH:0:0*

Discard the [string context](@docroot@/language/string-context.md) from a value that can be coerced to a string.

## Documentation for `hasContext`

*Function `hasContext` defined at NO_SOURCE_PATH:0:0*

Return `true` if string *s* has a non-empty context.
      The context can be obtained with
      [`getContext`](#builtins-getContext).

      > **Example**
      >
      > Many operations require a string context to be empty because they are intended only to work with "regular" strings, and also to help users avoid unintentionally loosing track of string context elements.
      > `builtins.hasContext` can help create better domain-specific errors in those case.
      >
      > ```nix
      > name: meta:
      >
      > if builtins.hasContext name
      > then throw "package name cannot contain string context"
      > else { ${name} = meta; }
      > ```

## Documentation for `unsafeDiscardOutputDependency`

*Function `unsafeDiscardOutputDependency` defined at NO_SOURCE_PATH:0:0*

Create a copy of the given string where every
      [derivation deep](@docroot@/language/string-context.md#string-context-element-derivation-deep)
      string context element is turned into a
      [constant](@docroot@/language/string-context.md#string-context-constant)
      string context element.

      This is the opposite of [`builtins.addDrvOutputDependencies`](#builtins-addDrvOutputDependencies).

      This is unsafe because it allows us to "forget" store objects we would have otherwise referred to with the string context,
      whereas Nix normally tracks all dependencies consistently.
      Safe operations "grow" but never "shrink" string contexts.
      [`builtins.addDrvOutputDependencies`] in contrast is safe because "derivation deep" string context element always refers to the underlying derivation (among many more things).
      Replacing a constant string context element with a "derivation deep" element is a safe operation that just enlargens the string context without forgetting anything.

      [`builtins.addDrvOutputDependencies`]: #builtins-addDrvOutputDependencies

## Documentation for `addDrvOutputDependencies`

*Function `addDrvOutputDependencies` defined at NO_SOURCE_PATH:0:0*

Create a copy of the given string where a single
      [constant](@docroot@/language/string-context.md#string-context-constant)
      string context element is turned into a
      [derivation deep](@docroot@/language/string-context.md#string-context-element-derivation-deep)
      string context element.

      The store path that is the constant string context element should point to a valid derivation, and end in `.drv`.

      The original string context element must not be empty or have multiple elements, and it must not have any other type of element other than a constant or derivation deep element.
      The latter is supported so this function is idempotent.

      This is the opposite of [`builtins.unsafeDiscardOutputDependency`](#builtins-unsafeDiscardOutputDependency).

## Documentation for `getContext`

*Function `getContext` defined at NO_SOURCE_PATH:0:0*

Return the string context of *s*.

      The string context tracks references to derivations within a string.
      It is represented as an attribute set of [store derivation](@docroot@/glossary.md#gloss-store-derivation) paths mapping to output names.

      Using [string interpolation](@docroot@/language/string-interpolation.md) on a derivation adds that derivation to the string context.
      For example,

      ```nix
      builtins.getContext "${derivation { name = "a"; builder = "b"; system = "c"; }}"
      ```

      evaluates to

      ```
      { "/nix/store/arhvjaf6zmlyn8vh8fgn55rpwnxq0n7l-a.drv" = { outputs = [ "out" ]; }; }
      ```

## Documentation for `fromTOML`

*Function `fromTOML` defined at NO_SOURCE_PATH:0:0*

Convert a TOML string to a Nix value. For example,

      ```nix
      builtins.fromTOML ''
        x=1
        s="a"
        [table]
        y=2
      ''
      ```

      returns the value `{ s = "a"; table = { y = 2; }; x = 1; }`.

## Documentation for `extend`

*Function `extend` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/default.nix:40:18*

Patch the Nixpkgs library

A function that applies patches onto the nixpkgs library.
Usage is discouraged for most scenarios.

:::{.note}
The name `extends` is a bit misleading, as it doesn't actually extend the library, but rather patches it.
It is merely a consequence of being implemented by `makeExtensible`.
:::

# Inputs

- An "extension function" `f` that returns attributes that will be updated in the returned Nixpkgs library.

# Output

A patched Nixpkgs library.

:::{.warning}
This functionality is intended as an escape hatch for when the provided version of the Nixpkgs library has a flaw.

If you were to use it to add new functionality, you will run into compatibility and interoperability issues.
:::

## Documentation for `throwIfNot`

*Function `throwIfNot` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/trivial.nix:982:16*

Like the `assert b; e` expression, but with a custom error message and
without the semicolon.

If true, return the identity function, `r: r`.

If false, throw the error message.

Calls can be juxtaposed using function application, as `(r: r) a = a`, so
`(r: r) (r: r) a = a`, and so forth.

# Inputs

`cond`

: 1\. Function argument

`msg`

: 2\. Function argument

# Type

```
throwIfNot :: Bool -> String -> a -> (a | Never)
```

# Examples
:::{.example}
## `lib.trivial.throwIfNot` usage example

```nix
throwIfNot (lib.isList overlays) "The overlays argument to nixpkgs must be a list."
lib.foldr (x: throwIfNot (lib.isFunction x) "All overlays passed to nixpkgs must be functions.") (r: r) overlays
pkgs
```

:::

## Documentation for `throwIf`

*Function `throwIf` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/trivial.nix:1003:13*

Like `throwIfNot`, but negated (throw if the first argument is `true`).

# Inputs

`cond`

: 1\. Function argument

`msg`

: 2\. Function argument

# Type

```
throwIf :: Bool -> String -> a -> (a | Never)
```

## Documentation for `evalModules`

*Function `evalModules` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/modules.nix:92:5*

See https://nixos.org/manual/nixpkgs/unstable/#module-system-lib-evalModules
or file://./../doc/module-system/module-system.chapter.md

!!! Please think twice before adding to this argument list! The more
that is specified here instead of in the modules themselves the harder
it is to transparently move a set of modules to be a submodule of another
config (as the proper arguments need to be replicated at each call to
evalModules) and the less declarative the module set is.

## Documentation for `concatMapStringsSep`

*Function `concatMapStringsSep` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:261:5*

Maps a function over a list of strings and then concatenates the
result with the specified separator interspersed between
elements.

# Inputs

`sep`
: Separator to add between elements

`f`
: Function to map over the list

`list`
: List of input strings

# Type

```
concatMapStringsSep :: String -> (a -> String) -> [a] -> String
```

# Examples
:::{.example}
## `lib.strings.concatMapStringsSep` usage example

```nix
concatMapStringsSep "-" (x: toUpper x)  ["foo" "bar" "baz"]
=> "FOO-BAR-BAZ"
```

:::

## Documentation for `showWarnings`

*Function `showWarnings` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/trivial.nix:1051:18*

NO_DOC_CONTENT

## Documentation for `makeExtensible`

*Function `makeExtensibleWithCustomName` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/fixed-points.nix:451:19*

Same as `makeExtensible` but the name of the extending attribute is
customized.

# Inputs

`extenderName`

: 1\. Function argument

`rattrs`

: 2\. Function argument

## Documentation for `extends`

*Function `extends` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/fixed-points.nix:326:5*

Extend a function using an overlay.

Overlays allow modifying and extending fixed-point functions, specifically ones returning attribute sets.
A fixed-point function is a function which is intended to be evaluated by passing the result of itself as the argument.
This is possible due to Nix's lazy evaluation.

A fixed-point function returning an attribute set has the form

```nix
final: {
  # attributes
}
```

where `final` refers to the lazily evaluated attribute set returned by the fixed-point function.

An overlay to such a fixed-point function has the form

```nix
final: prev: {
  # attributes
}
```

where `prev` refers to the result of the original function to `final`, and `final` is the result of the composition of the overlay and the original function.

Applying an overlay is done with `extends`:

```nix
let
  f = final: {
    # attributes
  };
  overlay = final: prev: {
    # attributes
  };
in extends overlay f;
```

To get the value of `final`, use `lib.fix`:

```nix
let
  f = final: {
    # attributes
  };
  overlay = final: prev: {
    # attributes
  };
  g = extends overlay f;
in fix g
```

:::{.note}
The argument to the given fixed-point function after applying an overlay will *not* refer to its own return value, but rather to the value after evaluating the overlay function.

The given fixed-point function is called with a separate argument than if it was evaluated with `lib.fix`.
:::

:::{.example}

# Extend a fixed-point function with an overlay

Define a fixed-point function `f` that expects its own output as the argument `final`:

```nix-repl
f = final: {
  # Constant value a
  a = 1;

  # b depends on the final value of a, available as final.a
  b = final.a + 2;
}
```

Evaluate this using [`lib.fix`](#function-library-lib.fixedPoints.fix) to get the final result:

```nix-repl
fix f
=> { a = 1; b = 3; }
```

An overlay represents a modification or extension of such a fixed-point function.
Here's an example of an overlay:

```nix-repl
overlay = final: prev: {
  # Modify the previous value of a, available as prev.a
  a = prev.a + 10;

  # Extend the attribute set with c, letting it depend on the final values of a and b
  c = final.a + final.b;
}
```

Use `extends overlay f` to apply the overlay to the fixed-point function `f`.
This produces a new fixed-point function `g` with the combined behavior of `f` and `overlay`:

```nix-repl
g = extends overlay f
```

The result is a function, so we can't print it directly, but it's the same as:

```nix-repl
g' = final: {
  # The constant from f, but changed with the overlay
  a = 1 + 10;

  # Unchanged from f
  b = final.a + 2;

  # Extended in the overlay
  c = final.a + final.b;
}
```

Evaluate this using [`lib.fix`](#function-library-lib.fixedPoints.fix) again to get the final result:

```nix-repl
fix g
=> { a = 11; b = 13; c = 24; }
```
:::

# Inputs

`overlay`

: The overlay to apply to the fixed-point function

`f`

: The fixed-point function

# Type

```
extends :: (AttrSet -> AttrSet -> AttrSet) # The overlay to apply to the fixed-point function
        -> (AttrSet -> AttrSet) # A fixed-point function
        -> (AttrSet -> AttrSet) # The resulting fixed-point function
```

# Examples
:::{.example}
## `lib.fixedPoints.extends` usage example

```nix
f = final: { a = 1; b = final.a + 2; }

fix f
=> { a = 1; b = 3; }

fix (extends (final: prev: { a = prev.a + 10; }) f)
=> { a = 11; b = 13; }

fix (extends (final: prev: { b = final.a + 5; }) f)
=> { a = 1; b = 6; }

fix (extends (final: prev: { c = final.a + final.b; }) f)
=> { a = 1; b = 3; c = 4; }
```

:::

## Documentation for `id`

*Function `id` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/trivial.nix:63:8*

The identity function
For when you need a function that does “nothing”.

# Inputs

`x`

: The value to return

# Type

```
id :: a -> a
```

## Documentation for `const`

*Function `const` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/trivial.nix:98:11*

The constant function

Ignores the second argument. If called with only one argument,
constructs a function that always returns a static value.

# Inputs

`x`

: Value to return

`y`

: Value to ignore

# Type

```
const :: a -> b -> a
```

# Examples
:::{.example}
## `lib.trivial.const` usage example

```nix
let f = const 5; in f 10
=> 5
```

:::

## Documentation for `concat`

*Function `concat` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/trivial.nix:191:12*

Concatenate two lists

# Inputs

`x`

: 1\. Function argument

`y`

: 2\. Function argument

# Type

```
concat :: [a] -> [a] -> [a]
```

# Examples
:::{.example}
## `lib.trivial.concat` usage example

```nix
concat [ 1 2 ] [ 3 4 ]
=> [ 1 2 3 4 ]
```

:::

## Documentation for `and`

*Function `and` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/trivial.nix:233:9*

boolean “and”

# Inputs

`x`

: 1\. Function argument

`y`

: 2\. Function argument

# Type

```
and :: Bool -> Bool -> Bool
```

## Documentation for `xor`

*Function `xor` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/trivial.nix:256:9*

boolean “exclusive or”

# Inputs

`x`

: 1\. Function argument

`y`

: 2\. Function argument

# Type

```
xor :: bool -> bool -> bool
```

## Documentation for `boolToString`

*Function `boolToString` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/trivial.nix:288:18*

Convert a boolean to a string.

This function uses the strings "true" and "false" to represent
boolean values. Calling `toString` on a bool instead returns "1"
and "" (sic!).

# Inputs

`b`

: 1\. Function argument

# Type

```
boolToString :: Bool -> String
```

## Documentation for `boolToYesNo`

*Function `boolToYesNo` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/trivial.nix:308:17*

Converts a boolean to a string.

This function uses the strings "yes" and "no" to represent
boolean values.

# Inputs

`b`

: The boolean to convert

# Type

```
boolToYesNo :: Bool -> String
```

## Documentation for `mergeAttrs`

*Function `mergeAttrs` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/trivial.nix:340:16*

Merge two attribute sets shallowly, right side trumps left

# Inputs

`x`

: Left attribute set

`y`

: Right attribute set (higher precedence for equal keys)

# Type

```
mergeAttrs :: AttrSet -> AttrSet -> AttrSet
```

# Examples
:::{.example}
## `lib.trivial.mergeAttrs` usage example

```nix
mergeAttrs { a = 1; b = 2; } { b = 3; c = 4; }
=> { a = 1; b = 3; c = 4; }
```

:::

## Documentation for `flip`

*Function `flip` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/trivial.nix:377:5*

Flip the order of the arguments of a binary function.

# Inputs

`f`

: 1\. Function argument

`a`

: 2\. Function argument

`b`

: 3\. Function argument

# Type

```
flip :: (a -> b -> c) -> (b -> a -> c)
```

# Examples
:::{.example}
## `lib.trivial.flip` usage example

```nix
flip concat [1] [2]
=> [ 2 1 ]
```

:::

## Documentation for `defaultTo`

*Function `defaultTo` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/trivial.nix:414:15*

Returns `maybeValue` if not null, otherwise return `default`.

# Inputs

`default`

: 1\. Function argument

`maybeValue`

: 2\. Function argument

# Type

```
defaultTo :: a -> (b | Null) -> (b | a)
```

# Examples
:::{.example}
## `lib.trivial.defaultTo` usage example

```nix
defaultTo "default" null
=> "default"
defaultTo "default" "foo"
=> "foo"
defaultTo "default" false
=> false
```

:::

## Documentation for `mapNullable`

*Function `mapNullable` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/trivial.nix:448:17*

Apply function if the supplied argument is non-null.

# Inputs

`f`

: Function to call

`a`

: Argument to check for null before passing it to `f`

# Type

```
mapNullable :: (a -> b) -> (a | Null) -> (b | Null)
```

# Examples
:::{.example}
## `lib.trivial.mapNullable` usage example

```nix
mapNullable (x: x+1) null
=> null
mapNullable (x: x+1) 22
=> 23
```

:::

## Documentation for `min`

*Function `min` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/trivial.nix:595:9*

Returns minimum of two numbers.

# Inputs

`x`

: 1\. Function argument

`y`

: 2\. Function argument

# Type

```
min :: Number -> Number -> Number
```

## Documentation for `max`

*Function `max` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/trivial.nix:616:9*

Returns maximum of two numbers.

# Inputs

`x`

: 1\. Function argument

`y`

: 2\. Function argument

# Type

```
max :: Number -> Number -> Number
```

## Documentation for `importJSON`

*Function `importJSON` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/trivial.nix:794:16*

Reads a JSON file.

# Examples
:::{.example}
## `lib.trivial.importJSON` usage example

example.json
```json
{
  "title": "Example JSON",
  "hello": {
    "world": "foo",
    "bar": {
      "foobar": true
    }
  }
}
```

```nix
importJSON ./example.json
=> {
  title = "Example JSON";
  hello = {
    world = "foo";
    bar = {
      foobar = true;
    };
  };
}
```

:::

# Inputs

`path`

: 1\. Function argument

# Type

```
importJSON :: Path -> Any
```

## Documentation for `importTOML`

*Function `importTOML` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/trivial.nix:841:16*

Reads a TOML file.

# Examples
:::{.example}
## `lib.trivial.importTOML` usage example

example.toml
```toml
title = "TOML Example"

[hello]
world = "foo"

[hello.bar]
foobar = true
```

```nix
importTOML ./example.toml
=> {
  title = "TOML Example";
  hello = {
    world = "foo";
    bar = {
      foobar = true;
    };
  };
}
```

:::

# Inputs

`path`

: 1\. Function argument

# Type

```
importTOML :: Path -> Any
```

## Documentation for `warnIf`

*Function `warnIf` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/trivial.nix:914:12*

`warnIf` *`condition`* *`message`* *`value`*

Like `warn`, but only warn when the first argument is `true`.

# Inputs

*`condition`* (Boolean)

: `true` to trigger the warning before continuing with *`value`*.

*`message`* (String)

: Warning message to print before evaluating

*`value`* (any value)

: Value to return as-is.

# Type

```
warnIf :: Bool -> String -> a -> a
```

## Documentation for `warnIfNot`

*Function `warnIfNot` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/trivial.nix:941:15*

`warnIfNot` *`condition`* *`message`* *`value`*

Like `warnIf`, but negated: warn if the first argument is `false`.

# Inputs

*`condition`*

: `false` to trigger the warning before continuing with `val`.

*`message`*

: Warning message to print before evaluating *`value`*.

*`value`*

: Value to return as-is.

# Type

```
warnIfNot :: Bool -> String -> a -> a
```

## Documentation for `checkListOfEnum`

*Function `checkListOfEnum` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/trivial.nix:1042:5*

Check if the elements in a list are valid values from a enum, returning the identity function, or throwing an error message otherwise.

# Inputs

`msg`

: 1\. Function argument

`valid`

: 2\. Function argument

`given`

: 3\. Function argument

# Type

```
checkListOfEnum :: String -> [a] -> [a] -> ((b -> b) | Never)
```

# Examples
:::{.example}
## `lib.trivial.checkListOfEnum` usage example

```nix
let colorVariants = ["bright" "dark" "black"]
in checkListOfEnum "color variants" [ "standard" "light" "dark" ] colorVariants;
=>
error: color variants: bright, black unexpected; valid ones: standard, light, dark
```

:::

## Documentation for `info`

*Function `info` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/trivial.nix:1049:10*

NO_DOC_CONTENT

## Documentation for `isInOldestRelease`

*Function `oldestSupportedReleaseIsAtLeast` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/trivial.nix:499:37*

Alias for `isInOldestRelease` introduced in 24.11.
Use `isInOldestRelease` in expressions outside of Nixpkgs for greater compatibility.

## Documentation for `oldestSupportedReleaseIsAtLeast`

*Function `oldestSupportedReleaseIsAtLeast` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/trivial.nix:499:37*

Alias for `isInOldestRelease` introduced in 24.11.
Use `isInOldestRelease` in expressions outside of Nixpkgs for greater compatibility.

## Documentation for `mod`

*Function `mod` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/trivial.nix:650:9*

Integer modulus

# Inputs

`base`

: 1\. Function argument

`int`

: 2\. Function argument

# Type

```
mod :: Int -> Int -> Int
```

# Examples
:::{.example}
## `lib.trivial.mod` usage example

```nix
mod 11 10
=> 1
mod 1 10
=> 1
```

:::

## Documentation for `compare`

*Function `compare` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/trivial.nix:678:5*

C-style comparisons

a < b,  compare a b => -1
a == b, compare a b => 0
a > b,  compare a b => 1

# Inputs

`a`

: 1\. Function argument

`b`

: 2\. Function argument

# Type

```
compare :: a -> a -> Int
```

## Documentation for `splitByAndCompare`

*Function `splitByAndCompare` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/trivial.nix:739:5*

Split type into two subtypes by predicate `p`, take all elements
of the first subtype to be less than all the elements of the
second subtype, compare elements of a single subtype with `yes`
and `no` respectively.

# Inputs

`p`

: Predicate

`yes`

: Comparison function if predicate holds for both values

`no`

: Comparison function if predicate holds for neither value

`a`

: First value to compare

`b`

: Second value to compare

# Type

```
splitByAndCompare :: (a -> Bool) -> (a -> a -> Int) -> (a -> a -> Int) -> (a -> a -> Int)
```

# Examples
:::{.example}
## `lib.trivial.splitByAndCompare` usage example

```nix
let cmp = splitByAndCompare (hasPrefix "foo") compare compare; in

cmp "a" "z" => -1
cmp "fooa" "fooz" => -1

cmp "f" "a" => 1
cmp "fooa" "a" => -1
# while
compare "fooa" "a" => 1
```

:::

## Documentation for `setFunctionArgs`

*Function `setFunctionArgs` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/trivial.nix:1081:21*

Add metadata about expected function arguments to a function.
The metadata should match the format given by
builtins.functionArgs, i.e. a set from expected argument to a bool
representing whether that argument has a default or not.

This function is necessary because you can't dynamically create a
function of the `{ a, b ? foo, ... }:` format, but some facilities
like `callPackage` expect to be able to query expected arguments.

# Inputs

`f`

: 1\. Function argument

`args`

: 2\. Function argument

# Type

```
setFunctionArgs : (a -> b) -> { [String] :: Bool } -> (a -> b)
```

## Documentation for `toFunction`

*Function `toFunction` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/trivial.nix:1211:16*

Turns any non-callable values into constant functions.
Returns callable values as is.

# Inputs

`v`

: Any value

# Examples
:::{.example}
## `lib.trivial.toFunction` usage example

```nix
nix-repl> lib.toFunction 1 2
1

nix-repl> lib.toFunction (x: x + 1) 2
3
```

:::

## Documentation for `mirrorFunctionArgs`

*Function `mirrorFunctionArgs` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/trivial.nix:1178:5*

`mirrorFunctionArgs f g` creates a new function `g'` with the same behavior as `g` (`g' x == g x`)
but its function arguments mirroring `f` (`lib.functionArgs g' == lib.functionArgs f`).

# Inputs

`f`

: Function to provide the argument metadata

`g`

: Function to set the argument metadata to

# Type

```
mirrorFunctionArgs :: (a -> b) -> (a -> c) -> (a -> c)
```

# Examples
:::{.example}
## `lib.trivial.mirrorFunctionArgs` usage example

```nix
addab = {a, b}: a + b
addab { a = 2; b = 4; }
=> 6
lib.functionArgs addab
=> { a = false; b = false; }
addab1 = attrs: addab attrs + 1
addab1 { a = 2; b = 4; }
=> 7
lib.functionArgs addab1
=> { }
addab1' = lib.mirrorFunctionArgs addab addab1
addab1' { a = 2; b = 4; }
=> 7
lib.functionArgs addab1'
=> { a = false; b = false; }
```

:::

## Documentation for `fromHexString`

*Function `fromHexString` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/trivial.nix:1235:5*

Convert a hexadecimal string to it's integer representation.

# Type

```
fromHexString :: String -> Int
```

# Examples
:::{.example}
## `lib.trivial.fromHexString` usage examples
```nix
fromHexString "FF"
=> 255

fromHexString "0x7fffffffffffffff"
=> 9223372036854775807
```
:::

## Documentation for `toHexString`

*Function `` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/trivial.nix:1286:5*

NO_DOC_CONTENT

## Documentation for `toBaseDigits`

*Function `toBaseDigits` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/trivial.nix:1322:5*

`toBaseDigits base i` converts the positive integer `i` to a list of its
digits in the given base.

# Inputs

`base`

: 1\. Function argument

`i`

: 2\. Function argument

# Type

```
toBaseDigits :: Int -> Int -> [Int]
```

# Examples
:::{.example}
## `lib.trivial.toBaseDigits`

```nix
toBaseDigits 10 123 => [ 1 2 3 ]

toBaseDigits 2 6 => [ 1 1 0 ]

toBaseDigits 16 250 => [ 15 10 ]
```
:::

## Documentation for `fix`

*Function `fix` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/fixed-points.nix:93:5*

`fix f` computes the fixed point of the given function `f`. In other words, the return value is `x` in `x = f x`.

`f` must be a lazy function.
This means that `x` must be a value that can be partially evaluated,
such as an attribute set, a list, or a function.
This way, `f` can use one part of `x` to compute another part.

**Relation to syntactic recursion**

This section explains `fix` by refactoring from syntactic recursion to a call of `fix` instead.

For context, Nix lets you define attributes in terms of other attributes syntactically using the [`rec { }` syntax](https://nixos.org/manual/nix/stable/language/constructs.html#recursive-sets).

```nix
nix-repl> rec {
  foo = "foo";
  bar = "bar";
  foobar = foo + bar;
}
{ bar = "bar"; foo = "foo"; foobar = "foobar"; }
```

This is convenient when constructing a value to pass to a function for example,
but an equivalent effect can be achieved with the `let` binding syntax:

```nix
nix-repl> let self = {
  foo = "foo";
  bar = "bar";
  foobar = self.foo + self.bar;
}; in self
{ bar = "bar"; foo = "foo"; foobar = "foobar"; }
```

But in general you can get more reuse out of `let` bindings by refactoring them to a function.

```nix
nix-repl> f = self: {
  foo = "foo";
  bar = "bar";
  foobar = self.foo + self.bar;
}
```

This is where `fix` comes in, it contains the syntactic recursion that's not in `f` anymore.

```nix
nix-repl> fix = f:
  let self = f self; in self;
```

By applying `fix` we get the final result.

```nix
nix-repl> fix f
{ bar = "bar"; foo = "foo"; foobar = "foobar"; }
```

Such a refactored `f` using `fix` is not useful by itself.
See [`extends`](#function-library-lib.fixedPoints.extends) for an example use case.
There `self` is also often called `final`.

# Inputs

`f`

: 1\. Function argument

# Type

```
fix :: (a -> a) -> a
```

# Examples
:::{.example}
## `lib.fixedPoints.fix` usage example

```nix
fix (self: { foo = "foo"; bar = "bar"; foobar = self.foo + self.bar; })
=> { bar = "bar"; foo = "foo"; foobar = "foobar"; }

fix (self: [ 1 2 (elemAt self 0 + elemAt self 1) ])
=> [ 1 2 3 ]
```

:::

## Documentation for `fix'`

*Function `fix'` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/fixed-points.nix:119:5*

A variant of `fix` that records the original recursive attribute set in the
result, in an attribute named `__unfix__`.

This is useful in combination with the `extends` function to
implement deep overriding.

# Inputs

`f`

: 1\. Function argument

# Type

```
fix' :: (a -> a) -> a
```

## Documentation for `converge`

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

## Documentation for `composeExtensions`

*Function `composeExtensions` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/fixed-points.nix:341:5*

Compose two overlay functions and return a single overlay function that combines them.
For more details see: [`composeManyExtensions`](#function-library-lib.fixedPoints.composeManyExtensions).

## Documentation for `composeManyExtensions`

*Function `foldr` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:138:14*

“right fold” a binary function `op` between successive elements of
`list` with `nul` as the starting value, i.e.,
`foldr op nul [x_1 x_2 ... x_n] == op x_1 (op x_2 ... (op x_n nul))`.

# Inputs

`op`

: 1\. Function argument

`nul`

: 2\. Function argument

`list`

: 3\. Function argument

# Type

```
foldr :: (a -> b -> b) -> b -> [a] -> b
```

# Examples
:::{.example}
## `lib.lists.foldr` usage example

```nix
concat = foldr (a: b: a + b) "z"
concat [ "a" "b" "c" ]
=> "abcz"
# different types
strange = foldr (int: str: toString (int + 1) + str) "a"
strange [ 1 2 3 4 ]
=> "2345a"
```

:::

## Documentation for `makeExtensibleWithCustomName`

*Function `makeExtensibleWithCustomName` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/fixed-points.nix:451:5*

Same as `makeExtensible` but the name of the extending attribute is
customized.

# Inputs

`extenderName`

: 1\. Function argument

`rattrs`

: 2\. Function argument

## Documentation for `toExtension`

*Function `toExtension` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/fixed-points.nix:513:5*

Convert to an extending function (overlay).

`toExtension` is the `toFunction` for extending functions (a.k.a. extensions or overlays).
It converts a non-function or a single-argument function to an extending function,
while returning a two-argument function as-is.

That is, it takes a value of the shape `x`, `prev: x`, or `final: prev: x`,
and returns `final: prev: x`, assuming `x` is not a function.

This function takes care of the input to `stdenv.mkDerivation`'s
`overrideAttrs` function.
It bridges the gap between `<pkg>.overrideAttrs`
before and after the overlay-style support.

# Inputs

`f`
: The function or value to convert to an extending function.

# Type

```
toExtension :: b' -> Any -> Any -> b'
or
toExtension :: (a -> b') -> Any -> a -> b'
or
toExtension :: (a -> a -> b) -> a -> a -> b
where b' = ! Callable

Set a = b = b' = AttrSet & ! Callable to make toExtension return an extending function.
```

# Examples
:::{.example}
## `lib.fixedPoints.toExtension` usage example

```nix
fix (final: { a = 0; c = final.a; })
=> { a = 0; c = 0; };

fix (extends (toExtension { a = 1; b = 2; }) (final: { a = 0; c = final.a; }))
=> { a = 1; b = 2; c = 1; };

fix (extends (toExtension (prev: { a = 1; b = prev.a; })) (final: { a = 0; c = final.a; }))
=> { a = 1; b = 0; c = 1; };

fix (extends (toExtension (final: prev: { a = 1; b = prev.a; c = final.a + 1 })) (final: { a = 0; c = final.a; }))
=> { a = 1; b = 0; c = 2; };
```
:::

## Documentation for `attrByPath`

*Function `attrByPath` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:89:5*

Returns an attribute from nested attribute sets.

Nix has an [attribute selection operator `.`](https://nixos.org/manual/nix/stable/language/operators#attribute-selection) which is sufficient for such queries, as long as the number of attributes is static. For example:

```nix
(x.a.b or 6) == attrByPath ["a" "b"] 6 x
# and
(x.${f p}."example.com" or 6) == attrByPath [ (f p) "example.com" ] 6 x
```

# Inputs

`attrPath`

: A list of strings representing the attribute path to return from `set`

`default`

: Default value if `attrPath` does not resolve to an existing value

`set`

: The nested attribute set to select values from

# Type

```
attrByPath :: [String] -> Any -> AttrSet -> Any
```

# Examples
:::{.example}
## `lib.attrsets.attrByPath` usage example

```nix
x = { a = { b = 3; }; }
# ["a" "b"] is equivalent to x.a.b
# 6 is a default value to return if the path does not exist in attrset
attrByPath ["a" "b"] 6 x
=> 3
attrByPath ["z" "z"] 6 x
=> 6
```

:::

## Documentation for `hasAttrByPath`

*Function `hasAttrByPath` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:157:5*

Returns if an attribute from nested attribute set exists.

Nix has a [has attribute operator `?`](https://nixos.org/manual/nix/stable/language/operators#has-attribute), which is sufficient for such queries, as long as the number of attributes is static. For example:

```nix
(x?a.b) == hasAttrByPath ["a" "b"] x
# and
(x?${f p}."example.com") == hasAttrByPath [ (f p) "example.com" ] x
```

**Laws**:
 1.  ```nix
     hasAttrByPath [] x == true
     ```

# Inputs

`attrPath`

: A list of strings representing the attribute path to check from `set`

`set`

: The nested attribute set to check

# Type

```
hasAttrByPath :: [String] -> AttrSet -> Bool
```

# Examples
:::{.example}
## `lib.attrsets.hasAttrByPath` usage example

```nix
x = { a = { b = 3; }; }
hasAttrByPath ["a" "b"] x
=> true
hasAttrByPath ["z" "z"] x
=> false
hasAttrByPath [] (throw "no need")
=> true
```

:::

## Documentation for `setAttrByPath`

*Function `setAttrByPath` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:286:5*

Create a new attribute set with `value` set at the nested attribute location specified in `attrPath`.

# Inputs

`attrPath`

: A list of strings representing the attribute path to set

`value`

: The value to set at the location described by `attrPath`

# Type

```
setAttrByPath :: [String] -> Any -> AttrSet
```

# Examples
:::{.example}
## `lib.attrsets.setAttrByPath` usage example

```nix
setAttrByPath ["a" "b"] 3
=> { a = { b = 3; }; }
```

:::

## Documentation for `getAttrFromPath`

*Function `getAttrFromPath` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:336:5*

Like `attrByPath`, but without a default value. If it doesn't find the
path it will throw an error.

Nix has an [attribute selection operator](https://nixos.org/manual/nix/stable/language/operators#attribute-selection) which is sufficient for such queries, as long as the number of attributes is static. For example:

```nix
x.a.b == getAttrFromPath ["a" "b"] x
# and
x.${f p}."example.com" == getAttrFromPath [ (f p) "example.com" ] x
```

# Inputs

`attrPath`

: A list of strings representing the attribute path to get from `set`

`set`

: The nested attribute set to find the value in.

# Type

```
getAttrFromPath :: [String] -> AttrSet -> Any
```

# Examples
:::{.example}
## `lib.attrsets.getAttrFromPath` usage example

```nix
x = { a = { b = 3; }; }
getAttrFromPath ["a" "b"] x
=> 3
getAttrFromPath ["z" "z"] x
=> error: cannot find attribute `z.z'
```

:::

## Documentation for `attrVals`

*Function `attrVals` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:535:14*

Returns the specified attributes from a set.

# Inputs

`nameList`

: The list of attributes to fetch from `set`. Each attribute name must exist on the attribute set

`set`

: The set to get attribute values from

# Type

```
attrVals :: [String] -> { [String] :: a } -> [a]
```

# Examples
:::{.example}
## `lib.attrsets.attrVals` usage example

```nix
attrVals ["a" "b" "c"] as
=> [as.a as.b as.c]
```

:::

## Documentation for `getAttrs`

*Function `getAttrs` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:591:14*

Given a set of attribute names, return the set of the corresponding
attributes from the given set.

# Inputs

`names`

: A list of attribute names to get out of `set`

`set`

: The set to get the named attributes from

# Type

```
getAttrs :: [String] -> { [String] :: a } -> { [String] :: a }
```

# Examples
:::{.example}
## `lib.attrsets.getAttrs` usage example

```nix
getAttrs [ "a" "b" ] { a = 1; b = 2; c = 3; }
=> { a = 1; b = 2; }
```

:::

## Documentation for `filterAttrs`

*Function `filterAttrs` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:667:17*

Filter an attribute set by removing all attributes for which the
given predicate return false.

# Inputs

`pred`

: Predicate taking an attribute name and an attribute value, which returns `true` to include the attribute, or `false` to exclude the attribute.

  <!-- TIP -->
  If possible, decide on `name` first and on `value` only if necessary.
  This avoids evaluating the value if the name is already enough, making it possible, potentially, to have the argument reference the return value.
  (Depending on context, that could still be considered a self reference by users; a common pattern in Nix.)

  <!-- TIP -->
  `filterAttrs` is occasionally the cause of infinite recursion in configuration systems that allow self-references.
  To support the widest range of user-provided logic, perform the `filterAttrs` call as late as possible.
  Typically that's right before using it in a derivation, as opposed to an implicit conversion whose result is accessible to the user's expressions.

`set`

: The attribute set to filter

# Type

```
filterAttrs :: (String -> a -> Bool) -> { [String] :: a } -> { [String] :: a }
```

# Examples
:::{.example}
## `lib.attrsets.filterAttrs` usage example

```nix
filterAttrs (n: v: n == "foo") { foo = 1; bar = 2; }
=> { foo = 1; }
```

:::

## Documentation for `filterAttrsRecursive`

*Function `filterAttrsRecursive` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:701:5*

Filter an attribute set recursively by removing all attributes for
which the given predicate return false.

# Inputs

`pred`

: Predicate taking an attribute name and an attribute value, which returns `true` to include the attribute, or `false` to exclude the attribute.

`set`

: The attribute set to filter

# Type

```
filterAttrsRecursive :: (String -> Any -> Bool) -> AttrSet -> AttrSet
```

# Examples
:::{.example}
## `lib.attrsets.filterAttrsRecursive` usage example

```nix
filterAttrsRecursive (n: v: v != null) { foo = { bar = null; }; }
=> { foo = {}; }
```

:::

## Documentation for `foldlAttrs`

*Function `foldlAttrs` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:796:5*

Like [`lib.lists.foldl'`](#function-library-lib.lists.foldl-prime) but for attribute sets.
Iterates over every name-value pair in the given attribute set.
The result of the callback function is often called `acc` for accumulator. It is passed between callbacks from left to right and the final `acc` is the return value of `foldlAttrs`.

::: {.note}
There is a completely different function `lib.foldAttrs`
which has nothing to do with this function, despite the similar name.
:::

# Inputs

`f`

: 1\. Function argument

`init`

: 2\. Function argument

`set`

: 3\. Function argument

# Type

```
foldlAttrs :: ( a -> String -> b -> a ) -> a -> { [String] :: b } -> a
```

# Examples
:::{.example}
## `lib.attrsets.foldlAttrs` usage example

```nix
foldlAttrs
  (acc: name: value: {
    sum = acc.sum + value;
    names = acc.names ++ [name];
  })
  { sum = 0; names = []; }
  {
    foo = 1;
    bar = 10;
  }
->
  {
    sum = 11;
    names = ["bar" "foo"];
  }

foldlAttrs
  (throw "function not needed")
  123
  {};
->
  123

foldlAttrs
  (acc: _: _: acc)
  3
  { z = throw "value not needed"; a = throw "value not needed"; };
->
  3

The accumulator doesn't have to be an attrset.
It can be as simple as a number or string.

foldlAttrs
  (acc: _: v: acc * 10 + v)
  1
  { z = 1; a = 2; };
->
  121
```

:::

## Documentation for `foldAttrs`

*Function `foldAttrs` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:834:5*

Apply fold functions to values grouped by key.

# Inputs

`op`

: A function, given a value and a collector combines the two.

`nul`

: The starting value.

`list_of_attrs`

: A list of attribute sets to fold together by key.

# Type

```
foldAttrs :: (a -> b -> b) -> b -> [{ [String] :: a }] -> { [String] :: b }
```

# Examples
:::{.example}
## `lib.attrsets.foldAttrs` usage example

```nix
foldAttrs (item: acc: [item] ++ acc) [] [{ a = 2; } { a = 3; }]
=> { a = [ 2 3 ]; }
```

:::

## Documentation for `collect`

*Function `collect` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:874:5*

Recursively collect sets that verify a given predicate named `pred`
from the set `attrs`. The recursion is stopped when the predicate is
verified.

# Inputs

`pred`

: Given an attribute's value, determine if recursion should stop.

`attrs`

: The attribute set to recursively collect.

# Type

```
collect :: (AttrSet -> Bool) -> AttrSet -> [Any]
```

# Examples
:::{.example}
## `lib.attrsets.collect` usage example

```nix
collect isList { a = { b = ["b"]; }; c = [1]; }
=> [["b"] [1]]

collect (x: x ? outPath)
   { a = { outPath = "a/"; }; b = { outPath = "b/"; }; }
=> [{ outPath = "a/"; } { outPath = "b/"; }]
```

:::

## Documentation for `nameValuePair`

*Function `nameValuePair` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:990:19*

Utility function that creates a `{name, value}` pair as expected by `builtins.listToAttrs`.

# Inputs

`name`

: Attribute name

`value`

: Attribute value

# Type

```
nameValuePair :: String -> a -> { name :: String; value :: a; }
```

# Examples
:::{.example}
## `lib.attrsets.nameValuePair` usage example

```nix
nameValuePair "some" 6
=> { name = "some"; value = 6; }
```

:::

## Documentation for `mapAttrs'`

*Function `mapAttrs'` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:1058:15*

Like `mapAttrs`, but allows the name of each attribute to be
changed in addition to the value.  The applied function should
return both the new name and value as a `nameValuePair`.

# Inputs

`f`

: A function, given an attribute's name and value, returns a new `nameValuePair`.

`set`

: Attribute set to map over.

# Type

```
mapAttrs' :: (String -> a -> { name :: String; value :: b; }) -> { [String] :: a } -> { [String] :: b }
```

# Examples
:::{.example}
## `lib.attrsets.mapAttrs'` usage example

```nix
mapAttrs' (name: value: nameValuePair ("foo_" + name) ("bar-" + value))
   { x = "a"; y = "b"; }
=> { foo_x = "bar-a"; foo_y = "bar-b"; }
```

:::

## Documentation for `mapAttrsToList`

*Function `mapAttrsToList` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:1092:20*

Call a function for each attribute in the given set and return
the result in a list.

# Inputs

`f`

: A function, given an attribute's name and value, returns a new value.

`attrs`

: Attribute set to map over.

# Type

```
mapAttrsToList :: (String -> a -> b) -> { [String] :: a } -> [b]
```

# Examples
:::{.example}
## `lib.attrsets.mapAttrsToList` usage example

```nix
mapAttrsToList (name: value: name + value)
   { x = "a"; y = "b"; }
=> [ "xa" "yb" ]
```

:::

## Documentation for `attrsToList`

*Function `mapAttrsToList` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:1092:23*

Call a function for each attribute in the given set and return
the result in a list.

# Inputs

`f`

: A function, given an attribute's name and value, returns a new value.

`attrs`

: Attribute set to map over.

# Type

```
mapAttrsToList :: (String -> a -> b) -> { [String] :: a } -> [b]
```

# Examples
:::{.example}
## `lib.attrsets.mapAttrsToList` usage example

```nix
mapAttrsToList (name: value: name + value)
   { x = "a"; y = "b"; }
=> [ "xa" "yb" ]
```

:::

## Documentation for `concatMapAttrs`

*Function `concatMapAttrs` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:375:5*

Map each attribute in the given set and merge them into a new attribute set.

# Inputs

`f`

: 1\. Function argument

`v`

: 2\. Function argument

# Type

```
concatMapAttrs :: (String -> Any -> AttrSet) -> AttrSet -> AttrSet
```

# Examples
:::{.example}
## `lib.attrsets.concatMapAttrs` usage example

```nix
concatMapAttrs
  (name: value: {
    ${name} = value;
    ${name + value} = value;
  })
  { x = "a"; y = "b"; }
=> { x = "a"; xa = "a"; y = "b"; yb = "b"; }
```

:::

## Documentation for `mapAttrsRecursive`

*Function `mapAttrsRecursiveCond` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:1190:11*

Like `mapAttrsRecursive`, but it takes an additional predicate that tells it whether to recurse into an attribute set.
If the predicate returns false, `mapAttrsRecursiveCond` does not recurse, but instead applies the mapping function.
If the predicate returns true, it does recurse, and does not apply the mapping function.

::: {.example #map-attrs-recursive-cond-example}
# Map over an leaf attributes defined by a condition

Map derivations to their `name` attribute.
Derivatons are identified as attribute sets that contain `{ type = "derivation"; }`.
```nix
mapAttrsRecursiveCond
  (as: !(as ? "type" && as.type == "derivation"))
  (path: x: x.name)
  attrs
```
:::

# Type
```
mapAttrsRecursiveCond :: (AttrSet -> Bool) -> ([String] -> a -> b) -> AttrSet -> AttrSet
```

## Documentation for `mapAttrsRecursiveCond`

*Function `mapAttrsRecursiveCond` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:1190:5*

Like `mapAttrsRecursive`, but it takes an additional predicate that tells it whether to recurse into an attribute set.
If the predicate returns false, `mapAttrsRecursiveCond` does not recurse, but instead applies the mapping function.
If the predicate returns true, it does recurse, and does not apply the mapping function.

::: {.example #map-attrs-recursive-cond-example}
# Map over an leaf attributes defined by a condition

Map derivations to their `name` attribute.
Derivatons are identified as attribute sets that contain `{ type = "derivation"; }`.
```nix
mapAttrsRecursiveCond
  (as: !(as ? "type" && as.type == "derivation"))
  (path: x: x.name)
  attrs
```
:::

# Type
```
mapAttrsRecursiveCond :: (AttrSet -> Bool) -> ([String] -> a -> b) -> AttrSet -> AttrSet
```

## Documentation for `mapAttrsToListRecursive`

*Function `mapAttrsToListRecursiveCond` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:1312:11*

Determine the nodes of a tree of nested attribute sets by applying a
predicate, then apply a function to the leaves, returning the results
as a list, ordered lexicographically by their attribute paths.

Like `mapAttrsToListRecursive`, but takes an additional predicate to
decide whether to recurse into an attribute set.

Unlike `mapAttrsRecursiveCond` this predicate receives the attribute path
as its first argument, in addition to the attribute set.

# Inputs

`pred`

: Predicate to decide whether to recurse into an attribute set.

  If the predicate returns true, `mapAttrsToListRecursiveCond` recurses into
  the attribute set. If the predicate returns false, it does not recurse
  but instead applies the mapping function, treating the attribute set as
  a leaf.

  The first argument to the predicate is a list of attribute names forming
  the path to the attribute set. The second argument is the attribute set.

`f`

: Mapping function which, given an attribute’s path and value, returns a
  new value.

  This value will be an element of the list returned by
  `mapAttrsToListRecursiveCond`.

  The first argument to the mapping function is a list of attribute names
  forming the path to the leaf attribute. The second argument is the leaf
  attribute value, which may be an attribute set if the predicate returned
  false.

`set`

: Attribute set to map over.

# Type
```
mapAttrsToListRecursiveCond :: ([String] -> AttrSet -> Bool) -> ([String] -> a -> b) -> AttrSet -> [b]
```

# Examples
:::{.example}
## `lib.attrsets.mapAttrsToListRecursiveCond` usage example

```nix
mapAttrsToListRecursiveCond
  (path: as: !(lib.isDerivation as))
  (path: value: "--set=${lib.concatStringsSep "." path}=${toString value}")
  {
    rust.optimize = 2;
    target = {
      riscv64-unknown-linux-gnu.linker = pkgs.lld;
    };
  }
=> [ "--set=rust.optimize=2" "--set=target.riscv64-unknown-linux-gnu.linker=/nix/store/sjw4h1k…" ]
```
:::

## Documentation for `mapAttrsToListRecursiveCond`

*Function `mapAttrsToListRecursiveCond` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:1312:5*

Determine the nodes of a tree of nested attribute sets by applying a
predicate, then apply a function to the leaves, returning the results
as a list, ordered lexicographically by their attribute paths.

Like `mapAttrsToListRecursive`, but takes an additional predicate to
decide whether to recurse into an attribute set.

Unlike `mapAttrsRecursiveCond` this predicate receives the attribute path
as its first argument, in addition to the attribute set.

# Inputs

`pred`

: Predicate to decide whether to recurse into an attribute set.

  If the predicate returns true, `mapAttrsToListRecursiveCond` recurses into
  the attribute set. If the predicate returns false, it does not recurse
  but instead applies the mapping function, treating the attribute set as
  a leaf.

  The first argument to the predicate is a list of attribute names forming
  the path to the attribute set. The second argument is the attribute set.

`f`

: Mapping function which, given an attribute’s path and value, returns a
  new value.

  This value will be an element of the list returned by
  `mapAttrsToListRecursiveCond`.

  The first argument to the mapping function is a list of attribute names
  forming the path to the leaf attribute. The second argument is the leaf
  attribute value, which may be an attribute set if the predicate returned
  false.

`set`

: Attribute set to map over.

# Type
```
mapAttrsToListRecursiveCond :: ([String] -> AttrSet -> Bool) -> ([String] -> a -> b) -> AttrSet -> [b]
```

# Examples
:::{.example}
## `lib.attrsets.mapAttrsToListRecursiveCond` usage example

```nix
mapAttrsToListRecursiveCond
  (path: as: !(lib.isDerivation as))
  (path: value: "--set=${lib.concatStringsSep "." path}=${toString value}")
  {
    rust.optimize = 2;
    target = {
      riscv64-unknown-linux-gnu.linker = pkgs.lld;
    };
  }
=> [ "--set=rust.optimize=2" "--set=target.riscv64-unknown-linux-gnu.linker=/nix/store/sjw4h1k…" ]
```
:::

## Documentation for `genAttrs`

*Function `genAttrs` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:1352:5*

Generate an attribute set by mapping a function over a list of
attribute names.

# Inputs

`names`

: Names of values in the resulting attribute set.

`f`

: A function, given the name of the attribute, returns the attribute's value.

# Type

```
genAttrs :: [String] -> (String -> a) -> { [String] :: a }
```

# Examples
:::{.example}
## `lib.attrsets.genAttrs` usage example

```nix
genAttrs [ "foo" "bar" ] (name: "x_" + name)
=> { foo = "x_foo"; bar = "x_bar"; }
```

:::

## Documentation for `genAttrs'`

*Function `genAttrs'` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:1395:15*

Like `genAttrs`, but allows the name of each attribute to be specified in addition to the value.
The applied function should return both the new name and value as a `nameValuePair`.
::: {.warning}
In case of attribute name collision the first entry determines the value,
all subsequent conflicting entries for the same name are silently ignored.
:::

# Inputs

`xs`

: A list of strings `s` used as generator.

`f`

: A function, given a string `s` from the list `xs`, returns a new `nameValuePair`.

# Type

```
genAttrs' :: [a] -> (a -> { name :: String; value :: b; }) -> { [String] :: b }
```

# Examples
:::{.example}
## `lib.attrsets.genAttrs'` usage example

```nix
genAttrs' [ "foo" "bar" ] (s: nameValuePair ("x_" + s) ("y_" + s))
=> { x_foo = "y_foo"; x_bar = "y_bar"; }
```

:::

## Documentation for `isDerivation`

*Function `isDerivation` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:1427:18*

Check whether the argument is a derivation. Any set with
`{ type = "derivation"; }` counts as a derivation.

# Inputs

`value`

: Value to check.

# Type

```
isDerivation :: Any -> Bool
```

# Examples
:::{.example}
## `lib.attrsets.isDerivation` usage example

```nix
nixpkgs = import <nixpkgs> {}
isDerivation nixpkgs.ruby
=> true
isDerivation "foobar"
=> false
```

:::

## Documentation for `toDerivation`

*Function `toDerivation` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:1445:5*

Converts a store path to a fake derivation.

# Inputs

`path`

: A store path to convert to a derivation.

# Type

```
toDerivation :: Path -> Derivation
```

## Documentation for `optionalAttrs`

*Function `optionalAttrs` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:1492:19*

If `cond` is true, return the attribute set `as`,
otherwise an empty attribute set.

# Inputs

`cond`

: Condition under which the `as` attribute set is returned.

`as`

: The attribute set to return if `cond` is `true`.

# Type

```
optionalAttrs :: Bool -> AttrSet -> AttrSet
```

# Examples
:::{.example}
## `lib.attrsets.optionalAttrs` usage example

```nix
optionalAttrs (true) { my = "set"; }
=> { my = "set"; }
optionalAttrs (false) { my = "set"; }
=> { }
```

:::

## Documentation for `zipAttrsWithNames`

*Function `zipAttrsWithNames` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:1530:5*

Merge sets of attributes and use the function `f` to merge attributes
values.

# Inputs

`names`

: List of attribute names to zip.

`f`

: A function, accepts an attribute name, all the values, and returns a combined value.

`sets`

: List of values from the list of attribute sets.

# Type

```
zipAttrsWithNames :: [String] -> (String -> [a] -> b) -> [{ [String] :: a }] -> { [String] :: b }
```

# Examples
:::{.example}
## `lib.attrsets.zipAttrsWithNames` usage example

```nix
zipAttrsWithNames ["a"] (name: vs: vs) [{a = "x";} {a = "y"; b = "z";}]
=> { a = ["x" "y"]; }
```

:::

## Documentation for `recursiveUpdateUntil`

*Function `recursiveUpdateUntil` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:1719:5*

Update `lhs` so that `rhs` wins for any given attribute path that occurs in both.

Unlike the `//` (update) operator, which operates on a single attribute set,
This function views its operands `lhs` and `rhs` as a mapping from attribute *paths*
to values.

The caller-provided function `pred` decides whether any given path is one of the following:

- `true`: a value in the mapping
- `false`: an attribute set whose purpose is to create the nesting structure.

# Inputs

`pred`

: Predicate function (of type `List String -> Any -> Any -> Bool`)

  Inputs:

  - `path : List String`: the path to the current attribute as a list of strings for attribute names
  - `lhsAtPath : Any`: the value at that path in `lhs`; same as `getAttrFromPath path lhs`
  - `rhsAtPath : Any`: the value at that path in `rhs`; same as `getAttrFromPath path rhs`

  Output:

  - `true`: `path` points to a value in the mapping, and `rhsAtPath` will appear in the return value of `recursiveUpdateUntil`
  - `false`: `path` is part of the nesting structure and will be an attrset in the return value of `recursiveUpdateUntil`

  `pred` is only called for `path`s that extend prefixes for which `pred` returned `false`.

`lhs`

: Left attribute set of the update.

`rhs`

: Right attribute set of the update.

# Type

```
recursiveUpdateUntil :: ([String] -> AttrSet -> AttrSet -> Bool) -> AttrSet -> AttrSet -> AttrSet
```

# Examples
:::{.example}
## `lib.attrsets.recursiveUpdateUntil` usage example

```nix
recursiveUpdateUntil (path: lhs: rhs: path == ["foo"]) {
  # left attribute set
  foo.bar = 1;
  foo.baz = 2;
  bar = 3;
} {
  # right attribute set
  foo.bar = 1;
  foo.quz = 2;
  baz = 4;
}

=> {
  foo.bar = 1; # 'foo.*' from the 'right' set
  foo.quz = 2; #
  bar = 3;     # 'bar' from the 'left' set
  baz = 4;     # 'baz' from the 'right' set
}
```

:::

## Documentation for `recursiveUpdate`

*Function `recursiveUpdate` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:1779:5*

A recursive variant of the update operator `//`.  The recursion
stops when one of the attribute values is not an attribute set,
in which case the right hand side value takes precedence over the
left hand side value.

# Inputs

`lhs`

: Left attribute set of the merge.

`rhs`

: Right attribute set of the merge.

# Type

```
recursiveUpdate :: AttrSet -> AttrSet -> AttrSet
```

# Examples
:::{.example}
## `lib.attrsets.recursiveUpdate` usage example

```nix
recursiveUpdate {
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/hda";
} {
  boot.loader.grub.device = "";
}

returns: {
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "";
}
```

:::

## Documentation for `matchAttrs`

*Function `` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:1837:5*

NO_DOC_CONTENT

## Documentation for `mergeAttrsList`

*Function `mergeAttrsList` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:1623:5*

Merge a list of attribute sets together using the `//` operator.
In case of duplicate attributes, values from later list elements take precedence over earlier ones.
The result is the same as `foldl mergeAttrs { }`, but the performance is better for large inputs.
For n list elements, each with an attribute set containing m unique attributes, the complexity of this operation is O(nm log n).

# Inputs

`list`

: 1\. Function argument

# Type

```
mergeAttrsList :: [AttrSet] -> AttrSet
```

# Examples
:::{.example}
## `lib.attrsets.mergeAttrsList` usage example

```nix
mergeAttrsList [ { a = 0; b = 1; } { c = 2; d = 3; } ]
=> { a = 0; b = 1; c = 2; d = 3; }
mergeAttrsList [ { a = 0; } { a = 1; } ]
=> { a = 1; }
```

:::

## Documentation for `overrideExisting`

*Function `overrideExisting` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:1876:22*

Override only the attributes that are already present in the old set
useful for deep-overriding.

# Inputs

`old`

: Original attribute set

`new`

: Attribute set with attributes to override in `old`.

# Type

```
overrideExisting :: AttrSet -> AttrSet -> AttrSet
```

# Examples
:::{.example}
## `lib.attrsets.overrideExisting` usage example

```nix
overrideExisting {} { a = 1; }
=> {}
overrideExisting { b = 2; } { a = 1; }
=> { b = 2; }
overrideExisting { a = 3; b = 2; } { a = 1; }
=> { a = 1; b = 2; }
```

:::

## Documentation for `showAttrPath`

*Function `showAttrPath` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:1910:5*

Turns a list of strings into a human-readable description of those
strings represented as an attribute path. The result of this function is
not intended to be machine-readable.
Create a new attribute set with `value` set at the nested attribute location specified in `attrPath`.

# Inputs

`path`

: Attribute path to render to a string

# Type

```
showAttrPath :: [String] -> String
```

# Examples
:::{.example}
## `lib.attrsets.showAttrPath` usage example

```nix
showAttrPath [ "foo" "10" "bar" ]
=> "foo.\"10\".bar"
showAttrPath []
=> "<root attribute path>"
```

:::

## Documentation for `getOutput`

*Function `getOutput` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:1946:5*

Get a package output.
If no output is found, fallback to `.out` and then to the default.
The function is idempotent: `getOutput "b" (getOutput "a" p) == getOutput "a" p`.

# Inputs

`output`

: 1\. Function argument

`pkg`

: 2\. Function argument

# Type

```
getOutput :: String -> :: Derivation -> Derivation
```

# Examples
:::{.example}
## `lib.attrsets.getOutput` usage example

```nix
"${getOutput "dev" pkgs.openssl}"
=> "/nix/store/9rz8gxhzf8sw4kf2j2f1grr49w8zx5vj-openssl-1.0.1r-dev"
```

:::

## Documentation for `getFirstOutput`

*Function `getFirstOutput` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:1982:5*

Get the first of the `outputs` provided by the package, or the default.
This function is aligned with `_overrideFirst()` from the `multiple-outputs.sh` setup hook.
Like `getOutput`, the function is idempotent.

# Inputs

`outputs`

: 1\. Function argument

`pkg`

: 2\. Function argument

# Type

```
getFirstOutput :: [String] -> Derivation -> Derivation
```

# Examples
:::{.example}
## `lib.attrsets.getFirstOutput` usage example

```nix
"${getFirstOutput [ "include" "dev" ] pkgs.openssl}"
=> "/nix/store/00000000000000000000000000000000-openssl-1.0.1r-dev"
```

:::

## Documentation for `getBin`

*Function `getOutput` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:1946:13*

Get a package output.
If no output is found, fallback to `.out` and then to the default.
The function is idempotent: `getOutput "b" (getOutput "a" p) == getOutput "a" p`.

# Inputs

`output`

: 1\. Function argument

`pkg`

: 2\. Function argument

# Type

```
getOutput :: String -> :: Derivation -> Derivation
```

# Examples
:::{.example}
## `lib.attrsets.getOutput` usage example

```nix
"${getOutput "dev" pkgs.openssl}"
=> "/nix/store/9rz8gxhzf8sw4kf2j2f1grr49w8zx5vj-openssl-1.0.1r-dev"
```

:::

## Documentation for `getLib`

*Function `getOutput` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:1946:13*

Get a package output.
If no output is found, fallback to `.out` and then to the default.
The function is idempotent: `getOutput "b" (getOutput "a" p) == getOutput "a" p`.

# Inputs

`output`

: 1\. Function argument

`pkg`

: 2\. Function argument

# Type

```
getOutput :: String -> :: Derivation -> Derivation
```

# Examples
:::{.example}
## `lib.attrsets.getOutput` usage example

```nix
"${getOutput "dev" pkgs.openssl}"
=> "/nix/store/9rz8gxhzf8sw4kf2j2f1grr49w8zx5vj-openssl-1.0.1r-dev"
```

:::

## Documentation for `getStatic`

*Function `getFirstOutput` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:1982:17*

Get the first of the `outputs` provided by the package, or the default.
This function is aligned with `_overrideFirst()` from the `multiple-outputs.sh` setup hook.
Like `getOutput`, the function is idempotent.

# Inputs

`outputs`

: 1\. Function argument

`pkg`

: 2\. Function argument

# Type

```
getFirstOutput :: [String] -> Derivation -> Derivation
```

# Examples
:::{.example}
## `lib.attrsets.getFirstOutput` usage example

```nix
"${getFirstOutput [ "include" "dev" ] pkgs.openssl}"
=> "/nix/store/00000000000000000000000000000000-openssl-1.0.1r-dev"
```

:::

## Documentation for `getDev`

*Function `getOutput` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:1946:13*

Get a package output.
If no output is found, fallback to `.out` and then to the default.
The function is idempotent: `getOutput "b" (getOutput "a" p) == getOutput "a" p`.

# Inputs

`output`

: 1\. Function argument

`pkg`

: 2\. Function argument

# Type

```
getOutput :: String -> :: Derivation -> Derivation
```

# Examples
:::{.example}
## `lib.attrsets.getOutput` usage example

```nix
"${getOutput "dev" pkgs.openssl}"
=> "/nix/store/9rz8gxhzf8sw4kf2j2f1grr49w8zx5vj-openssl-1.0.1r-dev"
```

:::

## Documentation for `getInclude`

*Function `getFirstOutput` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:1982:17*

Get the first of the `outputs` provided by the package, or the default.
This function is aligned with `_overrideFirst()` from the `multiple-outputs.sh` setup hook.
Like `getOutput`, the function is idempotent.

# Inputs

`outputs`

: 1\. Function argument

`pkg`

: 2\. Function argument

# Type

```
getFirstOutput :: [String] -> Derivation -> Derivation
```

# Examples
:::{.example}
## `lib.attrsets.getFirstOutput` usage example

```nix
"${getFirstOutput [ "include" "dev" ] pkgs.openssl}"
=> "/nix/store/00000000000000000000000000000000-openssl-1.0.1r-dev"
```

:::

## Documentation for `getMan`

*Function `getOutput` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:1946:13*

Get a package output.
If no output is found, fallback to `.out` and then to the default.
The function is idempotent: `getOutput "b" (getOutput "a" p) == getOutput "a" p`.

# Inputs

`output`

: 1\. Function argument

`pkg`

: 2\. Function argument

# Type

```
getOutput :: String -> :: Derivation -> Derivation
```

# Examples
:::{.example}
## `lib.attrsets.getOutput` usage example

```nix
"${getOutput "dev" pkgs.openssl}"
=> "/nix/store/9rz8gxhzf8sw4kf2j2f1grr49w8zx5vj-openssl-1.0.1r-dev"
```

:::

## Documentation for `recurseIntoAttrs`

*Function `` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:2227:5*

NO_DOC_CONTENT

## Documentation for `dontRecurseIntoAttrs`

*Function `` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:2250:5*

NO_DOC_CONTENT

## Documentation for `cartesianProduct`

*Function `cartesianProduct` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:919:5*

Return the cartesian product of attribute set value combinations.

# Inputs

`attrsOfLists`

: Attribute set with attributes that are lists of values

# Type

```
cartesianProduct :: { [String] :: [a] } -> [{ [String] :: a }]
```

# Examples
:::{.example}
## `lib.attrsets.cartesianProduct` usage example

```nix
cartesianProduct { a = [ 1 2 ]; b = [ 10 20 ]; }
=> [
     { a = 1; b = 10; }
     { a = 1; b = 20; }
     { a = 2; b = 10; }
     { a = 2; b = 20; }
   ]
```

:::

## Documentation for `mapCartesianProduct`

*Function `mapCartesianProduct` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:958:25*

Return the result of function `f` applied to the cartesian product of attribute set value combinations.
Equivalent to using `cartesianProduct` followed by `map`.

# Inputs

`f`

: A function, given an attribute set, it returns a new value.

`attrsOfLists`

: Attribute set with attributes that are lists of values

# Type

```
mapCartesianProduct :: ({ [String] :: a } -> b) -> { [String] :: a } -> [b]
```

# Examples
:::{.example}
## `lib.attrsets.mapCartesianProduct` usage example

```nix
mapCartesianProduct ({a, b}: "${a}-${b}") { a = [ "1" "2" ]; b = [ "3" "4" ]; }
=> [ "1-3" "1-4" "2-3" "2-4" ]
```

:::

## Documentation for `updateManyAttrsByPath`

*Function `` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/attrsets.nix:503:5*

NO_DOC_CONTENT

## Documentation for `singleton`

*Function `singleton` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:59:15*

Create a list consisting of a single element. `singleton x` is
sometimes more convenient with respect to indentation than `[x]`
when x spans multiple lines.

# Inputs

`x`

: 1\. Function argument

# Type

```
singleton :: a -> [a]
```

# Examples
:::{.example}
## `lib.lists.singleton` usage example

```nix
singleton "foo"
=> [ "foo" ]
```

:::

## Documentation for `forEach`

*Function `forEach` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:94:13*

Apply the function to each element in the list.
Same as `map`, but arguments flipped.

# Inputs

`xs`

: 1\. Function argument

`f`

: 2\. Function argument

# Type

```
forEach :: [a] -> (a -> b) -> [b]
```

# Examples
:::{.example}
## `lib.lists.forEach` usage example

```nix
forEach [ 1 2 ] (x:
  toString x
)
=> [ "1" "2" ]
```

:::

## Documentation for `foldr`

*Function `foldr` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:138:5*

“right fold” a binary function `op` between successive elements of
`list` with `nul` as the starting value, i.e.,
`foldr op nul [x_1 x_2 ... x_n] == op x_1 (op x_2 ... (op x_n nul))`.

# Inputs

`op`

: 1\. Function argument

`nul`

: 2\. Function argument

`list`

: 3\. Function argument

# Type

```
foldr :: (a -> b -> b) -> b -> [a] -> b
```

# Examples
:::{.example}
## `lib.lists.foldr` usage example

```nix
concat = foldr (a: b: a + b) "z"
concat [ "a" "b" "c" ]
=> "abcz"
# different types
strange = foldr (int: str: toString (int + 1) + str) "a"
strange [ 1 2 3 4 ]
=> "2345a"
```

:::

## Documentation for `fold`

*Function `foldr` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:138:5*

“right fold” a binary function `op` between successive elements of
`list` with `nul` as the starting value, i.e.,
`foldr op nul [x_1 x_2 ... x_n] == op x_1 (op x_2 ... (op x_n nul))`.

# Inputs

`op`

: 1\. Function argument

`nul`

: 2\. Function argument

`list`

: 3\. Function argument

# Type

```
foldr :: (a -> b -> b) -> b -> [a] -> b
```

# Examples
:::{.example}
## `lib.lists.foldr` usage example

```nix
concat = foldr (a: b: a + b) "z"
concat [ "a" "b" "c" ]
=> "abcz"
# different types
strange = foldr (int: str: toString (int + 1) + str) "a"
strange [ 1 2 3 4 ]
=> "2345a"
```

:::

## Documentation for `foldl`

*Function `foldl` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:196:5*

“left fold”, like `foldr`, but from the left:

`foldl op nul [x_1 x_2 ... x_n] == op (... (op (op nul x_1) x_2) ... x_n)`.

# Inputs

`op`

: 1\. Function argument

`nul`

: 2\. Function argument

`list`

: 3\. Function argument

# Type

```
foldl :: (b -> a -> b) -> b -> [a] -> b
```

# Examples
:::{.example}
## `lib.lists.foldl` usage example

```nix
lconcat = foldl (a: b: a + b) "z"
lconcat [ "a" "b" "c" ]
=> "zabc"
# different types
lstrange = foldl (str: int: str + toString (int + 1)) "a"
lstrange [ 1 2 3 4 ]
=> "a2345"
```

:::

## Documentation for `imap0`

*Function `imap0` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:318:11*

Map with index starting from 0

# Inputs

`f`

: 1\. Function argument

`list`

: 2\. Function argument

# Type

```
imap0 :: (Int -> a -> b) -> [a] -> [b]
```

# Examples
:::{.example}
## `lib.lists.imap0` usage example

```nix
imap0 (i: v: "${v}-${toString i}") ["a" "b"]
=> [ "a-0" "b-1" ]
```

:::

## Documentation for `imap1`

*Function `imap1` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:350:11*

Map with index starting from 1

# Inputs

`f`

: 1\. Function argument

`list`

: 2\. Function argument

# Type

```
imap1 :: (Int -> a -> b) -> [a] -> [b]
```

# Examples
:::{.example}
## `lib.lists.imap1` usage example

```nix
imap1 (i: v: "${v}-${toString i}") ["a" "b"]
=> [ "a-1" "b-2" ]
```

:::

## Documentation for `ifilter0`

*Function `ifilter0` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:392:5*

Filter a list for elements that satisfy a predicate function.
The predicate function is called with both the index and value for each element.
It must return `true`/`false` to include/exclude a given element in the result.
This function is strict in the result of the predicate function for each element.
This function has O(n) complexity.

Also see [`builtins.filter`](https://nixos.org/manual/nix/stable/language/builtins.html#builtins-filter) (available as `lib.lists.filter`),
which can be used instead when the index isn't needed.

# Inputs

`ipred`

: The predicate function, it takes two arguments:
  - 1. (int): the index of the element.
  - 2. (a): the value of the element.

  It must return `true`/`false` to include/exclude a given element from the result.

`list`

: The list to filter using the predicate.

# Type
```
ifilter0 :: (Int -> a -> Bool) -> [a] -> [a]
```

# Examples
:::{.example}
## `lib.lists.ifilter0` usage example

```nix
ifilter0 (i: v: i == 0 || v > 2) [ 1 2 3 ]
=> [ 1 3 ]
```
:::

## Documentation for `flatten`

*Function `flatten` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:448:13*

Flatten the argument into a single list; that is, nested lists are
spliced into the top-level lists.

# Inputs

`x`

: 1\. Function argument

# Type

```
flatten :: [a | [a | [a | ...]]] -> [a]
```

# Examples
:::{.example}
## `lib.lists.flatten` usage example

```nix
flatten [1 [2 [3] 4] 5]
=> [1 2 3 4 5]
flatten 1
=> [1]
```

:::

## Documentation for `remove`

*Function `remove` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:480:12*

Remove elements equal to `e` from a list.  Useful for `buildInputs`.

# Inputs

`e`

: Element to remove from `list`

`list`

: The list

# Type

```
remove :: a -> [a] -> [a]
```

# Examples
:::{.example}
## `lib.lists.remove` usage example

```nix
remove 3 [ 1 3 4 3 ]
=> [ 1 4 ]
```

:::

## Documentation for `findSingle`

*Function `findSingle` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:529:5*

Find the sole element in the list matching the specified
predicate.

Returns `default` if no such element exists, or
`multiple` if there are multiple matching elements.

# Inputs

`pred`

: Predicate

`default`

: Default value to return if element was not found.

`multiple`

: Default value to return if more than one element was found

`list`

: Input list

# Type

```
findSingle :: (a -> Bool) -> a -> a -> [a] -> a
```

# Examples
:::{.example}
## `lib.lists.findSingle` usage example

```nix
findSingle (x: x == 3) "none" "multiple" [ 1 3 3 ]
=> "multiple"
findSingle (x: x == 3) "none" "multiple" [ 1 3 ]
=> 3
findSingle (x: x == 3) "none" "multiple" [ 1 9 ]
=> "none"
```

:::

## Documentation for `findFirst`

*Function `` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:654:5*

NO_DOC_CONTENT

## Documentation for `count`

*Function `count` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:769:11*

Count how many elements of `list` match the supplied predicate
function.

# Inputs

`pred`

: Predicate

# Type

```
count :: (a -> Bool) -> [a] -> Int
```

# Examples
:::{.example}
## `lib.lists.count` usage example

```nix
count (x: x == 3) [ 3 2 3 4 6 ]
=> 2
```

:::

## Documentation for `optional`

*Function `optional` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:805:14*

Return a singleton list or an empty list, depending on a boolean
value.  Useful when building lists with optional elements
(e.g. `++ optional (system == "i686-linux") firefox`).

# Inputs

`cond`

: 1\. Function argument

`elem`

: 2\. Function argument

# Type

```
optional :: Bool -> a -> [a]
```

# Examples
:::{.example}
## `lib.lists.optional` usage example

```nix
optional true "foo"
=> [ "foo" ]
optional false "foo"
=> [ ]
```

:::

## Documentation for `optionals`

*Function `optionals` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:839:15*

Returns a list or an empty list, depending on a boolean value.

# Inputs

`cond`

: Condition

`elems`

: List to return if condition is true

# Type

```
optionals :: Bool -> [a] -> [a]
```

# Examples
:::{.example}
## `lib.lists.optionals` usage example

```nix
optionals true [ 2 3 ]
=> [ 2 3 ]
optionals false [ 2 3 ]
=> [ ]
```

:::

## Documentation for `toList`

*Function `toList` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:871:12*

If argument is a list, return it; else, wrap it in a singleton
list. If you're using this, you should almost certainly
reconsider if there isn't a more "well-typed" approach.

# Inputs

`x`

: 1\. Function argument

# Type

```
toList :: (a | [a]) -> [a]
```

# Examples
:::{.example}
## `lib.lists.toList` usage example

```nix
toList [ 1 2 ]
=> [ 1 2 ]
toList "hi"
=> [ "hi" ]
```

:::

## Documentation for `range`

*Function `range` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:905:11*

Returns a list of integers from `first` up to and including `last`.

# Inputs

`first`

: First integer in the range

`last`

: Last integer in the range

# Type

```
range :: Int -> Int -> [Int]
```

# Examples
:::{.example}
## `lib.lists.range` usage example

```nix
range 2 4
=> [ 2 3 4 ]
range 3 2
=> [ ]
```

:::

## Documentation for `replicate`

*Function `replicate` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:939:15*

Returns a list with `n` copies of an element.

# Inputs

`n`

: 1\. Function argument

`elem`

: 2\. Function argument

# Type

```
replicate :: Int -> a -> [a]
```

# Examples
:::{.example}
## `lib.lists.replicate` usage example

```nix
replicate 3 "a"
=> [ "a" "a" "a" ]
replicate 2 true
=> [ true true ]
```

:::

## Documentation for `zipListsWith`

*Function `zipListsWith` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:1080:5*

Merges two lists of the same size together. If the sizes aren't the same
the merging stops at the shortest. How both lists are merged is defined
by the first argument.

# Inputs

`f`

: Function to zip elements of both lists

`fst`

: First list

`snd`

: Second list

# Type

```
zipListsWith :: (a -> b -> c) -> [a] -> [b] -> [c]
```

# Examples
:::{.example}
## `lib.lists.zipListsWith` usage example

```nix
zipListsWith (a: b: a + b) ["h" "l"] ["e" "o"]
=> ["he" "lo"]
```

:::

## Documentation for `zipLists`

*Function `zipListsWith` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:1080:8*

Merges two lists of the same size together. If the sizes aren't the same
the merging stops at the shortest. How both lists are merged is defined
by the first argument.

# Inputs

`f`

: Function to zip elements of both lists

`fst`

: First list

`snd`

: Second list

# Type

```
zipListsWith :: (a -> b -> c) -> [a] -> [b] -> [c]
```

# Examples
:::{.example}
## `lib.lists.zipListsWith` usage example

```nix
zipListsWith (a: b: a + b) ["h" "l"] ["e" "o"]
=> ["he" "lo"]
```

:::

## Documentation for `reverseList`

*Function `reverseList` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:1143:5*

Reverse the order of the elements of a list.

# Inputs

`xs`

: 1\. Function argument

# Type

```
reverseList :: [a] -> [a]
```

# Examples
:::{.example}
## `lib.lists.reverseList` usage example

```nix
reverseList [ "b" "o" "j" ]
=> [ "j" "o" "b" ]
```

:::

## Documentation for `listDfs`

*Function `listDfs` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:1197:5*

Depth-First Search (DFS) for lists `list != []`.

`before a b == true` means that `b` depends on `a` (there's an
edge from `b` to `a`).

# Inputs

`stopOnCycles`

: 1\. Function argument

`before`

: 2\. Function argument

`list`

: 3\. Function argument

# Type

```
listDfs :: Bool -> (a -> a -> Bool) -> [a] -> ({ minimal :: a; visited :: [a]; rest :: [a]; } | { cycle :: a; loops :: [a]; visited :: [a]; rest :: [a]; })
```

# Examples
:::{.example}
## `lib.lists.listDfs` usage example

```nix
listDfs true hasPrefix [ "/home/user" "other" "/" "/home" ]
  == { minimal = "/";                  # minimal element
       visited = [ "/home/user" ];     # seen elements (in reverse order)
       rest    = [ "/home" "other" ];  # everything else
     }

listDfs true hasPrefix [ "/home/user" "other" "/" "/home" "/" ]
  == { cycle   = "/";                  # cycle encountered at this element
       loops   = [ "/" ];              # and continues to these elements
       visited = [ "/" "/home/user" ]; # elements leading to the cycle (in reverse order)
       rest    = [ "/home" "other" ];  # everything else
```

:::

## Documentation for `toposort`

*Function `toposort` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:1268:5*

Sort a list based on a partial ordering using DFS. This
implementation is O(N^2), if your ordering is linear, use `sort`
instead.

`before a b == true` means that `b` should be after `a`
in the result.

# Inputs

`before`

: 1\. Function argument

`list`

: 2\. Function argument

# Type

```
toposort :: (a -> a -> Bool) -> [a] -> ({ result :: [a]; } | { cycle :: [a]; loops :: [a]; })
```

# Examples
:::{.example}
## `lib.lists.toposort` usage example

```nix
toposort hasPrefix [ "/home/user" "other" "/" "/home" ]
  == { result = [ "/" "/home" "/home/user" "other" ]; }

toposort hasPrefix [ "/home/user" "other" "/" "/home" "/" ]
  == { cycle = [ "/home/user" "/" "/" ]; # path leading to a cycle
       loops = [ "/" ]; }                # loops back to these elements

toposort hasPrefix [ "other" "/home/user" "/home" "/" ]
  == { result = [ "other" "/" "/home" "/home/user" ]; }

toposort (a: b: a < b) [ 3 2 1 ] == { result = [ 1 2 3 ]; }
```

:::

## Documentation for `sortOn`

*Function `sortOn` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:1378:5*

Sort a list based on the default comparison of a derived property `b`.

The items are returned in `b`-increasing order.

**Performance**:

The passed function `f` is only evaluated once per item,
unlike an unprepared [`sort`](#function-library-lib.lists.sort) using
`f p < f q`.

**Laws**:
```nix
sortOn f == sort (p: q: f p < f q)
```

# Inputs

`f`

: 1\. Function argument

`list`

: 2\. Function argument

# Type

```
sortOn :: (a -> b) -> [a] -> [a], for comparable b
```

# Examples
:::{.example}
## `lib.lists.sortOn` usage example

```nix
sortOn stringLength [ "aa" "b" "cccc" ]
=> [ "b" "aa" "cccc" ]
```

:::

## Documentation for `naturalSort`

*Function `naturalSort` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:1491:5*

Sort list using "Natural sorting".
Numeric portions of strings are sorted in numeric order.

# Inputs

`lst`

: 1\. Function argument

# Type

```
naturalSort :: [String] -> [String]
```

# Examples
:::{.example}
## `lib.lists.naturalSort` usage example

```nix
naturalSort ["disk11" "disk8" "disk100" "disk9"]
=> ["disk8" "disk9" "disk11" "disk100"]
naturalSort ["10.46.133.149" "10.5.16.62" "10.54.16.25"]
=> ["10.5.16.62" "10.46.133.149" "10.54.16.25"]
naturalSort ["v0.2" "v0.15" "v0.0.9"]
=> [ "v0.0.9" "v0.2" "v0.15" ]
```

:::

## Documentation for `compareLists`

*Function `compareLists` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:1448:5*

Compare two lists element-by-element with a comparison function `cmp`.

List elements are compared pairwise in order by the provided comparison function `cmp`,
the first non-equal pair of elements determines the result.

:::{.note}
The `<` operator can also be used to compare lists using a boolean condition. (e.g. `[1 2] < [1 3]` is `true`).
See also [language operators](https://nix.dev/manual/nix/stable/language/operators#comparison) for more information.
:::

# Inputs

`cmp`

: The comparison function `a: b: ...` must return:
  - `0` if `a` and `b` are equal
  - `1` if `a` is greater than `b`
  - `-1` if `a` is less than `b`

  See [lib.compare](#function-library-lib.trivial.compare) for a an example implementation.

`a`

: The first list

`b`

: The second list

# Type

```
compareLists :: (a -> a -> Int) -> [a] -> [a] -> Int
```

# Examples
:::{.example}
## `lib.lists.compareLists` usage examples

```nix
compareLists lib.compare [] []
=> 0
compareLists lib.compare [] [ "a" ]
=> -1
compareLists lib.compare [ "a" ] []
=> 1
compareLists lib.compare [ "a" "b" ] [ "a" "c" ]
=> -1
```

:::

## Documentation for `take`

*Function `take` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:1535:5*

Returns the first (at most) N elements of a list.

# Inputs

`count`

: Number of elements to take

`list`

: Input list

# Type

```
take :: Int -> [a] -> [a]
```

# Examples
:::{.example}
## `lib.lists.take` usage example

```nix
take 2 [ "a" "b" "c" "d" ]
=> [ "a" "b" ]
take 2 [ ]
=> [ ]
```

:::

## Documentation for `takeEnd`

*Function `takeEnd` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:1574:5*

Returns the last (at most) N elements of a list.

# Inputs

`count`

: Maximum number of elements to pick

`list`

: Input list

# Type

```
takeEnd :: Int -> [a] -> [a]
```

# Examples
:::{.example}
## `lib.lists.takeEnd` usage example

```nix
takeEnd 2 [ "a" "b" "c" "d" ]
=> [ "c" "d" ]
takeEnd 2 [ ]
=> [ ]
```

:::

## Documentation for `drop`

*Function `drop` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:1614:5*

Remove the first (at most) N elements of a list.

# Inputs

`count`

: Number of elements to drop

`list`

: Input list

# Type

```
drop :: Int -> [a] -> [a]
```

# Examples
:::{.example}
## `lib.lists.drop` usage example

```nix
drop 2 [ "a" "b" "c" "d" ]
=> [ "c" "d" ]
drop 2 [ ]
=> [ ]
```

:::

## Documentation for `dropEnd`

*Function `dropEnd` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:1653:5*

Remove the last (at most) N elements of a list.

# Inputs

`count`

: Number of elements to drop

`list`

: Input list

# Type

```
dropEnd :: Int -> [a] -> [a]
```

# Examples

:::{.example}
## `lib.lists.dropEnd` usage example

```nix
  dropEnd 2 [ "a" "b" "c" "d" ]
  => [ "a" "b" ]
  dropEnd 2 [ ]
  => [ ]
```
:::

## Documentation for `sublist`

*Function `sublist` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:1778:5*

Returns a list consisting of at most `count` elements of `list`,
starting at index `start`.

# Inputs

`start`

: Index at which to start the sublist

`count`

: Number of elements to take

`list`

: Input list

# Type

```
sublist :: Int -> Int -> [a] -> [a]
```

# Examples
:::{.example}
## `lib.lists.sublist` usage example

```nix
sublist 1 3 [ "a" "b" "c" "d" "e" ]
=> [ "b" "c" "d" ]
sublist 1 3 [ ]
=> [ ]
```

:::

## Documentation for `last`

*Function `last` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:1867:5*

Returns the last element of a list.

This function throws an error if the list is empty.

# Inputs

`list`

: 1\. Function argument

# Type

```
last :: [a] -> a
```

# Examples
:::{.example}
## `lib.lists.last` usage example

```nix
last [ 1 2 3 ]
=> 3
```

:::

## Documentation for `init`

*Function `init` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:1900:5*

Returns all elements but the last.

This function throws an error if the list is empty.

# Inputs

`list`

: 1\. Function argument

# Type

```
init :: [a] -> [a]
```

# Examples
:::{.example}
## `lib.lists.init` usage example

```nix
init [ 1 2 3 ]
=> [ 1 2 ]
```

:::

## Documentation for `crossLists`

*Function `crossLists` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:1924:16*

Returns the image of the cross product of some lists by a function.

# Examples
:::{.example}
## `lib.lists.crossLists` usage example

```nix
crossLists (x: y: "${toString x}${toString y}") [[1 2] [3 4]]
=> [ "13" "14" "23" "24" ]
```

If you have an attrset already, consider mapCartesianProduct:

```nix
mapCartesianProduct (x: "${toString x.a}${toString x.b}") { a = [1 2]; b = [3 4]; }
=> [ "13" "14" "23" "24" ]
```
:::

## Documentation for `uniqueStrings`

*Function `uniqueStrings` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:1993:19*

Removes duplicate strings from the `list`. O(n log n) complexity.

:::{.note}
Order is not preserved.

All elements of the list must be strings without context.

This function fails when the list contains a non-string element or a [string with context](https://nix.dev/manual/nix/latest/language/string-context.html).
In that case use [`lib.lists.unique`](#function-library-lib.lists.unique) instead.
:::

# Inputs

`list`

: List of strings

# Type

```
uniqueStrings :: [String] -> [String]
```

# Examples
:::{.example}
## `lib.lists.uniqueStrings` usage example

```nix
uniqueStrings [ "foo" "bar" "foo" ]
=> [ "bar" "foo" ] # order is not preserved
```

:::

## Documentation for `allUnique`

*Function `allUnique` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:2023:15*

Check if list contains only unique elements. O(n^2) complexity.

# Inputs

`list`

: 1\. Function argument

# Type

```
allUnique :: [a] -> Bool
```

# Examples
:::{.example}
## `lib.lists.allUnique` usage example

```nix
allUnique [ 3 2 3 4 ]
=> false
allUnique [ 3 2 4 1 ]
=> true
```

:::

## Documentation for `intersectLists`

*Function `intersectLists` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:2057:20*

Intersects list `list1` and another list (`list2`).

O(nm) complexity.

# Inputs

`list1`

: First list

`list2`

: Second list

# Type

```
intersectLists :: [a] -> [a] -> [a]
```

# Examples
:::{.example}
## `lib.lists.intersectLists` usage example

```nix
intersectLists [ 1 2 3 ] [ 6 3 2 ]
=> [ 3 2 ]
```

:::

## Documentation for `subtractLists`

*Function `subtractLists` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:2091:19*

Subtracts list `e` from another list (`list2`).

O(nm) complexity.

# Inputs

`e`

: First list

`list2`

: Second list

# Type

```
subtractLists :: [a] -> [a] -> [a]
```

# Examples
:::{.example}
## `lib.lists.subtractLists` usage example

```nix
subtractLists [ 3 2 ] [ 1 2 3 4 5 3 ]
=> [ 1 4 5 ]
```

:::

## Documentation for `mutuallyExclusive`

*Function `mutuallyExclusive` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:2113:23*

Test if two lists have no common element.
It should be slightly more efficient than `intersectLists a b == []`.

# Inputs

`a`

: 1\. Function argument

`b`

: 2\. Function argument

# Type

```
mutuallyExclusive :: [a] -> [a] -> Bool
```

## Documentation for `groupBy'`

*Function `groupBy'` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:1028:5*

Splits the elements of a list into many lists, using the return value of a predicate.
Predicate should return a string which becomes keys of attrset `groupBy` returns.
`groupBy'` allows to customise the combining function and initial value

# Inputs

`op`

: 1\. Function argument

`nul`

: 2\. Function argument

`pred`

: 3\. Function argument

`lst`

: 4\. Function argument

# Type

```
groupBy' :: (a -> b -> a) -> a -> (b -> String) -> [b] -> { [String] :: a }
```

# Examples
:::{.example}
## `lib.lists.groupBy'` usage example

```nix
groupBy (x: boolToString (x > 2)) [ 5 1 2 3 4 ]
=> { true = [ 5 3 4 ]; false = [ 1 2 ]; }
groupBy (x: x.name) [ {name = "icewm"; script = "icewm &";}
                      {name = "xfce";  script = "xfce4-session &";}
                      {name = "icewm"; script = "icewmbg &";}
                      {name = "mate";  script = "gnome-session &";}
                    ]
=> { icewm = [ { name = "icewm"; script = "icewm &"; }
               { name = "icewm"; script = "icewmbg &"; } ];
     mate  = [ { name = "mate";  script = "gnome-session &"; } ];
     xfce  = [ { name = "xfce";  script = "xfce4-session &"; } ];
   }

groupBy' builtins.add 0 (x: boolToString (x > 2)) [ 5 1 2 3 4 ]
=> { true = 12; false = 3; }
```

:::

## Documentation for `concatAttrValues`

*Function `concatAttrValues` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:2142:22*

Concatenate all attributes of an attribute set.
This assumes that every attribute of the set is a list.

# Inputs

`set`

: Attribute set with attributes that are lists

# Type

```
concatAttrValues :: { [String] :: [a] } -> [a]
```

# Examples
:::{.example}
## `lib.concatAttrValues` usage example

```nix
concatAttrValues { a = [ 1 2 ]; b = [ 3 ]; }
=> [ 1 2 3 ]
```

:::

## Documentation for `replaceElemAt`

*Function `replaceElemAt` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:2176:5*

Replaces a list's nth element with a new element

# Inputs

`list`
: Input list

`idx`
: index to replace

`newElem`
: new element to replace with

# Type

```
replaceElemAt :: [a] -> Int -> a -> [a]
```

# Examples
:::{.example}
## `replaceElemAt` usage example

```nix
lib.replaceElemAt` [1 2 3] 0 "a"
=> ["a" 2 3]
```

:::

## Documentation for `concatMapStrings`

*Function `concatMapStrings` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:124:22*

Map a function over a list and concatenate the resulting strings.

# Inputs

`f`
: 1\. Function argument

`list`
: 2\. Function argument

# Type

```
concatMapStrings :: (a -> String) -> [a] -> String
```

# Examples
:::{.example}
## `lib.strings.concatMapStrings` usage example

```nix
concatMapStrings (x: "a" + x) ["foo" "bar"]
=> "afooabar"
```

:::

## Documentation for `concatImapStrings`

*Function `concatImapStrings` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:155:23*

Like `concatMapStrings` except that the function `f` also gets the
position as a parameter.

# Inputs

`f`
: 1\. Function argument

`list`
: 2\. Function argument

# Type

```
concatImapStrings :: (Int -> a -> String) -> [a] -> String
```

# Examples
:::{.example}
## `lib.strings.concatImapStrings` usage example

```nix
concatImapStrings (pos: x: "${toString pos}-${x}") ["foo" "bar"]
=> "1-foo2-bar"
```

:::

## Documentation for `replaceString`

*Function `replaceString` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:397:19*

Given string `s`, replace every occurrence of the string `from` with the string `to`.

# Inputs

`from`
: The string to be replaced

`to`
: The string to replace with

`s`
: The original string where replacements will be made

# Type

```
replaceString :: String -> String -> String -> String
```

# Examples
:::{.example}
## `lib.strings.replaceString` usage example

```nix
replaceString "world" "Nix" "Hello, world!"
=> "Hello, Nix!"
replaceString "." "_" "v1.2.3"
=> "v1_2_3"
```

:::

## Documentation for `intersperse`

*Function `intersperse` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:186:5*

Place an element between each element of a list

# Inputs

`separator`
: Separator to add between elements

`list`
: Input list

# Type

```
intersperse :: a -> [a] -> [a]
```

# Examples
:::{.example}
## `lib.strings.intersperse` usage example

```nix
intersperse "/" ["usr" "local" "bin"]
=> ["usr" "/" "local" "/" "bin"].
```

:::

## Documentation for `concatMapAttrsStringSep`

*Function `concatMapAttrsStringSep` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:334:5*

Like [`concatMapStringsSep`](#function-library-lib.strings.concatMapStringsSep)
but takes an attribute set instead of a list.

# Inputs

`sep`
: Separator to add between item strings

`f`
: Function that takes each key and value and return a string

`attrs`
: Attribute set to map from

# Type

```
concatMapAttrsStringSep :: String -> (String -> a -> String) -> { [String] :: a } -> String
```

# Examples

:::{.example}
## `lib.strings.concatMapAttrsStringSep` usage example

```nix
concatMapAttrsStringSep "\n" (name: value: "${name}: foo-${value}") { a = "0.1.0"; b = "0.2.0"; }
=> "a: foo-0.1.0\nb: foo-0.2.0"
```

:::

## Documentation for `concatImapStringsSep`

*Function `concatImapStringsSep` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:297:5*

Same as `concatMapStringsSep`, but the mapping function
additionally receives the position of its argument.

# Inputs

`sep`
: Separator to add between elements

`f`
: Function that receives elements and their positions

`list`
: List of input strings

# Type

```
concatIMapStringsSep :: String -> (Int -> a -> String) -> [a] -> String
```

# Examples
:::{.example}
## `lib.strings.concatImapStringsSep` usage example

```nix
concatImapStringsSep "-" (pos: x: toString (x / pos)) [ 6 6 6 ]
=> "6-3-2"
```

:::

## Documentation for `concatLines`

*Function `concatLines` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:362:17*

Concatenate a list of strings, adding a newline at the end of each one.

# Inputs

`list`
: List of strings. Any element that is not a string will be implicitly converted to a string.

# Type

```
concatLines :: [String] -> String
```

# Examples
:::{.example}
## `lib.strings.concatLines` usage example

```nix
concatLines [ "foo" "bar" ]
=> "foo\nbar\n"
```

:::

## Documentation for `makeSearchPath`

*Function `makeSearchPath` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:566:5*

Construct a Unix-style, colon-separated search path consisting of
the given `subDir` appended to each of the given paths.

# Inputs

`subDir`
: Directory name to append

`paths`
: List of base paths

# Type

```
makeSearchPath :: String -> [String] -> String
```

# Examples
:::{.example}
## `lib.strings.makeSearchPath` usage example

```nix
makeSearchPath "bin" ["/root" "/usr" "/usr/local"]
=> "/root/bin:/usr/bin:/usr/local/bin"
makeSearchPath "bin" [""]
=> "/bin"
```

:::

## Documentation for `makeSearchPathOutput`

*Function `makeSearchPathOutput` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:607:5*

Construct a Unix-style search path by appending the given
`subDir` to the specified `output` of each of the packages.

If no output by the given name is found, fallback to `.out` and then to
the default.

# Inputs

`output`
: Package output to use

`subDir`
: Directory name to append

`pkgs`
: List of packages

# Type

```
makeSearchPathOutput :: String -> String -> [Derivation] -> String
```

# Examples
:::{.example}
## `lib.strings.makeSearchPathOutput` usage example

```nix
makeSearchPathOutput "dev" "bin" [ pkgs.openssl pkgs.zlib ]
=> "/nix/store/9rz8gxhzf8sw4kf2j2f1grr49w8zx5vj-openssl-1.0.1r-dev/bin:/nix/store/wwh7mhwh269sfjkm6k5665b5kgp7jrk2-zlib-1.2.8/bin"
```

:::

## Documentation for `makeLibraryPath`

*Function `` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:611:13*

NO_DOC_CONTENT

## Documentation for `makeIncludePath`

*Function `` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:611:13*

NO_DOC_CONTENT

## Documentation for `makeBinPath`

*Function `` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:611:13*

NO_DOC_CONTENT

## Documentation for `optionalString`

*Function `optionalString` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:776:20*

Depending on the boolean `cond`, return either the given string
or the empty string. Useful to concatenate against a bigger string.

# Inputs

`cond`
: Condition

`string`
: String to return if condition is true

# Type

```
optionalString :: Bool -> String -> String
```

# Examples
:::{.example}
## `lib.strings.optionalString` usage example

```nix
optionalString true "some-string"
=> "some-string"
optionalString false "some-string"
=> ""
```

:::

## Documentation for `hasInfix`

*Function `hasInfix` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:906:5*

Determine whether a string contains the given infix

# Inputs

`infix`
: 1\. Function argument

`content`
: 2\. Function argument

# Type

```
hasInfix :: String -> String -> Bool
```

# Examples
:::{.example}
## `lib.strings.hasInfix` usage example

```nix
hasInfix "bc" "abcd"
=> true
hasInfix "ab" "abcd"
=> true
hasInfix "cd" "abcd"
=> true
hasInfix "foo" "abcd"
=> false
```

:::

## Documentation for `hasPrefix`

*Function `hasPrefix` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:809:5*

Determine whether a string has given prefix.

# Inputs

`pref`
: Prefix to check for

`str`
: Input string

# Type

```
hasPrefix :: String -> String -> Bool
```

# Examples
:::{.example}
## `lib.strings.hasPrefix` usage example

```nix
hasPrefix "foo" "foobar"
=> true
hasPrefix "foo" "barfoo"
=> false
```

:::

## Documentation for `hasSuffix`

*Function `hasSuffix` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:853:5*

Determine whether a string has given suffix.

# Inputs

`suffix`
: Suffix to check for

`content`
: Input string

# Type

```
hasSuffix :: String -> String -> Bool
```

# Examples
:::{.example}
## `lib.strings.hasSuffix` usage example

```nix
hasSuffix "foo" "foobar"
=> false
hasSuffix "foo" "barfoo"
=> true
```

:::

## Documentation for `join`

*Function `concatStringsSep` defined at NO_SOURCE_PATH:0:0*

Concatenate a list of strings with a separator between each
      element, e.g. `concatStringsSep "/" ["usr" "local" "bin"] ==
      "usr/local/bin"`.

## Documentation for `stringToCharacters`

*Function `stringToCharacters` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:955:24*

Convert a string `s` to a list of characters (i.e. singleton strings).
This allows you to, e.g., map a function over each character.  However,
note that this will likely be horribly inefficient; Nix is not a
general purpose programming language. Complex string manipulations
should, if appropriate, be done in a derivation.
Also note that Nix treats strings as a list of bytes and thus doesn't
handle unicode.

# Inputs

`s`
: 1\. Function argument

# Type

```
stringToCharacters :: String -> [String]
```

# Examples
:::{.example}
## `lib.strings.stringToCharacters` usage example

```nix
stringToCharacters ""
=> [ ]
stringToCharacters "abc"
=> [ "a" "b" "c" ]
stringToCharacters "🦄"
=> [ "�" "�" "�" "�" ]
```

:::

## Documentation for `stringAsChars`

*Function `stringAsChars` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:988:5*

Manipulate a string character by character and replace them by
strings before concatenating the results.

# Inputs

`f`
: Function to map over each individual character

`s`
: Input string

# Type

```
stringAsChars :: (String -> String) -> String -> String
```

# Examples
:::{.example}
## `lib.strings.stringAsChars` usage example

```nix
stringAsChars (x: if x == "a" then "i" else x) "nax"
=> "nix"
```

:::

## Documentation for `escape`

*Function `escape` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:1051:12*

Escape occurrence of the elements of `list` in `string` by
prefixing it with a backslash.

# Inputs

`list`
: 1\. Function argument

`string`
: 2\. Function argument

# Type

```
escape :: [String] -> String -> String
```

# Examples
:::{.example}
## `lib.strings.escape` usage example

```nix
escape ["(" ")"] "(foo)"
=> "\\(foo\\)"
```

:::

## Documentation for `escapeShellArg`

*Function `escapeShellArg` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:1218:5*

Quote `string` to be used safely within the Bourne shell if it has any
special characters.

# Inputs

`string`
: 1\. Function argument

# Type

```
escapeShellArg :: String -> String
```

# Examples
:::{.example}
## `lib.strings.escapeShellArg` usage example

```nix
escapeShellArg "esc'ape\nme"
=> "'esc'\\''ape\nme'"
```

:::

## Documentation for `escapeShellArgs`

*Function `concatMapStringsSep` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:261:13*

Maps a function over a list of strings and then concatenates the
result with the specified separator interspersed between
elements.

# Inputs

`sep`
: Separator to add between elements

`f`
: Function to map over the list

`list`
: List of input strings

# Type

```
concatMapStringsSep :: String -> (a -> String) -> [a] -> String
```

# Examples
:::{.example}
## `lib.strings.concatMapStringsSep` usage example

```nix
concatMapStringsSep "-" (x: toUpper x)  ["foo" "bar" "baz"]
=> "FOO-BAR-BAZ"
```

:::

## Documentation for `isStorePath`

*Function `isStorePath` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:2687:5*

Check whether a value `x` is a store path.

# Inputs

`x`
: 1\. Function argument

# Type

```
isStorePath :: Any -> Bool
```

# Examples
:::{.example}
## `lib.strings.isStorePath` usage example

```nix
isStorePath "/nix/store/d945ibfx9x185xf04b890y4f9g3cbb63-python-2.7.11/bin/python"
=> false
isStorePath "/nix/store/d945ibfx9x185xf04b890y4f9g3cbb63-python-2.7.11"
=> true
isStorePath pkgs.python
=> true
isStorePath [] || isStorePath 42 || isStorePath {} || …
=> false
```

:::

## Documentation for `isStringLike`

*Function `isStringLike` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:2653:18*

Check whether a value can be coerced to a string.
The value must be a string, path, or attribute set.

String-like values can be used without explicit conversion in
string interpolations and in most functions that expect a string.

# Inputs

`x`
: 1\. Function argument

# Type

```
isStringLike :: Any -> Bool
```

## Documentation for `isValidPosixName`

*Function `isValidPosixName` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:1282:22*

Test whether the given `name` is a valid POSIX shell variable name.

# Inputs

`name`
: 1\. Function argument

# Type

```
isValidPosixName :: String -> Bool
```

# Examples
:::{.example}
## `lib.strings.isValidPosixName` usage example

```nix
isValidPosixName "foo_bar000"
=> true
isValidPosixName "0-bad.jpg"
=> false
```

:::

## Documentation for `toShellVar`

*Function `toShellVar` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:1323:5*

Translate a Nix value into a shell variable declaration, with proper escaping.

The value can be a string (mapped to a regular variable), a list of strings
(mapped to a Bash-style array) or an attribute set of strings (mapped to a
Bash-style associative array). Note that "string" includes string-coercible
values like paths or derivations.

Strings are translated into POSIX sh-compatible code; lists and attribute sets
assume a shell that understands Bash syntax (e.g. Bash or ZSH).

# Inputs

`name`
: 1\. Function argument

`value`
: 2\. Function argument

# Type

```
toShellVar :: String -> (String | [String] | { [String] :: String }) -> String
```

# Examples
:::{.example}
## `lib.strings.toShellVar` usage example

```nix
''
  ${toShellVar "foo" "some string"}
  [[ "$foo" == "some string" ]]
''
```

:::

## Documentation for `toShellVars`

*Function `toShellVars` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:1370:17*

Translate an attribute set `vars` into corresponding shell variable declarations
using `toShellVar`.

# Inputs

`vars`
: 1\. Function argument

# Type

```
toShellVars :: {
  [String] :: String | [String] | { [String] :: String };
} -> String
```

# Examples
:::{.example}
## `lib.strings.toShellVars` usage example

```nix
let
  foo = "value";
  bar = foo;
in ''
  ${toShellVars { inherit foo bar; }}
  [[ "$foo" == "$bar" ]]
''
```

:::

## Documentation for `trim`

*Function `` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:526:5*

NO_DOC_CONTENT

## Documentation for `trimWith`

*Function `trimWith` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:505:5*

Remove leading and/or trailing whitespace from a string `s`.

To remove both leading and trailing whitespace, you can also use [`trim`](#function-library-lib.strings.trim)

Whitespace is defined as any of the following characters:
  " ", "\t" "\r" "\n"

# Inputs

`config` (Attribute set)
: `start`
  : Whether to trim leading whitespace (`false` by default)

: `end`
  : Whether to trim trailing whitespace (`false` by default)

`s`
: The string to trim

# Type

```
trimWith :: { start :: Bool; end :: Bool; } -> String -> String
```

# Examples
:::{.example}
## `lib.strings.trimWith` usage example

```nix
trimWith { start = true; } "   hello, world!   "}
=> "hello, world!   "

trimWith { end = true; } "   hello, world!   "}
=> "   hello, world!"
```
:::

## Documentation for `toCamelCase`

*Function `toCamelCase` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:1634:5*

Converts a string to camelCase. Handles snake_case, PascalCase,
kebab-case strings as well as strings delimited by spaces.

# Inputs

`string`
: The string to convert to camelCase

# Type

```
toCamelCase :: String -> String
```

# Examples
:::{.example}
## `lib.strings.toCamelCase` usage example

```nix
toCamelCase "hello-world"
=> "helloWorld"
toCamelCase "hello_world"
=> "helloWorld"
toCamelCase "hello world"
=> "helloWorld"
toCamelCase "HelloWorld"
=> "helloWorld"
```

:::

## Documentation for `toSentenceCase`

*Function `toSentenceCase` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:1591:5*

Converts the first character of a string `s` to upper-case.

# Inputs

`str`
: The string to convert to sentence case.

# Type

```
toSentenceCase :: String -> String
```

# Examples
:::{.example}
## `lib.strings.toSentenceCase` usage example

```nix
toSentenceCase "home"
=> "Home"
```

:::

## Documentation for `addContextFrom`

*Function `addContextFrom` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:1709:20*

Appends string context from string like object `src` to `target`.

:::{.warning}
This is an implementation
detail of Nix and should be used carefully.
:::

Strings in Nix carry an invisible `context` which is a list of strings
representing store paths. If the string is later used in a derivation
attribute, the derivation will properly populate the inputDrvs and
inputSrcs.

# Inputs

`src`
: The string to take the context from. If the argument is not a string,
  it will be implicitly converted to a string.

`target`
: The string to append the context to. If the argument is not a string,
  it will be implicitly converted to a string.

# Type

```
addContextFrom :: String -> String -> String
```

# Examples
:::{.example}
## `lib.strings.addContextFrom` usage example

```nix
pkgs = import <nixpkgs> { };
addContextFrom pkgs.coreutils "bar"
=> "bar"
```

The context can be displayed using the `toString` function:

```nix
nix-repl> builtins.getContext (lib.strings.addContextFrom pkgs.coreutils "bar")
{
  "/nix/store/m1s1d2dk2dqqlw3j90jl3cjy2cykbdxz-coreutils-9.5.drv" = { ... };
}
```

:::

## Documentation for `splitString`

*Function `splitString` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:1743:5*

Cut a string with a separator and produces a list of strings which
were separated by this separator.

# Inputs

`sep`
: 1\. Function argument

`s`
: 2\. Function argument

# Type

```
splitString :: String -> String -> [String]
```

# Examples
:::{.example}
## `lib.strings.splitString` usage example

```nix
splitString "." "foo.bar.baz"
=> [ "foo" "bar" "baz" ]
splitString "/" "/usr/local/bin"
=> [ "" "usr" "local" "bin" ]
```

:::

## Documentation for `splitStringBy`

*Function `splitStringBy` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:1811:5*

Splits a string into substrings based on a predicate that examines adjacent characters.

This function provides a flexible way to split strings by checking pairs of characters
against a custom predicate function. Unlike simpler splitting functions, this allows
for context-aware splitting based on character transitions and patterns.

# Inputs

`predicate`
: Function that takes two arguments (previous character and current character)
  and returns true when the string should be split at the current position.
  For the first character, previous will be "" (empty string).

`keepSplit`
: Boolean that determines whether the splitting character should be kept as
  part of the result. If true, the character will be included at the beginning
  of the next substring; if false, it will be discarded.

`str`
: The input string to split.

# Return

A list of substrings from the original string, split according to the predicate.

# Type

```
splitStringBy :: (String -> String -> Bool) -> Bool -> String -> [String]
```

# Examples
:::{.example}
## `lib.strings.splitStringBy` usage example

Split on periods and hyphens, discarding the separators:
```nix
splitStringBy (prev: curr: builtins.elem curr [ "." "-" ]) false "foo.bar-baz"
=> [ "foo" "bar" "baz" ]
```

Split on transitions from lowercase to uppercase, keeping the uppercase characters:
```nix
splitStringBy (prev: curr: builtins.match "[a-z]" prev != null && builtins.match "[A-Z]" curr != null) true "fooBarBaz"
=> [ "foo" "Bar" "Baz" ]
```

Handle leading separators correctly:
```nix
splitStringBy (prev: curr: builtins.elem curr [ "." ]) false ".foo.bar.baz"
=> [ "" "foo" "bar" "baz" ]
```

Handle trailing separators correctly:
```nix
splitStringBy (prev: curr: builtins.elem curr [ "." ]) false "foo.bar.baz."
=> [ "foo" "bar" "baz" "" ]
```
:::

## Documentation for `removePrefix`

*Function `removePrefix` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:1867:5*

Returns a string without the specified prefix, if the prefix matches.

# Inputs

`prefix`
: Prefix to remove if it matches

`str`
: Input string

# Type

```
removePrefix :: String -> String -> String
```

# Examples
:::{.example}
## `lib.strings.removePrefix` usage example

```nix
removePrefix "foo." "foo.bar.baz"
=> "bar.baz"
removePrefix "xxx" "foo.bar.baz"
=> "foo.bar.baz"
```

:::

## Documentation for `removeSuffix`

*Function `removeSuffix` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:1917:5*

Returns a string without the specified suffix, if the suffix matches.

# Inputs

`suffix`
: Suffix to remove if it matches

`str`
: Input string

# Type

```
removeSuffix :: String -> String -> String
```

# Examples
:::{.example}
## `lib.strings.removeSuffix` usage example

```nix
removeSuffix "front" "homefront"
=> "home"
removeSuffix "xxx" "homefront"
=> "homefront"
```

:::

## Documentation for `versionOlder`

*Function `versionOlder` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:1968:18*

Returns true if string `v1` denotes a version older than `v2`.

# Inputs

`v1`
: 1\. Function argument

`v2`
: 2\. Function argument

# Type

```
versionOlder :: String -> String -> Bool
```

# Examples
:::{.example}
## `lib.strings.versionOlder` usage example

```nix
versionOlder "1.1" "1.2"
=> true
versionOlder "1.1" "1.1"
=> false
```

:::

## Documentation for `versionAtLeast`

*Function `versionAtLeast` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:2002:20*

Returns true if string `v1` denotes a version equal to or newer than `v2`.

# Inputs

`v1`
: 1\. Function argument

`v2`
: 2\. Function argument

# Type

```
versionAtLeast :: String -> String -> Bool
```

# Examples
:::{.example}
## `lib.strings.versionAtLeast` usage example

```nix
versionAtLeast "1.1" "1.0"
=> true
versionAtLeast "1.1" "1.1"
=> true
versionAtLeast "1.1" "1.2"
=> false
```

:::

## Documentation for `getName`

*Function `` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:2037:5*

NO_DOC_CONTENT

## Documentation for `getVersion`

*Function `` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:2072:5*

NO_DOC_CONTENT

## Documentation for `cmakeOptionType`

*Function `` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:2165:5*

NO_DOC_CONTENT

## Documentation for `cmakeBool`

*Function `cmakeBool` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:2202:5*

Create a `"-D<condition>={TRUE,FALSE}"` string that can be passed to typical
CMake invocations.

# Inputs

`condition`
: The condition to be made true or false

`flag`
: The controlling flag of the condition

# Type

```
cmakeBool :: String -> Bool -> String
```

# Examples
:::{.example}
## `lib.strings.cmakeBool` usage example

```nix
cmakeBool "ENABLE_STATIC_LIBS" false
=> "-DENABLESTATIC_LIBS:BOOL=FALSE"
```

:::

## Documentation for `cmakeFeature`

*Function `` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:2167:5*

NO_DOC_CONTENT

## Documentation for `mesonOption`

*Function `mesonOption` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:2268:5*

Create a `"-D<feature>=<value>"` string that can be passed to typical Meson
invocations.

# Inputs

`feature`
: The feature to be set

`value`
: The desired value

# Type

```
mesonOption :: String -> String -> String
```

# Examples
:::{.example}
## `lib.strings.mesonOption` usage example

```nix
mesonOption "engine" "opengl"
=> "-Dengine=opengl"
```

:::

## Documentation for `mesonBool`

*Function `mesonBool` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:2305:5*

Create a `"-D<condition>={true,false}"` string that can be passed to typical
Meson invocations.

# Inputs

`condition`
: The condition to be made true or false

`flag`
: The controlling flag of the condition

# Type

```
mesonBool :: String -> Bool -> String
```

# Examples
:::{.example}
## `lib.strings.mesonBool` usage example

```nix
mesonBool "hardened" true
=> "-Dhardened=true"
mesonBool "static" false
=> "-Dstatic=false"
```

:::

## Documentation for `mesonEnable`

*Function `mesonEnable` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:2341:5*

Create a `"-D<feature>={enabled,disabled}"` string that can be passed to
typical Meson invocations.

# Inputs

`feature`
: The feature to be enabled or disabled

`flag`
: The controlling flag

# Type

```
mesonEnable :: String -> Bool -> String
```

# Examples
:::{.example}
## `lib.strings.mesonEnable` usage example

```nix
mesonEnable "docs" true
=> "-Ddocs=enabled"
mesonEnable "savage" false
=> "-Dsavage=disabled"
```

:::

## Documentation for `nameFromURL`

*Function `nameFromURL` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:2107:5*

Extract name and version from a URL as shown in the examples.

Separator `sep` is used to determine the end of the extension.

# Inputs

`url`
: 1\. Function argument

`sep`
: 2\. Function argument

# Type

```
nameFromURL :: String -> String
```

# Examples
:::{.example}
## `lib.strings.nameFromURL` usage example

```nix
nameFromURL "https://nixos.org/releases/nix/nix-1.7/nix-1.7-x86_64-linux.tar.bz2" "-"
=> "nix"
nameFromURL "https://nixos.org/releases/nix/nix-1.7/nix-1.7-x86_64-linux.tar.bz2" "_"
=> "nix-1.7-x86"
```

:::

## Documentation for `enableFeature`

*Function `enableFeature` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:2377:5*

Create an `"--{enable,disable}-<feature>"` string that can be passed to
standard GNU Autoconf scripts.

# Inputs

`flag`
: 1\. Function argument

`feature`
: 2\. Function argument

# Type

```
enableFeature :: Bool -> String -> String
```

# Examples
:::{.example}
## `lib.strings.enableFeature` usage example

```nix
enableFeature true "shared"
=> "--enable-shared"
enableFeature false "shared"
=> "--disable-shared"
```

:::

## Documentation for `enableFeatureAs`

*Function `enableFeatureAs` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:2417:5*

Create an `"--{enable-<feature>=<value>,disable-<feature>}"` string that
can be passed to standard GNU Autoconf scripts.

# Inputs

`flag`
: 1\. Function argument

`feature`
: 2\. Function argument

`value`
: 3\. Function argument

# Type

```
enableFeatureAs :: Bool -> String -> String -> String
```

# Examples
:::{.example}
## `lib.strings.enableFeatureAs` usage example

```nix
enableFeatureAs true "shared" "foo"
=> "--enable-shared=foo"
enableFeatureAs false "shared" (throw "ignored")
=> "--disable-shared"
```

:::

## Documentation for `withFeature`

*Function `withFeature` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:2452:5*

Create an `"--{with,without}-<feature>"` string that can be passed to
standard GNU Autoconf scripts.

# Inputs

`flag`
: 1\. Function argument

`feature`
: 2\. Function argument

# Type

```
withFeature :: Bool -> String -> String
```

# Examples
:::{.example}
## `lib.strings.withFeature` usage example

```nix
withFeature true "shared"
=> "--with-shared"
withFeature false "shared"
=> "--without-shared"
```

:::

## Documentation for `withFeatureAs`

*Function `withFeatureAs` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:2491:5*

Create an `"--{with-<feature>=<value>,without-<feature>}"` string that can be passed to
standard GNU Autoconf scripts.

# Inputs

`flag`
: 1\. Function argument

`feature`
: 2\. Function argument

`value`
: 3\. Function argument

# Type

```
withFeatureAs :: Bool -> String -> String -> String
```

# Examples
:::{.example}
## `lib.strings.withFeatureAs` usage example

```nix
withFeatureAs true "shared" "foo"
=> "--with-shared=foo"
withFeatureAs false "shared" (throw "ignored")
=> "--without-shared"
```

:::

## Documentation for `fixedWidthString`

*Function `fixedWidthString` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:2530:5*

Create a fixed width string with additional prefix to match
required width.

This function will fail if the input string is longer than the
requested length.

# Inputs

`width`
: 1\. Function argument

`filler`
: 2\. Function argument

`str`
: 3\. Function argument

# Type

```
fixedWidthString :: Int -> String -> String -> String
```

# Examples
:::{.example}
## `lib.strings.fixedWidthString` usage example

```nix
fixedWidthString 5 "0" (toString 15)
=> "00015"
```

:::

## Documentation for `fixedWidthNumber`

*Function `fixedWidthNumber` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:2568:22*

Format a number adding leading zeroes up to fixed width.

# Inputs

`width`
: 1\. Function argument

`n`
: 2\. Function argument

# Type

```
fixedWidthNumber :: Int -> Int -> String
```

# Examples
:::{.example}
## `lib.strings.fixedWidthNumber` usage example

```nix
fixedWidthNumber 5 15
=> "00015"
```

:::

## Documentation for `toInt`

*Function `` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:2748:5*

NO_DOC_CONTENT

## Documentation for `toIntBase10`

*Function `` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:2818:5*

NO_DOC_CONTENT

## Documentation for `fileContents`

*Function `` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings.nix:2878:5*

NO_DOC_CONTENT

## Documentation for `textClosureList`

*Function `textClosureList` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings-with-deps.nix:130:5*

Topologically sort a collection of dependent strings.
Only the values to keys listed in `arg` and their dependencies will be included in the result.

::: {.note}
This function doesn't formally fulfill the definition of topological sorting, but it's good enough for our purposes in Nixpkgs.
:::

# Inputs

`predefined` (attribute set)

: strings with annotated dependencies (strings or attribute set)
  A value can be a simple string if it has no dependencies.
  Otherwise, is can be an attribute set with the following attributes:
  - `deps` (list of strings)
  - `text` (Any

`arg` (list of strings)

: Keys for which the values in the dependency closure will be included in the result

# Type

```
textClosureList :: { [String] :: { deps :: [String]; text :: String; } | String; } -> [String] -> [String]
```

# Examples
:::{.example}
## `lib.stringsWithDeps.textClosureList` usage example

```nix
textClosureList {
  a = {
    deps = [ "b" "c" "e" ];
    text = "a: depends on b, c and e";
  };
  b = {
    deps = [ ];
    text = "b: no dependencies";
  };
  c = {
    deps = [ "b" ];
    text = "c: depends on b";
  };
  d = {
    deps = [ "c" ];
    text = "d: not being depended on by anything in `arg`";
  };
  e = {
    deps = [ "c" ];
    text = "e: depends on c, depended on by a, not in `arg`";
  };
} [
  "a"
  "b"
  "c"
]
=> [
  "b: no dependencies"
  "c: depends on b"
  "e: depends on c, depended on by a, not in `arg`"
  "a: depends on b, c and e"
]
```
:::

Common real world usages are:
- Ordering the dependent phases of `system.activationScripts`
- Ordering the dependent phases of `system.userActivationScripts`

For further examples see: [NixOS activation script](https://nixos.org/manual/nixos/stable/#sec-activation-script)

## Documentation for `textClosureMap`

*Function `textClosureMap` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings-with-deps.nix:168:5*

NO_DOC_CONTENT

## Documentation for `noDepEntry`

*Function `noDepEntry` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings-with-deps.nix:171:16*

NO_DOC_CONTENT

## Documentation for `fullDepEntry`

*Function `fullDepEntry` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings-with-deps.nix:175:18*

NO_DOC_CONTENT

## Documentation for `packEntry`

*Function `packEntry` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings-with-deps.nix:176:15*

NO_DOC_CONTENT

## Documentation for `stringAfter`

*Function `stringAfter` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/strings-with-deps.nix:181:17*

NO_DOC_CONTENT

## Documentation for `overrideDerivation`

*Function `overrideDerivation` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/customisation.nix:100:5*

`overrideDerivation drv f` takes a derivation (i.e., the result
of a call to the builtin function `derivation`) and returns a new
derivation in which the attributes of the original are overridden
according to the function `f`.  The function `f` is called with
the original derivation attributes.

`overrideDerivation` allows certain "ad-hoc" customisation
scenarios (e.g. in ~/.config/nixpkgs/config.nix).  For instance,
if you want to "patch" the derivation returned by a package
function in Nixpkgs to build another version than what the
function itself provides.

For another application, see build-support/vm, where this
function is used to build arbitrary derivations inside a QEMU
virtual machine.

Note that in order to preserve evaluation errors, the new derivation's
outPath depends on the old one's, which means that this function cannot
be used in circular situations when the old derivation also depends on the
new one.

You should in general prefer `drv.overrideAttrs` over this function;
see the nixpkgs manual for more information on overriding.

# Inputs

`drv`

: 1\. Function argument

`f`

: 2\. Function argument

# Type

```
overrideDerivation :: Derivation -> ( Derivation -> AttrSet ) -> Derivation
```

# Examples
:::{.example}
## `lib.customisation.overrideDerivation` usage example

```nix
mySed = overrideDerivation pkgs.gnused (oldAttrs: {
  name = "sed-4.2.2-pre";
  src = fetchurl {
    url = ftp://alpha.gnu.org/gnu/sed/sed-4.2.2-pre.tar.bz2;
    hash = "sha256-MxBJRcM2rYzQYwJ5XKxhXTQByvSg5jZc5cSHEZoB2IY=";
  };
  patches = [];
});
```

:::

## Documentation for `makeOverridable`

*Function `makeOverridable` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/customisation.nix:153:5*

`makeOverridable` takes a function from attribute set to attribute set and
injects `override` attribute which can be used to override arguments of
the function.

Please refer to  documentation on [`<pkg>.overrideDerivation`](#sec-pkg-overrideDerivation) to learn about `overrideDerivation` and caveats
related to its use.

# Inputs

`f`

: 1\. Function argument

# Type

```
makeOverridable :: (AttrSet -> a) -> AttrSet -> a
```

# Examples
:::{.example}
## `lib.customisation.makeOverridable` usage example

```nix
nix-repl> x = {a, b}: { result = a + b; }

nix-repl> y = lib.makeOverridable x { a = 1; b = 2; }

nix-repl> y
{ override = «lambda»; overrideDerivation = «lambda»; result = 3; }

nix-repl> y.override { a = 10; }
{ override = «lambda»; overrideDerivation = «lambda»; result = 12; }
```

:::

## Documentation for `callPackageWith`

*Function `` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/customisation.nix:308:5*

NO_DOC_CONTENT

## Documentation for `callPackagesWith`

*Function `callPackagesWith` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/customisation.nix:358:5*

Like `callPackage`, but for a function that returns an attribute
set of derivations. The override function is added to the
individual attributes.

# Inputs

`autoArgs`

: 1\. Function argument

`fn`

: 2\. Function argument

`args`

: 3\. Function argument

# Type

```
callPackagesWith :: AttrSet -> ((AttrSet -> AttrSet) | Path) -> AttrSet -> AttrSet
```

## Documentation for `extendDerivation`

*Function `extendDerivation` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/customisation.nix:401:5*

Add attributes to each output of a derivation without changing
the derivation itself and check a given condition when evaluating.

# Inputs

`condition`

: 1\. Function argument

`passthru`

: 2\. Function argument

`drv`

: 3\. Function argument

# Type

```
extendDerivation :: Bool -> Any -> Derivation -> Derivation
```

## Documentation for `hydraJob`

*Function `hydraJob` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/customisation.nix:465:5*

Strip a derivation of all non-essential attributes, returning
only those needed by hydra-eval-jobs. Also strictly evaluate the
result to ensure that there are no thunks kept alive to prevent
garbage collection.

# Inputs

`drv`

: 1\. Function argument

# Type

```
hydraJob :: (Derivation | Null) -> (Derivation | Null)
```

## Documentation for `makeScope`

*Function `makeScope` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/customisation.nix:625:5*

Make an attribute set (a "scope") from functions that take arguments from that same attribute set.
See [](#ex-makeScope) for how to use it.

# Inputs

1. `newScope` (`AttrSet -> ((AttrSet -> a) | Path) -> AttrSet -> a`)

   A function that takes an attribute set `attrs` and returns what ends up as `callPackage` in the output.

   Typical values are `callPackageWith` or the output attribute `newScope`.

2. `f` (`AttrSet -> AttrSet`)

   A function that takes an attribute set as returned by `makeScope newScope f` (a "scope") and returns any attribute set.

   This function is used to compute the fixpoint of the resulting scope using `callPackage`.
   Its argument is the lazily evaluated reference to the value of that fixpoint, and is typically called `self` or `final`.

   See [](#ex-makeScope) for how to use it.
   See [](#sec-functions-library-fixedPoints) for details on fixpoint computation.

# Output

`makeScope` returns an attribute set of a form called `scope`, which also contains the final attributes produced by `f`:

```
scope :: {
  callPackage :: ((AttrSet -> a) | Path) -> AttrSet -> a
  newScope = AttrSet -> scope
  overrideScope = (scope -> scope -> AttrSet) -> scope
  packages :: AttrSet -> AttrSet
}
```

- `callPackage` (`((AttrSet -> a) | Path) -> AttrSet -> a`)

  A function that

  1. Takes a function `p`, or a path to a Nix file that contains a function `p`, which takes an attribute set and returns value of arbitrary type `a`,
  2. Takes an attribute set `args` with explicit attributes to pass to `p`,
  3. Calls `f` with attributes from the original attribute set `attrs` passed to `newScope` updated with `args`, i.e. `attrs // args`, if they match the attributes in the argument of `p`.

  All such functions `p` will be called with the same value for `attrs`.

  See [](#ex-makeScope-callPackage) for how to use it.

- `newScope` (`AttrSet -> scope`)

  Takes an attribute set `attrs` and returns a scope that extends the original scope.

- `overrideScope` (`(scope -> scope -> AttrSet) -> scope`)

  Takes a function `g` of the form `final: prev: { # attributes }` to act as an overlay on `f`, and returns a new scope with values determined by `extends g f`.
  See [](https://nixos.org/manual/nixpkgs/unstable/#function-library-lib.fixedPoints.extends) for details.

  This allows subsequent modification of the final attribute set in a consistent way, i.e. all functions `p` invoked with `callPackage` will be called with the modified values.

- `packages` (`AttrSet -> AttrSet`)

  The value of the argument `f` to `makeScope`.

- final attributes

  The final values returned by `f`.

# Examples

:::{.example #ex-makeScope}
# Create an interdependent package set on top of `pkgs`

The functions in `foo.nix` and `bar.nix` can depend on each other, in the sense that `foo.nix` can contain a function that expects `bar` as an attribute in its argument.

```nix
let
  pkgs = import <nixpkgs> { };
in
pkgs.lib.makeScope pkgs.newScope (self: {
  foo = self.callPackage ./foo.nix { };
  bar = self.callPackage ./bar.nix { };
})
```

evaluates to

```nix
{
  callPackage = «lambda»;
  newScope = «lambda»;
  overrideScope = «lambda»;
  packages = «lambda»;
  foo = «derivation»;
  bar = «derivation»;
}
```
:::

:::{.example #ex-makeScope-callPackage}
# Using `callPackage` from a scope

```nix
let
  pkgs = import <nixpkgs> { };
  inherit (pkgs) lib;
  scope = lib.makeScope lib.callPackageWith (self: { a = 1; b = 2; });
  three = scope.callPackage ({ a, b }: a + b) { };
  four = scope.callPackage ({ a, b }: a + b) { a = 2; };
in
[ three four ]
```

evaluates to

```nix
[ 3 4 ]
```
:::

# Type

```
makeScope :: (AttrSet -> ((AttrSet -> a) | Path) -> AttrSet -> a) -> (AttrSet -> AttrSet) -> Scope
```

## Documentation for `makeScopeWithSplicing`

*Function `makeScopeWithSplicing` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/customisation.nix:669:5*

backward compatibility with old uncurried form; deprecated

# Inputs

`splicePackages`

: 1\. Function argument

`newScope`

: 2\. Function argument

`otherSplices`

: 3\. Function argument

`keep`

: 4\. Function argument

`extra`

: 5\. Function argument

`f`

: 6\. Function argument

## Documentation for `makeScopeWithSplicing'`

*Function `makeScopeWithSplicing'` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/customisation.nix:704:5*

Like `makeScope`, but aims to support cross compilation. It's still ugly, but
hopefully it helps a little bit.

# Type

```
makeScopeWithSplicing' ::
  { splicePackages :: Splice -> AttrSet;
    newScope :: AttrSet -> ((AttrSet -> a) | Path) -> AttrSet -> a;
  }
  -> { otherSplices :: Splice; keep :: AttrSet -> AttrSet; extra :: AttrSet -> AttrSet; }
  -> AttrSet

Splice :: {
  pkgsBuildBuild :: AttrSet;
  pkgsBuildHost :: AttrSet;
  pkgsBuildTarget :: AttrSet;
  pkgsHostHost :: AttrSet;
  pkgsHostTarget :: AttrSet;
  pkgsTargetTarget :: AttrSet;
}
```

## Documentation for `extendMkDerivation`

*Function `extendMkDerivation` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/customisation.nix:855:5*

Define a `mkDerivation`-like function based on another `mkDerivation`-like function.

[`stdenv.mkDerivation`](#part-stdenv) gives access to
its final set of derivation attributes when it is passed a function,
or when it is passed an overlay-style function in `overrideAttrs`.

Instead of composing new `stdenv.mkDerivation`-like build helpers
using normal function composition,
`extendMkDerivation` makes sure that the returned build helper
supports such first class recursion like `mkDerivation` does.

`extendMkDerivation` takes an extra attribute set to configure its behaviour.
One can optionally specify
`transformDrv` to specify a function to apply to the result derivation,
or `inheritFunctionArgs` to decide whether to inherit the `__functionArgs`
from the base build helper.

# Inputs

`extendMkDerivation`-specific configurations
: `constructDrv` (required)
  : Base build helper, the `mkDerivation`-like build helper to extend.

  `excludeDrvArgNames` (default to `[ ]`)
  : Argument names not to pass from the input fixed-point arguments to `constructDrv`.
    It doesn't apply to the updating arguments returned by `extendDrvArgs`.

  `excludeFunctionArgNames` (default to `[ ]`)
  : `__functionArgs` attribute names to remove from the result build helper.
    `excludeFunctionArgNames` is useful for argument deprecation while avoiding ellipses.

  `extendDrvArgs` (required)
  : An extension (overlay) of the argument set, like the one taken by [`overrideAttrs`](#sec-pkg-overrideAttrs) but applied before passing to `constructDrv`.

  `inheritFunctionArgs` (default to `true`)
  : Whether to inherit `__functionArgs` from the base build helper.
    Set `inheritFunctionArgs` to `false` when `extendDrvArgs`'s `args` set pattern does not contain an ellipsis.

  `transformDrv` (default to `lib.id`)
  : Function to apply to the result derivation.

# Type

```
extendMkDerivation ::
  {
    constructDrv :: (FixedPointArgs | AttrSet) -> Derivation;
    excludeDrvArgNames :: [String];
    excludeFunctionArgNames :: [String];
    extendDrvArgs :: AttrSet -> AttrSet -> AttrSet;
    inheritFunctionArgs :: Bool;
    transformDrv :: Derivation -> Derivation;
  }
  -> ((FixedPointArgs | AttrSet) -> Derivation)

FixedPointArgs :: AttrSet -> AttrSet
```

# Examples

:::{.example}
## `lib.customisation.extendMkDerivation` usage example
```nix-repl
mkLocalDerivation = lib.extendMkDerivation {
  constructDrv = pkgs.stdenv.mkDerivation;
  excludeDrvArgNames = [ "specialArg" ];
  extendDrvArgs =
    finalAttrs: args@{ preferLocalBuild ? true, allowSubstitute ? false, specialArg ? (_: false), ... }:
    { inherit preferLocalBuild allowSubstitute; passthru = { inherit specialArg; } // args.passthru or { }; };
}

mkLocalDerivation.__functionArgs
=> { allowSubstitute = true; preferLocalBuild = true; specialArg = true; }

mkLocalDerivation { inherit (pkgs.hello) pname version src; specialArg = _: false; }
=> «derivation /nix/store/xirl67m60ahg6jmzicx43a81g635g8z8-hello-2.12.1.drv»

mkLocalDerivation (finalAttrs: { inherit (pkgs.hello) pname version src; specialArg = _: false; })
=> «derivation /nix/store/xirl67m60ahg6jmzicx43a81g635g8z8-hello-2.12.1.drv»

(mkLocalDerivation (finalAttrs: { inherit (pkgs.hello) pname version src; passthru = { foo = "a"; bar = "${finalAttrs.passthru.foo}b"; }; })).bar
=> "ab"
```
:::

:::{.note}
If `transformDrv` is specified,
it should take care of existing attributes that perform overriding
(e.g., [`overrideAttrs`](#sec-pkg-overrideAttrs))
to ensure that the overriding functionality of the result derivation
work as expected.
Modifications that breaks the overriding include
direct [attribute set update](https://nixos.org/manual/nix/stable/language/operators#update)
and [`lib.extendDerivation`](#function-library-lib.customisation.extendDerivation).
:::

## Documentation for `renameCrossIndexFrom`

*Function `renameCrossIndexFrom` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/customisation.nix:924:26*

Removes a prefix from the attribute names of a cross index.

A cross index (short for "Cross Platform Pair Index") is a 6-field structure
organizing values by cross-compilation platform relationships.

# Inputs

`prefix`
: The prefix to remove from cross index attribute names

`crossIndex`
: A cross index with prefixed names

# Type

```
renameCrossIndexFrom :: String -> AttrSet -> AttrSet
```

# Examples

:::{.example}
## `lib.customisation.renameCrossIndexFrom` usage example

```nix
renameCrossIndexFrom "pkgs" { pkgsBuildBuild = ...; pkgsBuildHost = ...; ... }
=> { buildBuild = ...; buildHost = ...; ... }
```
:::

## Documentation for `renameCrossIndexTo`

*Function `renameCrossIndexTo` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/customisation.nix:964:24*

Adds a prefix to the attribute names of a cross index.

A cross index (short for "Cross Platform Pair Index") is a 6-field structure
organizing values by cross-compilation platform relationships.

# Inputs

`prefix`
: The prefix to add to cross index attribute names

`crossIndex`
: A cross index to be prefixed

# Type

```
renameCrossIndexTo :: String -> AttrSet -> AttrSet
```

# Examples

:::{.example}
## `lib.customisation.renameCrossIndexTo` usage example

```nix
renameCrossIndexTo "self" { buildBuild = ...; buildHost = ...; ... }
=> { selfBuildBuild = ...; selfBuildHost = ...; ... }
```
:::

## Documentation for `mapCrossIndex`

*Function `mapCrossIndex` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/customisation.nix:1024:5*

Takes a function and applies it pointwise to each field of a cross index.

A cross index (short for "Cross Platform Pair Index") is a 6-field structure
organizing values by cross-compilation platform relationships.

# Inputs

`f`
: Function to apply to each cross index value

`crossIndex`
: A cross index to transform

# Type

```
mapCrossIndex :: (a -> b) -> {
  buildBuild :: a;
  buildHost :: a;
  buildTarget :: a;
  hostHost :: a;
  hostTarget :: a;
  targetTarget :: a;
} -> {
  buildBuild :: b;
  buildHost :: b;
  buildTarget :: b;
  hostHost :: b;
  hostTarget :: b;
  targetTarget :: b;
}
```

# Examples

:::{.example}
## `lib.customisation.mapCrossIndex` usage example

```nix
mapCrossIndex (x: x * 10) { buildBuild = 1; buildHost = 2; ... }
=> { buildBuild = 10; buildHost = 20; ... }
```

```nix
# Extract a package from package sets
mapCrossIndex (pkgs: pkgs.hello) crossIndexedPackageSets
```
:::

## Documentation for `lazyDerivation`

*Function `lazyDerivation` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/derivations.nix:99:5*

Restrict a derivation to a predictable set of attribute names, so
that the returned attrset is not strict in the actual derivation,
saving a lot of computation when the derivation is non-trivial.

This is useful in situations where a derivation might only be used for its
passthru attributes, improving evaluation performance.

The returned attribute set is lazy in `derivation`. Specifically, this
means that the derivation will not be evaluated in at least the
situations below.

For illustration and/or testing, we define derivation such that its
evaluation is very noticeable.

    let derivation = throw "This won't be evaluated.";

In the following expressions, `derivation` will _not_ be evaluated:

    (lazyDerivation { inherit derivation; }).type

    attrNames (lazyDerivation { inherit derivation; })

    (lazyDerivation { inherit derivation; } // { foo = true; }).foo

    (lazyDerivation { inherit derivation; meta.foo = true; }).meta

In these expressions, `derivation` _will_ be evaluated:

    "${lazyDerivation { inherit derivation }}"

    (lazyDerivation { inherit derivation }).outPath

    (lazyDerivation { inherit derivation }).meta

And the following expressions are not valid, because the refer to
implementation details and/or attributes that may not be present on
some derivations:

    (lazyDerivation { inherit derivation }).buildInputs

    (lazyDerivation { inherit derivation }).passthru

    (lazyDerivation { inherit derivation }).pythonPath

# Inputs

Takes an attribute set with the following attributes

`derivation`
: The derivation to be wrapped.

`meta`
: Optional meta attribute.

  While this function is primarily about derivations, it can improve
  the `meta` package attribute, which is usually specified through
  `mkDerivation`.

`passthru`
: Optional extra values to add to the returned attrset.

  This can be used for adding package attributes, such as `tests`.

`outputs`
: Optional list of assumed outputs. Default: `[ "out" ]`

  This must match the set of outputs that the returned derivation has.
  You must use this when the derivation has multiple outputs.

## Documentation for `optionalDrvAttr`

*Function `optionalDrvAttr` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/derivations.nix:219:21*

Conditionally set a derivation attribute.

Because `mkDerivation` sets `__ignoreNulls = true`, a derivation
attribute set to `null` will not impact the derivation output hash.
Thus, this function passes through its `value` argument if the `cond`
is `true`, but returns `null` if not.

# Inputs

`cond`

: Condition

`value`

: Attribute value

# Type

```
optionalDrvAttr :: Bool -> a -> (a | Null)
```

# Examples
:::{.example}
## `lib.derivations.optionalDrvAttr` usage example

```nix
(stdenv.mkDerivation {
  name = "foo";
  x = optionalDrvAttr true 1;
  y = optionalDrvAttr false 1;
}).drvPath == (stdenv.mkDerivation {
  name = "foo";
  x = 1;
}).drvPath
=> true
```

:::

## Documentation for `warnOnInstantiate`

*Function `warnOnInstantiate` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/derivations.nix:255:5*

Wrap a derivation such that instantiating it produces a warning.

All attributes will be wrapped with `lib.warn` except from `.meta`, `.name`,
and `.type` which are used by `nix search`, and `.outputName` which avoids
double warnings with `nix-instantiate` and `nix-build`.

# Inputs

`msg`
: The warning message to emit (via `lib.warn`).

`drv`
: The derivation to wrap.

# Type

```
warnOnInstantiate :: String -> Derivation -> Derivation
```

# Examples
:::{.example}
## `lib.derivations.warnOnInstantiate` usage example

```nix
{
  myPackage = warnOnInstantiate "myPackage has been renamed to my-package" my-package;
}
```

:::

## Documentation for `mkLuaInline`

*Function `mkLuaInline` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/generators.nix:901:17*

Mark string as Lua expression to be inlined when processed by `toLua`.

# Inputs

`expr`

: 1\. Function argument

# Type

```
mkLuaInline :: String -> { _type = "lua-inline"; expr :: String; }
```

## Documentation for `addMetaAttrs`

*Function `addMetaAttrs` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/meta.nix:57:5*

Add to or override the meta attributes of the given
derivation.

# Inputs

`newAttrs`

: 1\. Function argument

`drv`

: 2\. Function argument

# Type

```
addMetaAttrs :: AttrSet -> Derivation -> Derivation
```

# Examples
:::{.example}
## `lib.meta.addMetaAttrs` usage example

```nix
addMetaAttrs {description = "Bla blah";} somePkg
```

:::

## Documentation for `dontDistribute`

*Function `dontDistribute` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/meta.nix:80:20*

Disable Hydra builds of given derivation.

# Inputs

`drv`

: 1\. Function argument

# Type

```
dontDistribute :: Derivation -> Derivation
```

## Documentation for `setName`

*Function `setName` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/meta.nix:105:13*

Change the [symbolic name of a derivation](https://nixos.org/manual/nix/stable/language/derivations.html#attr-name).

:::{.warning}
Dependent derivations will be rebuilt when the symbolic name is changed.
:::

# Inputs

`name`

: 1\. Function argument

`drv`

: 2\. Function argument

# Type

```
setName :: String -> Derivation -> Derivation
```

## Documentation for `updateName`

*Function `updateName` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/meta.nix:136:16*

Like `setName`, but takes the previous name as an argument.

# Inputs

`updater`

: 1\. Function argument

`drv`

: 2\. Function argument

# Type

```
updateName :: (String -> String) -> Derivation -> Derivation
```

# Examples
:::{.example}
## `lib.meta.updateName` usage example

```nix
updateName (oldName: oldName + "-experimental") somePkg
```

:::

## Documentation for `appendToName`

*Function `appendToName` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/meta.nix:155:5*

Append a suffix to the name of a package (before the version
part).

# Inputs

`suffix`

: 1\. Function argument

# Type

```
appendToName :: String -> Derivation -> Derivation
```

## Documentation for `mapDerivationAttrset`

*Function `mapDerivationAttrset` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/meta.nix:184:5*

Apply a function to each derivation and only to derivations in an attrset.

# Inputs

`f`

: 1\. Function argument

`set`

: 2\. Function argument

# Type

```
mapDerivationAttrset :: (Derivation -> a) -> AttrSet -> AttrSet
```

## Documentation for `setPrio`

*Function `setPrio` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/meta.nix:208:13*

Set the nix-env priority of the package. Note that higher values are lower priority, and vice versa.

# Inputs

`priority`
: 1\. The priority to set.

`drv`
: 2\. Function argument

# Type

```
setPrio :: Int -> Derivation -> Derivation
```

## Documentation for `lowPrio`

*Function `addMetaAttrs` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/meta.nix:57:15*

Add to or override the meta attributes of the given
derivation.

# Inputs

`newAttrs`

: 1\. Function argument

`drv`

: 2\. Function argument

# Type

```
addMetaAttrs :: AttrSet -> Derivation -> Derivation
```

# Examples
:::{.example}
## `lib.meta.addMetaAttrs` usage example

```nix
addMetaAttrs {description = "Bla blah";} somePkg
```

:::

## Documentation for `lowPrioSet`

*Function `lowPrioSet` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/meta.nix:243:16*

Apply `lowPrio` to an attrset with derivations.

# Inputs

`set`

: 1\. Function argument

# Type

```
lowPrioSet :: { [String] :: Derivation } -> { [String] :: Derivation }
```

## Documentation for `hiPrio`

*Function `addMetaAttrs` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/meta.nix:57:15*

Add to or override the meta attributes of the given
derivation.

# Inputs

`newAttrs`

: 1\. Function argument

`drv`

: 2\. Function argument

# Type

```
addMetaAttrs :: AttrSet -> Derivation -> Derivation
```

# Examples
:::{.example}
## `lib.meta.addMetaAttrs` usage example

```nix
addMetaAttrs {description = "Bla blah";} somePkg
```

:::

## Documentation for `hiPrioSet`

*Function `hiPrioSet` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/meta.nix:278:15*

Apply `hiPrio` to an attrset with derivations.

# Inputs

`set`

: 1\. Function argument

# Type

```
hiPrioSet :: { [String] :: Derivation } -> { [String] :: Derivation }
```

## Documentation for `getLicenseFromSpdxId`

*Function `getLicenseFromSpdxId` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/meta.nix:433:5*

Get the corresponding attribute in lib.licenses from the SPDX ID
or warn and fallback to `{ shortName = <license string>; }`.

For SPDX IDs, see https://spdx.org/licenses.
Note that some SPDX licenses might be missing.

# Type

```
getLicenseFromSpdxId :: String -> {
  deprecated :: Bool;
  free :: Bool;
  fullName :: String;
  redistributable :: Bool;
  shortName :: String;
  spdxId :: String;
  url :: String;
}
```

# Examples
:::{.example}
## `lib.meta.getLicenseFromSpdxId` usage example

```nix
lib.getLicenseFromSpdxId "MIT" == lib.licenses.mit
=> true
lib.getLicenseFromSpdxId "mIt" == lib.licenses.mit
=> true
lib.getLicenseFromSpdxId "MY LICENSE"
=> trace: warning: getLicenseFromSpdxId: No license matches the given SPDX ID: MY LICENSE
=> { shortName = "MY LICENSE"; }
```

:::

## Documentation for `getLicenseFromSpdxIdOr`

*Function `` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/meta.nix:495:5*

NO_DOC_CONTENT

## Documentation for `getExe`

*Function `getExe` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/meta.nix:526:5*

Get the path to the main program of a package based on `meta.mainProgram`

# Inputs

`x`

: 1\. Function argument

# Type

```
getExe :: Derivation -> StorePath
```

# Examples
:::{.example}
## `lib.meta.getExe` usage example

```nix
getExe pkgs.hello
=> "/nix/store/g124820p9hlv4lj8qplzxw1c44dxaw1k-hello-2.12/bin/hello"
getExe pkgs.mustache-go
=> "/nix/store/am9ml4f4ywvivxnkiaqwr0hyxka1xjsf-mustache-go-1.3.0/bin/mustache"
```

:::

## Documentation for `getExe'`

*Function `getExe'` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/meta.nix:572:5*

Get the path of a program of a derivation.

# Inputs

`x`

: 1\. Function argument

`y`

: 2\. Function argument

# Type

```
getExe' :: Derivation -> String -> StorePath
```

# Examples
:::{.example}
## `lib.meta.getExe'` usage example

```nix
getExe' pkgs.hello "hello"
=> "/nix/store/g124820p9hlv4lj8qplzxw1c44dxaw1k-hello-2.12/bin/hello"
getExe' pkgs.imagemagick "convert"
=> "/nix/store/5rs48jamq7k6sal98ymj9l4k2bnwq515-imagemagick-7.1.1-15/bin/convert"
```

:::

## Documentation for `pathType`

*Function `readFileType` defined at NO_SOURCE_PATH:0:0*

Determine the directory entry type of a filesystem node, being
      one of `"directory"`, `"regular"`, `"symlink"`, or `"unknown"`.

## Documentation for `pathIsDirectory`

*Function `pathIsDirectory` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/filesystem.nix:103:21*

Whether a path exists and is a directory.

# Inputs

`path`

: 1\. Function argument

# Type

```
pathIsDirectory :: Path -> Bool
```

# Examples
:::{.example}
## `lib.filesystem.pathIsDirectory` usage example

```nix
pathIsDirectory /.
=> true

pathIsDirectory /this/does/not/exist
=> false

pathIsDirectory /some/file.nix
=> false
```

:::

## Documentation for `pathIsRegularFile`

*Function `pathIsRegularFile` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/filesystem.nix:137:23*

Whether a path exists and is a regular file, meaning not a symlink or any other special file type.

# Inputs

`path`

: 1\. Function argument

# Type

```
pathIsRegularFile :: Path -> Bool
```

# Examples
:::{.example}
## `lib.filesystem.pathIsRegularFile` usage example

```nix
pathIsRegularFile /.
=> false

pathIsRegularFile /this/does/not/exist
=> false

pathIsRegularFile /some/file.nix
=> true
```

:::

## Documentation for `packagesFromDirectoryRecursive`

*Function `` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/filesystem.nix:417:5*

NO_DOC_CONTENT

## Documentation for `cleanSourceFilter`

*Function `` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/sources.nix:61:5*

NO_DOC_CONTENT

## Documentation for `cleanSource`

*Function `cleanSource` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/sources.nix:116:5*

Filters a source tree removing version control files and directories using `cleanSourceFilter`.

# Inputs

`src`

: 1\. Function argument

# Examples
:::{.example}
## `cleanSource` usage example

```nix
cleanSource ./.
```

:::

## Documentation for `sourceByRegex`

*Function `sourceByRegex` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/sources.nix:240:5*

Filter sources by a list of regular expressions.

# Inputs

`src`

: 1\. Function argument

`regexes`

: 2\. Function argument

# Examples
:::{.example}
## `sourceByRegex` usage example

```nix
src = sourceByRegex ./my-subproject [".*\\.py$" "^database\\.sql$"]
```

:::

## Documentation for `sourceFilesBySuffices`

*Function `sourceFilesBySuffices` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/sources.nix:290:5*

Get all files ending with the specified suffices from the given
source directory or its descendants, omitting files that do not match
any suffix. The result of the example below will include files like
`./dir/module.c` and `./dir/subdir/doc.xml` if present.

# Inputs

`src`

: Path or source containing the files to be returned

`exts`

: A list of file suffix strings

# Type

```
sourceFilesBySuffices :: SourceLike -> [String] -> Source
```

# Examples
:::{.example}
## `sourceFilesBySuffices` usage example

```nix
sourceFilesBySuffices ./. [ ".xml" ".c" ]
```

:::

## Documentation for `commitIdFromGitRepo`

*Function `commitIdFromGitRepo` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/sources.nix:325:5*

Get the commit id of a git repo.

# Inputs

`path`

: 1\. Function argument

# Examples
:::{.example}
## `commitIdFromGitRepo` usage example

```nix
commitIdFromGitRepo <nixpkgs/.git>
```

:::

## Documentation for `cleanSourceWith`

*Function `cleanSourceWith` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/sources.nix:148:5*

Like `builtins.filterSource`, except it will compose with itself,
allowing you to chain multiple calls together without any
intermediate copies being put in the nix store.

# Examples
:::{.example}
## `cleanSourceWith` usage example

```nix
lib.cleanSourceWith {
  filter = f;
  src = lib.cleanSourceWith {
    filter = g;
    src = ./.;
  };
}
# Succeeds!

builtins.filterSource f (builtins.filterSource g ./.)
# Fails!
```

:::

## Documentation for `pathHasContext`

*Function `hasContext` defined at NO_SOURCE_PATH:0:0*

Return `true` if string *s* has a non-empty context.
      The context can be obtained with
      [`getContext`](#builtins-getContext).

      > **Example**
      >
      > Many operations require a string context to be empty because they are intended only to work with "regular" strings, and also to help users avoid unintentionally loosing track of string context elements.
      > `builtins.hasContext` can help create better domain-specific errors in those case.
      >
      > ```nix
      > name: meta:
      >
      > if builtins.hasContext name
      > then throw "package name cannot contain string context"
      > else { ${name} = meta; }
      > ```

## Documentation for `canCleanSource`

*Function `canCleanSource` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/sources.nix:409:20*

NO_DOC_CONTENT

## Documentation for `pathIsGitRepo`

*Function `pathIsGitRepo` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/sources.nix:303:19*

NO_DOC_CONTENT

## Documentation for `revOrTag`

*Function `revOrTag` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/sources.nix:504:5*

NO_DOC_CONTENT

## Documentation for `repoRevToName`

*Function `repoRevToName` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/sources.nix:536:5*

NO_DOC_CONTENT

## Documentation for `setDefaultModuleLocation`

*Function `setDefaultModuleLocation` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/modules.nix:610:30*

Wrap a module with a default location for reporting errors.

# Inputs

`file`

: 1\. Function argument

`m`

: 2\. Function argument

## Documentation for `unifyModuleSyntax`

*Function `unifyModuleSyntax` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/modules.nix:634:5*

Massage a module into canonical form, that is, a set consisting
of ‘options’, ‘config’ and ‘imports’ attributes.

# Inputs

`file`

: 1\. Function argument

`key`

: 2\. Function argument

`m`

: 3\. Function argument

## Documentation for `applyModuleArgsIfFunction`

*Function `applyModuleArgsIfFunction` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/modules.nix:707:5*

NO_DOC_CONTENT

## Documentation for `mergeModules`

*Function `mergeModules` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/modules.nix:775:5*

Merge a list of modules.  This will recurse over the option
declarations in all modules, combining them into a single set.
At the same time, for each option declaration, it will merge the
corresponding option definitions in all machines, returning them
in the ‘value’ attribute of each option.

This returns a set like
  {
    # A recursive set of options along with their final values
    matchedOptions = {
      foo = { _type = "option"; value = "option value of foo"; ... };
      bar.baz = { _type = "option"; value = "option value of bar.baz"; ... };
      ...
    };
    # A list of definitions that weren't matched by any option
    unmatchedDefns = [
      { file = "file.nix"; prefix = [ "qux" ]; value = "qux"; }
      ...
    ];
  }

# Inputs

`prefix`

: 1\. Function argument

`modules`

: 2\. Function argument

## Documentation for `mergeModules'`

*Function `mergeModules'` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/modules.nix:787:5*

NO_DOC_CONTENT

## Documentation for `mergeOptionDecls`

*Function `mergeOptionDecls` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/modules.nix:1012:5*

Merge multiple option declarations into a single declaration.  In
general, there should be only one declaration of each option.
The exception is the ‘options’ attribute, which specifies
sub-options.  These can be specified multiple times to allow one
module to add sub-options to an option declared somewhere else
(e.g. multiple modules define sub-options for ‘fileSystems’).

'loc' is the list of attribute names where the option is located.

'opts' is a list of modules.  Each module has an options attribute which
correspond to the definition of 'loc' in 'opt.file'.

# Inputs

`loc`

: 1\. Function argument

`opts`

: 2\. Function argument

## Documentation for `mergeDefinitions`

*Function `mergeDefinitions` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/modules.nix:1186:22*

NO_DOC_CONTENT

## Documentation for `pushDownProperties`

*Function `` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/modules.nix:1348:5*

NO_DOC_CONTENT

## Documentation for `dischargeProperties`

*Function `dischargeProperties` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/modules.nix:1377:5*

Given a config value, expand mkMerge properties, and discharge
any mkIf conditions.  That is, this is the place where mkIf
conditions are actually evaluated.  The result is a list of
config values.  For example, ‘mkIf false x’ yields ‘[]’,
‘mkIf true x’ yields ‘[x]’, and

  mkMerge [ 1 (mkIf true 2) (mkIf true (mkIf false 3)) ]

yields ‘[ 1 2 ]’.

# Inputs

`def`

: 1\. Function argument

## Documentation for `filterOverrides`

*Function `filterOverrides` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/modules.nix:1414:21*

Given a list of config values, process the mkOverride properties,
that is, return the values that have the highest (that is,
numerically lowest) priority, and strip the mkOverride
properties.  For example,

  [ { file = "/1"; value = mkOverride 10 "a"; }
    { file = "/2"; value = mkOverride 20 "b"; }
    { file = "/3"; value = "z"; }
    { file = "/4"; value = mkOverride 10 "d"; }
  ]

yields

  [ { file = "/1"; value = "a"; }
    { file = "/4"; value = "d"; }
  ]

Note that "z" has the default priority 100.

# Inputs

`defs`

: 1\. Function argument

## Documentation for `sortProperties`

*Function `sortProperties` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/modules.nix:1451:5*

Sort a list of properties.  The sort priority of a property is
defaultOrderPriority by default, but can be overridden by wrapping the property
using mkOrder.

# Inputs

`defs`

: 1\. Function argument

## Documentation for `fixupOptionType`

*Function `fixupOptionType` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/modules.nix:1472:5*

NO_DOC_CONTENT

## Documentation for `mkIf`

*Function `mkIf` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/modules.nix:1544:10*

Properties.

# Inputs

`condition`

: 1\. Function argument

`content`

: 2\. Function argument

## Documentation for `mkAssert`

*Function `mkAssert` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/modules.nix:1550:5*

NO_DOC_CONTENT

## Documentation for `mkDefinition`

*Function `mkDefinition` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/modules.nix:1561:18*

Returns a definition with file location information.

## Documentation for `mkMerge`

*Function `mkMerge` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/modules.nix:1553:13*

NO_DOC_CONTENT

## Documentation for `mkOverride`

*Function `mkOverride` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/modules.nix:1563:16*

NO_DOC_CONTENT

## Documentation for `mkOptionDefault`

*Function `mkOverride` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/modules.nix:1563:26*

NO_DOC_CONTENT

## Documentation for `mkDefault`

*Function `mkOverride` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/modules.nix:1563:26*

NO_DOC_CONTENT

## Documentation for `mkImageMediaOverride`

*Function `mkOverride` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/modules.nix:1563:26*

NO_DOC_CONTENT

## Documentation for `mkForce`

*Function `mkOverride` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/modules.nix:1563:26*

NO_DOC_CONTENT

## Documentation for `mkVMOverride`

*Function `mkOverride` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/modules.nix:1563:26*

NO_DOC_CONTENT

## Documentation for `mkFixStrictness`

*Function `id` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/trivial.nix:63:8*

The identity function
For when you need a function that does “nothing”.

# Inputs

`x`

: The value to return

# Type

```
id :: a -> a
```

## Documentation for `mkOrder`

*Function `mkOrder` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/modules.nix:1577:13*

NO_DOC_CONTENT

## Documentation for `mkBefore`

*Function `mkOrder` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/modules.nix:1577:23*

NO_DOC_CONTENT

## Documentation for `mkAfter`

*Function `mkOrder` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/modules.nix:1577:23*

NO_DOC_CONTENT

## Documentation for `mkAliasDefinitions`

*Function `mkAliasAndWrapDefinitions` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/modules.nix:1628:37*

NO_DOC_CONTENT

## Documentation for `mkAliasAndWrapDefinitions`

*Function `mkAliasAndWrapDefinitions` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/modules.nix:1628:31*

NO_DOC_CONTENT

## Documentation for `fixMergeModules`

*Function `fixMergeModules` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/modules.nix:1660:5*

Compatibility.

# Inputs

`modules`

: 1\. Function argument

`args`

: 2\. Function argument

## Documentation for `mkRemovedOptionModule`

*Function `mkRemovedOptionModule` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/modules.nix:1690:5*

Returns a module that causes a warning to be shown if the
specified option is defined. For example,

  mkRemovedOptionModule [ "boot" "loader" "grub" "bootDevice" ] "<replacement instructions>"

causes a assertion if the user defines boot.loader.grub.bootDevice.

replacementInstructions is a string that provides instructions on
how to achieve the same functionality without the removed option,
or alternatively a reasoning why the functionality is not needed.
replacementInstructions SHOULD be provided!

# Inputs

`optionName`

: 1\. Function argument

`replacementInstructions`

: 2\. Function argument

## Documentation for `mkRenamedOptionModule`

*Function `mkRenamedOptionModule` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/modules.nix:1749:5*

Returns a module that causes a warning to be shown if the
specified "from" option is defined; the defined value is however
forwarded to the "to" option. This can be used to rename options
while providing backward compatibility. For example,

  mkRenamedOptionModule [ "boot" "copyKernels" ] [ "boot" "loader" "grub" "copyKernels" ]

forwards any definitions of boot.copyKernels to
boot.loader.grub.copyKernels while printing a warning.

This also copies over the priority from the aliased option to the
non-aliased option.

# Inputs

`from`

: The "from" option path as list of strings.
  Option must not exist in the current module set.

`to`

: The "to" option path as list of strings.
  Option must already exist in the current module set.

# Limitations

- The "to" option must already be declared.
- The "from" option should not be declared, as this function will declare it.
- "to" Options whose types don't support merging at any level of their structure (like `types.raw`,
  or `types.attrsOf types.raw` where the attribute values can't merge) are not well-supported
  because this function wraps aliased definitions in `mkMerge`.

## Documentation for `mkRenamedOptionModuleWith`

*Function `mkRenamedOptionModuleWith` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/modules.nix:1758:5*

NO_DOC_CONTENT

## Documentation for `mkMergedOptionModule`

*Function `mkMergedOptionModule` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/modules.nix:1824:5*

Returns a module that causes a warning to be shown if any of the "from"
option is defined; the defined values can be used in the "mergeFn" to set
the "to" value.
This function can be used to merge multiple options into one that has a
different type.

"mergeFn" takes the module "config" as a parameter and must return a value
of "to" option type.

  mkMergedOptionModule
    [ [ "a" "b" "c" ]
      [ "d" "e" "f" ] ]
    [ "x" "y" "z" ]
    (config:
      let value = p: getAttrFromPath p config;
      in
      if      (value [ "a" "b" "c" ]) == true then "foo"
      else if (value [ "d" "e" "f" ]) == true then "bar"
      else "baz")

- options.a.b.c is a removed boolean option
- options.d.e.f is a removed boolean option
- options.x.y.z is a new str option that combines a.b.c and d.e.f
  functionality

This show a warning if any a.b.c or d.e.f is set, and set the value of
x.y.z to the result of the merge function

# Inputs

`from`

: 1\. Function argument

`to`

: 2\. Function argument

`mergeFn`

: 3\. Function argument

## Documentation for `mkChangedOptionModule`

*Function `mkChangedOptionModule` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/modules.nix:1897:5*

Single "from" version of mkMergedOptionModule.
Returns a module that causes a warning to be shown if the "from" option is
defined; the defined value can be used in the "mergeFn" to set the "to"
value.
This function can be used to change an option into another that has a
different type.

"mergeFn" takes the module "config" as a parameter and must return a value of
"to" option type.

  mkChangedOptionModule [ "a" "b" "c" ] [ "x" "y" "z" ]
    (config:
      let value = getAttrFromPath [ "a" "b" "c" ] config;
      in
      if   value > 100 then "high"
      else "normal")

- options.a.b.c is a removed int option
- options.x.y.z is a new str option that supersedes a.b.c

This show a warning if a.b.c is set, and set the value of x.y.z to the
result of the change function

# Inputs

`from`

: 1\. Function argument

`to`

: 2\. Function argument

`changeFn`

: 3\. Function argument

## Documentation for `mkAliasOptionModule`

*Function `mkAliasOptionModule` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/modules.nix:1914:5*

Like ‘mkRenamedOptionModule’, but doesn't show a warning.

# Inputs

`from`

: 1\. Function argument

`to`

: 2\. Function argument

## Documentation for `mkDerivedConfig`

*Function `mkDerivedConfig` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/modules.nix:1954:21*

mkDerivedConfig : Option a -> (a -> Definition b) -> Definition b

Create config definitions with the same priority as the definition of another option.
This should be used for option definitions where one option sets the value of another as a convenience.
For instance a config file could be set with a `text` or `source` option, where text translates to a `source`
value using `mkDerivedConfig options.text (pkgs.writeText "filename.conf")`.

It takes care of setting the right priority using `mkOverride`.

# Inputs

`opt`

: 1\. Function argument

`f`

: 2\. Function argument

## Documentation for `doRename`

*Function `doRename` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/modules.nix:1961:5*

Returns a module that help declares an option that has been renamed.
When a value is defined for the old option, it is forwarded to the `to` option.

## Documentation for `mkAliasOptionModuleMD`

*Function `mkAliasOptionModule` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/modules.nix:1914:5*

Like ‘mkRenamedOptionModule’, but doesn't show a warning.

# Inputs

`from`

: 1\. Function argument

`to`

: 2\. Function argument

## Documentation for `evalOptionValue`

*Function `evalOptionValue` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/modules.nix:1102:5*

Merge all the definitions of an option to produce the final
config value.

# Inputs

`loc`

: 1\. Function argument

`opt`

: 2\. Function argument

`defs`

: 3\. Function argument

## Documentation for `isOption`

*Function `isType` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/types.nix:150:18*

NO_DOC_CONTENT

## Documentation for `mkEnableOption`

*Function `mkEnableOption` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/options.nix:188:5*

Creates an option declaration with a default value of `false`, and can be defined to `true`.

# Inputs

`name`

: Name for the created option

# Examples
:::{.example}
## `lib.options.mkEnableOption` usage example

```nix
# module
let
  eval = lib.evalModules {
    modules = [
      {
        options.foo.enable = mkEnableOption "foo";

        config.foo.enable = true;
      }
    ];
  };
in
eval.config
=> { foo.enable = true; }
```

:::

## Documentation for `mkSinkUndeclaredOptions`

*Function `mkSinkUndeclaredOptions` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/options.nix:362:5*

This option accepts arbitrary definitions, but it does not produce an option value.

This is useful for sharing a module across different module sets
without having to implement similar features as long as the
values of the options are not accessed.

# Inputs

`attrs`

: Attribute set whose attributes override the argument to `mkOption`.

## Documentation for `mergeDefaultOption`

*Function `mergeDefaultOption` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/options.nix:424:5*

A merge function that merges multiple definitions of an option into a single value

:::{.caution}
This function is used as the default merge operation in `lib.types.mkOptionType`. In most cases, explicit usage of this function is unnecessary.
:::

# Inputs

`loc`
: location of the option in the configuration as a list of strings.

  e.g. `["boot" "loader "grub" "enable"]`

`defs`
: list of definition values and locations.

  e.g. `[ { file = "/foo.nix"; value = 1; } { file = "/bar.nix"; value = 2 } ]`

# Example
:::{.example}
## `lib.options.mergeDefaultOption` usage example

```nix
myType = mkOptionType {
  name = "myType";
  merge = mergeDefaultOption; # <- This line is redundant. It is the default already.
};
```

:::

# Merge behavior

Merging requires all definition values to have the same type.

- If all definitions are booleans, the result of a `foldl'` with the `or` operation is returned.
- If all definitions are strings, they are concatenated. (`lib.concatStrings`)
- If all definitions are integers and all are equal, the first one is returned.
- If all definitions are lists, they are concatenated. (`++`)
- If all definitions are attribute sets, they are merged. (`lib.mergeAttrs`)
- If all definitions are functions, the first function is applied to the result of the second function. (`f -> x: f x`)
- Otherwise, an error is thrown.

## Documentation for `mergeOneOption`

*Function `mergeUniqueOption` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/options.nix:480:5*

Require a single definition.

::: {.note}
When the type is not checked completely by check, pass a merge function for further checking (of sub-attributes, etc).
:::

# Inputs

`loc`

: 2\. Function argument

`defs`

: 3\. Function argument

## Documentation for `mergeEqualOption`

*Function `mergeEqualOption` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/options.nix:501:5*

"Merge" option definitions by checking that they all have the same value.

# Inputs

`loc`

: 1\. Function argument

`defs`

: 2\. Function argument

## Documentation for `mergeUniqueOption`

*Function `mergeUniqueOption` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/options.nix:472:5*

Require a single definition.

::: {.note}
When the type is not checked completely by check, pass a merge function for further checking (of sub-attributes, etc).
:::

# Inputs

`loc`

: 2\. Function argument

`defs`

: 3\. Function argument

## Documentation for `optionAttrSetToDocList`

*Function `optionAttrSetToDocList'` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/options.nix:572:8*

NO_DOC_CONTENT

## Documentation for `optionAttrSetToDocList'`

*Function `optionAttrSetToDocList'` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/options.nix:572:5*

NO_DOC_CONTENT

## Documentation for `scrubOptionValue`

*Function `scrubOptionValue` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/options.nix:647:5*

This function recursively removes all derivation attributes from
`x` except for the `name` attribute.

This is to make the generation of `options.xml` much more
efficient: the XML representation of derivations is very large
(on the order of megabytes) and is not actually used by the
manual generator.

This function was made obsolete by `renderOptionValue` and is kept for
compatibility with out-of-tree code.

# Inputs

`x`

: 1\. Function argument

## Documentation for `literalExpression`

*Function `literalExpression` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/options.nix:716:5*

For use in the `defaultText` and `example` option attributes. Causes the
given string to be rendered verbatim in the documentation as Nix code. This
is necessary for complex values, e.g. functions, or values that depend on
other values or packages.

# Examples
:::{.example}
## `literalExpression` usage example

```nix
llvmPackages = mkOption {
  type = types.str;
  description = ''
    Version of llvm packages to use for
    this module
  '';
  example = literalExpression ''
    llvmPackages = pkgs.llvmPackages_20;
  '';
};
```

:::

# Inputs

`text`

: The text to render as a Nix expression

## Documentation for `showOption`

*Function `showOption` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/options.nix:819:5*

Convert an option, described as a list of the option parts to a
human-readable version.

# Inputs

`parts`

: 1\. Function argument

# Examples
:::{.example}
## `showOption` usage example

```nix
(showOption ["foo" "bar" "baz"]) == "foo.bar.baz"
  (showOption ["foo" "bar.baz" "tux"]) == "foo.\"bar.baz\".tux"
  (showOption ["windowManager" "2bwm" "enable"]) == "windowManager.\"2bwm\".enable"

Placeholders will not be quoted as they are not actual values:
  (showOption ["foo" "*" "bar"]) == "foo.*.bar"
  (showOption ["foo" "<name>" "bar"]) == "foo.<name>.bar"
  (showOption ["foo" "<myPlaceholder>" "bar"]) == "foo.<myPlaceholder>.bar"
```

:::

## Documentation for `showOptionWithDefLocs`

*Function `showOptionWithDefLocs` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/options.nix:906:27*

Pretty prints all option definition locations

# Inputs

`option`
: The option to pretty print

# Examples
:::{.example}
## `lib.options.showOptionWithDefLocs` usage example

```nix
showOptionWithDefLocs { loc = ["x" "y" ]; files = [ "foo.nix" "bar.nix" ];  }
"x.y, with values defined in:\n  - foo.nix\n  - bar.nix\n"
```

```nix
nix-repl> eval = lib.evalModules {
    modules = [
      {
        options = {
          foo = lib.mkEnableOption "foo";
        };
      }
    ];
  }

nix-repl> lib.options.showOptionWithDefLocs eval.options.foo
"foo, with values defined in:\n  - <unknown-file>\n"
```

:::

# Type

```
showOptionWithDefLocs :: { files :: [String]; loc :: [String]; ... } -> String
```

## Documentation for `showFiles`

*Function `showFiles` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/options.nix:833:15*

NO_DOC_CONTENT

## Documentation for `mkOption`

*Function `mkOption` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/options.nix:141:5*

Creates an Option declaration for use with the module system.

# Inputs

Attribute set
: containing none or some of the following attributes.

  `default`
  : Optional default value used when no definition is given in the configuration.

  `defaultText`
  : Substitute for documenting the `default`, if evaluating the default value during documentation rendering is not possible.
  : Can be any nix value that evaluates.
  : Usage with `lib.literalMD`, `lib.literalExpression`, or `lib.literalCode` is supported

  `example`
  : Optional example value used in the manual.
  : Can be any nix value that evaluates.
  : Usage with `lib.literalMD`, `lib.literalExpression`, or `lib.literalCode` is supported

  `description`
  : Optional string describing the option. This is required if option documentation is generated.

  `relatedPackages`
  : Optional related packages used in the manual (see `genRelatedPackages` in `../nixos/lib/make-options-doc/default.nix`).

  `type`
  : Optional option type, providing type-checking and value merging.

  `apply`
  : Optional function that converts the option value to something else.

  `internal`
  : Optional boolean indicating whether the option is for NixOS developers only.

  `visible`
  : Optional, whether the option and/or sub-options show up in the manual.
    Use false to hide the option and any sub-options from submodules.
    Use "shallow" to hide only sub-options.
    Use "transparent" to hide this option, but not its sub-options.
    Default: true.

  `readOnly`
  : Optional boolean indicating whether the option can be set only once.

# Examples
:::{.example}
## `lib.options.mkOption` usage example

```nix
mkOption { }
# => Empty option; type = types.anything

mkOption { default = "foo"; }
# => Same as above, with a default value
```

:::

## Documentation for `mkPackageOption`

*Function `mkPackageOption` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/options.nix:310:5*

Creates an Option attribute set for an option that specifies the
package a module should use for some purpose.

The package is specified in the third argument under `default` as a list of strings
representing its attribute path in nixpkgs (or another package set).
Because of this, you need to pass nixpkgs itself (usually `pkgs` in a module;
alternatively to nixpkgs itself, another package set) as the first argument.

If you pass another package set you should set the `pkgsText` option.
This option is used to display the expression for the package set. It is `"pkgs"` by default.
If your expression is complex you should parenthesize it, as the `pkgsText` argument
is usually immediately followed by an attribute lookup (`.`).

The second argument may be either a string or a list of strings.
It provides the display name of the package in the description of the generated option
(using only the last element if the passed value is a list)
and serves as the fallback value for the `default` argument.

To include extra information in the description, pass `extraDescription` to
append arbitrary text to the generated description.

You can also pass an `example` value, either a literal string or an attribute path.

The `default` argument can be omitted if the provided name is
an attribute of pkgs (if `name` is a string) or a valid attribute path in pkgs (if `name` is a list).
You can also set `default` to just a string in which case it is interpreted as an attribute name
(a singleton attribute path, if you will).

If you wish to explicitly provide no default, pass `null` as `default`.

If you want users to be able to set no package, pass `nullable = true`.
In this mode a `default = null` will not be interpreted as no default and is interpreted literally.

# Inputs

`pkgs`

: Package set (an instantiation of nixpkgs such as pkgs in modules or another package set)

`name`

: Name for the package, shown in option description

Structured function argument
: Attribute set containing the following attributes.

  `nullable`
  : Optional whether the package can be null, for example to disable installing a package altogether. Default: `false`

  `default`
  : Optional attribute path where the default package is located. Default: `name`
    If omitted will be copied from `name`

  `example`
  : Optional string or an attribute path to use as an example. Default: `null`

  `extraDescription`
  : Optional additional text to include in the option description. Default: `""`

  `pkgsText`
  : Optional representation of the package set passed as pkgs. Default: `"pkgs"`

# Type

```
mkPackageOption :: Pkgs -> (String | [String]) -> { nullable? :: Bool; default? :: String | [String]; example? :: Null | String | [String]; extraDescription? :: String; pkgsText? :: String; } -> Option
```

# Examples
:::{.example}
## `lib.options.mkPackageOption` usage example

```nix
mkPackageOption pkgs "hello" { }
=> { ...; default = pkgs.hello; defaultText = literalExpression "pkgs.hello"; description = "The hello package to use."; type = package; }

mkPackageOption pkgs "GHC" {
  default = [ "ghc" ];
  example = "pkgs.haskellPackages.ghc.withPackages (hkgs: [ hkgs.primes ])";
}
=> { ...; default = pkgs.ghc; defaultText = literalExpression "pkgs.ghc"; description = "The GHC package to use."; example = literalExpression "pkgs.haskellPackages.ghc.withPackages (hkgs: [ hkgs.primes ])"; type = package; }

mkPackageOption pkgs [ "python3Packages" "pytorch" ] {
  extraDescription = "This is an example and doesn't actually do anything.";
}
=> { ...; default = pkgs.python3Packages.pytorch; defaultText = literalExpression "pkgs.python3Packages.pytorch"; description = "The pytorch package to use. This is an example and doesn't actually do anything."; type = package; }

mkPackageOption pkgs "nushell" {
  nullable = true;
}
=> { ...; default = pkgs.nushell; defaultText = literalExpression "pkgs.nushell"; description = "The nushell package to use."; type = nullOr package; }

mkPackageOption pkgs "coreutils" {
  default = null;
}
=> { ...; description = "The coreutils package to use."; type = package; }

mkPackageOption pkgs "dbus" {
  nullable = true;
  default = null;
}
=> { ...; default = null; description = "The dbus package to use."; type = nullOr package; }

mkPackageOption pkgs.javaPackages "OpenJFX" {
  default = "openjfx20";
  pkgsText = "pkgs.javaPackages";
}
=> { ...; default = pkgs.javaPackages.openjfx20; defaultText = literalExpression "pkgs.javaPackages.openjfx20"; description = "The OpenJFX package to use."; type = package; }
```

:::

## Documentation for `literalMD`

*Function `literalMD` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/options.nix:780:5*

For use in the `defaultText` and `example` option attributes. Causes the
given MD text to be inserted verbatim in the documentation, for when
a `literalExpression` would be too hard to read.

# Inputs

`text`

: 1\. Function argument

## Documentation for `isType`

*Function `isType` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/types.nix:150:12*

NO_DOC_CONTENT

## Documentation for `setType`

*Function `setType` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/types.nix:153:5*

NO_DOC_CONTENT

## Documentation for `defaultTypeMerge`

*Function `defaultTypeMerge` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/types.nix:162:5*

NO_DOC_CONTENT

## Documentation for `defaultFunctor`

*Function `defaultFunctor` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/types.nix:181:20*

NO_DOC_CONTENT

## Documentation for `isOptionType`

*Function `isType` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/types.nix:150:18*

NO_DOC_CONTENT

## Documentation for `mkOptionType`

*Function `mkOptionType` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/types.nix:190:5*

NO_DOC_CONTENT

## Documentation for `assertMsg`

*Function `assertMsg` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/asserts.nix:53:15*

Throw if `pred` is false, else return `pred`.
Intended to be used to augment asserts with helpful error messages.

# Inputs

`pred`

: Predicate that needs to succeed, otherwise `msg` is thrown

`msg`

: Message to throw in case `pred` fails

# Type

```
assertMsg :: Bool -> String -> Bool
```

# Examples
:::{.example}
## `lib.asserts.assertMsg` usage example

```nix
assertMsg false "nope"
stderr> error: nope
assert assertMsg ("foo" == "bar") "foo is not bar, silly"; ""
stderr> error: foo is not bar, silly
```

:::

## Documentation for `assertOneOf`

*Function `assertOneOf` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/asserts.nix:95:5*

Specialized `assertMsg` for checking if `val` is one of the elements
of the list `xs`. Useful for checking enums.

# Inputs

`name`

: The name of the variable the user entered `val` into, for inclusion in the error message

`val`

: The value of what the user provided, to be compared against the values in `xs`

`xs`

: The list of valid values

# Type

```
assertOneOf :: String -> ComparableVal -> [ComparableVal] -> Bool
```

# Examples
:::{.example}
## `lib.asserts.assertOneOf` usage example

```nix
let sslLibrary = "libressl";
in assertOneOf "sslLibrary" sslLibrary [ "openssl" "bearssl" ]
stderr> error: sslLibrary must be one of [
stderr>   "openssl"
stderr>   "bearssl"
stderr> ], but is: "libressl"
```

:::

## Documentation for `traceIf`

*Function `traceIf` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/debug.nix:79:5*

Conditionally trace the supplied message, based on a predicate.

# Inputs

`pred`

: Predicate to check

`msg`

: Message that should be traced

`x`

: Value to return

# Type

```
traceIf :: Bool -> String -> a -> a
```

# Examples
:::{.example}
## `lib.debug.traceIf` usage example

```nix
traceIf true "hello" 3
trace: hello
=> 3
```

:::

## Documentation for `traceVal`

*Function `traceValFn` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/debug.nix:114:19*

Trace the supplied value after applying a function to it, and
return the original value.

# Inputs

`f`

: Function to apply

`x`

: Value to trace and return

# Type

```
traceValFn :: (a -> b) -> a -> a
```

# Examples
:::{.example}
## `lib.debug.traceValFn` usage example

```nix
traceValFn (v: "mystring ${v}") "foo"
trace: mystring foo
=> "foo"
```

:::

## Documentation for `traceValFn`

*Function `traceValFn` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/debug.nix:114:16*

Trace the supplied value after applying a function to it, and
return the original value.

# Inputs

`f`

: Function to apply

`x`

: Value to trace and return

# Type

```
traceValFn :: (a -> b) -> a -> a
```

# Examples
:::{.example}
## `lib.debug.traceValFn` usage example

```nix
traceValFn (v: "mystring ${v}") "foo"
trace: mystring foo
=> "foo"
```

:::

## Documentation for `traceSeq`

*Function `traceSeq` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/debug.nix:179:14*

`builtins.trace`, but the value is `builtins.deepSeq`ed first.

# Inputs

`x`

: The value to trace

`y`

: The value to return

# Type

```
traceSeq :: a -> b -> b
```

# Examples
:::{.example}
## `lib.debug.traceSeq` usage example

```nix
trace { a.b.c = 3; } null
trace: { a = <thunk>; }
=> null
traceSeq { a.b.c = 3; } null
trace: { a = { b = { c = 3; }; }; }
=> null
```

:::

## Documentation for `traceSeqN`

*Function `traceSeqN` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/debug.nix:219:5*

Like `traceSeq`, but only evaluate down to depth n.
This is very useful because lots of `traceSeq` usages
lead to an infinite recursion.

# Inputs

`depth`

: 1\. Function argument

`x`

: 2\. Function argument

`y`

: 3\. Function argument

# Type

```
traceSeqN :: Int -> a -> b -> b
```

# Examples
:::{.example}
## `lib.debug.traceSeqN` usage example

```nix
traceSeqN 2 { a.b.c = 3; } null
trace: { a = { b = {…}; }; }
=> null
```

:::

## Documentation for `traceValSeq`

*Function `traceValSeqFn` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/debug.nix:278:22*

A combination of `traceVal` and `traceSeq` that applies a
provided function to the value to be traced after `deepSeq`ing
it.

# Inputs

`f`

: Function to apply

`v`

: Value to trace

# Type

```
traceValSeqFn :: (a -> b) -> a -> a
```

# Examples
:::{.example}
## `lib.debug.traceValSeqFn` usage example

```nix
traceValSeqFn (v: v // { d = "foo";}) { a.b.c = 3; }
trace: { a = { b = { c = 3; }; }; d = "foo"; }
=> { a = { ... }; }

:::

## Documentation for `traceValSeqFn`

*Function `traceValSeqFn` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/debug.nix:278:19*

A combination of `traceVal` and `traceSeq` that applies a
provided function to the value to be traced after `deepSeq`ing
it.

# Inputs

`f`

: Function to apply

`v`

: Value to trace

# Type

```
traceValSeqFn :: (a -> b) -> a -> a
```

# Examples
:::{.example}
## `lib.debug.traceValSeqFn` usage example

```nix
traceValSeqFn (v: v // { d = "foo";}) { a.b.c = 3; }
trace: { a = { b = { c = 3; }; }; d = "foo"; }
=> { a = { ... }; }

:::

## Documentation for `traceValSeqN`

*Function `traceValSeqNFn` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/debug.nix:346:8*

A combination of `traceVal` and `traceSeqN` that applies a
provided function to the value to be traced.

# Inputs

`f`

: Function to apply

`depth`

: 2\. Function argument

`v`

: Value to trace

# Type

```
traceValSeqNFn :: (a -> b) -> Int -> a -> a
```

# Examples
:::{.example}
## `lib.debug.traceValSeqNFn` usage example

```nix
traceValSeqNFn (v: v // { d = "foo";}) 2 { a.b.c = 3; }
trace: { a = { b = {…}; }; d = "foo"; }
=> { a = { ... }; }
```

:::

## Documentation for `traceValSeqNFn`

*Function `traceValSeqNFn` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/debug.nix:346:5*

A combination of `traceVal` and `traceSeqN` that applies a
provided function to the value to be traced.

# Inputs

`f`

: Function to apply

`depth`

: 2\. Function argument

`v`

: Value to trace

# Type

```
traceValSeqNFn :: (a -> b) -> Int -> a -> a
```

# Examples
:::{.example}
## `lib.debug.traceValSeqNFn` usage example

```nix
traceValSeqNFn (v: v // { d = "foo";}) 2 { a.b.c = 3; }
trace: { a = { b = {…}; }; d = "foo"; }
=> { a = { ... }; }
```

:::

## Documentation for `traceFnSeqN`

*Function `traceFnSeqN` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/debug.nix:426:5*

Trace the input and output of a function `f` named `name`,
both down to `depth`.

This is useful for adding around a function call,
to see the before/after of values as they are transformed.

# Inputs

`depth`

: 1\. Function argument

`name`

: 2\. Function argument

`f`

: 3\. Function argument

`v`

: 4\. Function argument

# Type

```
traceFnSeqN :: Int -> String -> (a -> b) -> a -> b
```

# Examples
:::{.example}
## `lib.debug.traceFnSeqN` usage example

```nix
traceFnSeqN 2 "id" (x: x) { a.b.c = 3; }
trace: { fn = "id"; from = { a.b = {…}; }; to = { a.b = {…}; }; }
=> { a = { ... }; }
```

:::

## Documentation for `runTests`

*Function `runTests` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/debug.nix:513:5*

Evaluates a set of tests.

A test is an attribute set `{expr, expected}`,
denoting an expression and its expected result.

The result is a `list` of __failed tests__, each represented as
`{name, expected, result}`,

- expected
  - What was passed as `expected`
- result
  - The actual `result` of the test

Used for regression testing of the functions in lib; see
tests.nix for more examples.

Important: Only attributes that start with `test` are executed.

- If you want to run only a subset of the tests add the attribute `tests = ["testName"];`

# Inputs

`tests`

: Tests to run

# Type

```
runTests :: {
  tests :: [String];
  ${testName} :: {
    expr :: a;
    expected :: a;
  };
}
->
[
  {
    name :: String;
    expected :: a;
    result :: a;
  }
]
```

# Examples
:::{.example}
## `lib.debug.runTests` usage example

```nix
runTests {
  testAndOk = {
    expr = lib.and true false;
    expected = false;
  };
  testAndFail = {
    expr = lib.and true false;
    expected = true;
  };
}
->
[
  {
    name = "testAndFail";
    expected = true;
    result = false;
  }
]
```

:::

## Documentation for `testAllTrue`

*Function `testAllTrue` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/debug.nix:682:17*

Create a test assuming that list elements are `true`.

# Inputs

`expr`

: 1\. Function argument

# Examples
:::{.example}
## `lib.debug.testAllTrue` usage example

```nix
{ testX = allTrue [ true ]; }
```

:::

## Documentation for `maybeEnv`

*Function `maybeEnv` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/deprecated/misc.nix:30:5*

NO_DOC_CONTENT

## Documentation for `defaultMergeArg`

*Function `defaultMergeArg` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/deprecated/misc.nix:36:21*

NO_DOC_CONTENT

## Documentation for `defaultMerge`

*Function `defaultMerge` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/deprecated/misc.nix:37:18*

NO_DOC_CONTENT

## Documentation for `foldArgs`

*Function `foldArgs` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/deprecated/misc.nix:39:5*

NO_DOC_CONTENT

## Documentation for `maybeAttrNullable`

*Function `maybeAttr` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/deprecated/misc.nix:64:5*

NO_DOC_CONTENT

## Documentation for `maybeAttr`

*Function `maybeAttr` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/deprecated/misc.nix:64:5*

NO_DOC_CONTENT

## Documentation for `ifEnable`

*Function `ifEnable` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/deprecated/misc.nix:70:5*

NO_DOC_CONTENT

## Documentation for `checkFlag`

*Function `checkFlag` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/deprecated/misc.nix:85:5*

NO_DOC_CONTENT

## Documentation for `getValue`

*Function `getValue` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/deprecated/misc.nix:98:5*

NO_DOC_CONTENT

## Documentation for `checkReqs`

*Function `checkReqs` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/deprecated/misc.nix:114:5*

NO_DOC_CONTENT

## Documentation for `uniqList`

*Function `uniqList` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/deprecated/misc.nix:139:5*

NO_DOC_CONTENT

## Documentation for `uniqListExt`

*Function `uniqListExt` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/deprecated/misc.nix:158:5*

NO_DOC_CONTENT

## Documentation for `condConcat`

*Function `condConcat` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/deprecated/misc.nix:179:5*

NO_DOC_CONTENT

## Documentation for `lazyGenericClosure`

*Function `lazyGenericClosure` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/deprecated/misc.nix:188:5*

NO_DOC_CONTENT

## Documentation for `innerModifySumArgs`

*Function `innerModifySumArgs` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/deprecated/misc.nix:207:5*

NO_DOC_CONTENT

## Documentation for `modifySumArgs`

*Function `modifySumArgs` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/deprecated/misc.nix:209:19*

NO_DOC_CONTENT

## Documentation for `innerClosePropagation`

*Function `innerClosePropagation` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/deprecated/misc.nix:212:5*

NO_DOC_CONTENT

## Documentation for `closePropagation`

*Function `closePropagationFast` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/deprecated/misc.nix:243:5*

NO_DOC_CONTENT

## Documentation for `nvs`

*Function `nvs` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/deprecated/misc.nix:273:9*

NO_DOC_CONTENT

## Documentation for `setAttr`

*Function `setAttr` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/deprecated/misc.nix:276:5*

NO_DOC_CONTENT

## Documentation for `setAttrMerge`

*Function `setAttrMerge` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/deprecated/misc.nix:283:5*

NO_DOC_CONTENT

## Documentation for `mergeAttrsWithFunc`

*Function `mergeAttrsWithFunc` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/deprecated/misc.nix:290:5*

NO_DOC_CONTENT

## Documentation for `mergeAttrsConcatenateValues`

*Function `mergeAttrsWithFunc` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/deprecated/misc.nix:290:8*

NO_DOC_CONTENT

## Documentation for `mergeAttrsNoOverride`

*Function `mergeAttrsNoOverride` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/deprecated/misc.nix:307:5*

NO_DOC_CONTENT

## Documentation for `mergeAttrByFunc`

*Function `mergeAttrByFunc` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/deprecated/misc.nix:344:5*

NO_DOC_CONTENT

## Documentation for `mergeAttrsByFuncDefaults`

*Function `foldl` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:196:14*

“left fold”, like `foldr`, but from the left:

`foldl op nul [x_1 x_2 ... x_n] == op (... (op (op nul x_1) x_2) ... x_n)`.

# Inputs

`op`

: 1\. Function argument

`nul`

: 2\. Function argument

`list`

: 3\. Function argument

# Type

```
foldl :: (b -> a -> b) -> b -> [a] -> b
```

# Examples
:::{.example}
## `lib.lists.foldl` usage example

```nix
lconcat = foldl (a: b: a + b) "z"
lconcat [ "a" "b" "c" ]
=> "zabc"
# different types
lstrange = foldl (str: int: str + toString (int + 1)) "a"
lstrange [ 1 2 3 4 ]
=> "a2345"
```

:::

## Documentation for `mergeAttrsByFuncDefaultsClean`

*Function `mergeAttrsByFuncDefaultsClean` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/deprecated/misc.nix:374:35*

NO_DOC_CONTENT

## Documentation for `nixType`

*Function `nixType` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/deprecated/misc.nix:405:5*

NO_DOC_CONTENT

## Documentation for `imap`

*Function `imap1` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/lists.nix:350:11*

Map with index starting from 1

# Inputs

`f`

: 1\. Function argument

`list`

: 2\. Function argument

# Type

```
imap1 :: (Int -> a -> b) -> [a] -> [b]
```

# Examples
:::{.example}
## `lib.lists.imap1` usage example

```nix
imap1 (i: v: "${v}-${toString i}") ["a" "b"]
=> [ "a-1" "b-2" ]
```

:::

## Documentation for `mkEUI64Suffix`

*Function `mkEUI64Suffix` defined at /nix/store/fmasn49f010z71q951x7l7cbyld8p4fl-source/lib/network/default.nix:79:7*

Converts a 48-bit MAC address into a EUI-64 IPv6 address suffix.

# Example

```nix
mkEUI64Suffix "66:75:63:6B:20:75"
=> "6475:63ff:fe6b:2075"
```

# Type

```
mkEUI64Suffix :: String -> String
```

# Inputs

mac
: The MAC address (may contain these delimiters: `:`, `-` or `.` but it's not necessary)


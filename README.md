# `mkflake.nix`

`mkflake.nix` is a lightweight (8 lines) alternative to [`flake-utils`](https://github.com/numtide/flake-utils) and [`flake-parts`](https://github.com/hercules-ci/flake-parts).

There's only one function: `lib.mkflake`, and you use it as follows:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-23.05";
    mkflake.url = "github:jonascarpay/mkflake";
  };

  outputs = { nixpkgs, mkflake, ... }: mkflake.lib.mkflake {
    topLevel = { ... };
    perSystem = system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
        { devShells.default = pkgs.mkShell { ... }; };
    systems = [ "x86_64-linux" ];
  };
}
```

As you'd expect, `topLevel` attributes appear in the flake outputs as-is, and `perSystem` outputs are generated for each system in `systems`.
All arguments are optional, defaulting to `{ }`, `_: { }`, and `{x86_64, aarch64}-{linux, darwin}`, respectively.
The spelling `toplevel` is allowed but deprecated.

You can get the above as a template using
```
nix flake init -t github:jonascarpay/mkflake
```

#### Why not `flake-utils`?

I end up writing this `topLevel`/`perSystem` pattern every time I use `flake-utils`, which is annoying.

#### Why not `flake-parts`?

`flake-parts` has something close to the `topLevel`/`perSystem` pattern, but also includes hundreds of lines of other features that I don't need.

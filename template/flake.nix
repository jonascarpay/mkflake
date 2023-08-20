{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-23.05";
    mkflake.url = "github:jonascarpay/mkflake";
  };

  outputs = { nixpkgs, mkflake, ... }: mkflake.lib.mkflake {
    toplevel = {
      # top-level outputs, such as library functions and
      # overlays go here
    };
    perSystem = system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        # per-system outputs, such as devShells and packages go here
        devShells.default = pkgs.mkShell {
          packages = [ pkgs.hello ];
        };
      };
  };
}

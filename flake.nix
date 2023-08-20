{
  description = "mkflake - lightweight flake helper";
  inputs = { };
  outputs = inputs: {
    lib = rec {
      mkflake = import ./mkflake.nix;
      mkFlake = mkflake;
    };
    templates.default = {
      path = ./template;
      description = "mkflake.nix template";
    };
  };
}

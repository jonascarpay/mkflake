{ perSystem ? _: { }
, toplevel ? { }
, topLevel ? { }
, systems ? [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ]
}:
builtins.zipAttrsWith
  (_: builtins.foldl' (a: b: a // b) { })
  (builtins.map (sys: builtins.mapAttrs (_: value: { ${sys} = value; }) (perSystem sys)) systems)
  // (toplevel // topLevel)

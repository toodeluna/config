{ self, inputs, ... }:
{
  flake.darwinModules.default.imports = [
    (inputs.import-tree "${self}/modules/common")
  ];
}

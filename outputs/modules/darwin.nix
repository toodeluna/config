{ self, inputs, ... }:
{
  flake.darwinModules.default.imports = [
    (inputs.import-tree "${self}/modules/common")
    (inputs.import-tree "${self}/modules/darwin")
  ];
}

{ inputs, self, ... }:
{
  flake.homeModules.default.imports = [
    (inputs.import-tree "${self}/modules/home")
  ];
}

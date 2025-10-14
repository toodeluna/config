{ self, inputs, ... }:
{
  flake.nixosModules.default.imports = [
    (inputs.import-tree "${self}/modules/common")
    (inputs.import-tree "${self}/modules/nixos")
  ];
}

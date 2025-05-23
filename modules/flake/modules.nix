{ self, ... }:
{
  flake.nixosModules.default.imports = [
    "${self}/modules/common"
    "${self}/modules/nixos"
  ];

  flake.darwinModules.default.imports = [
    "${self}/modules/common"
    "${self}/modules/darwin"
  ];

  flake.homeModules.nixos.imports = [
    "${self}/modules/home/common"
    "${self}/modules/home/nixos"
  ];

  flake.homeModules.darwin.imports = [
    "${self}/modules/home/common"
    "${self}/modules/home/darwin"
  ];

  flake.nixvimModules.default.imports = [
    "${self}/modules/nixvim"
  ];
}

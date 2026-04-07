{
  self,
  inputs,
  lib,
  ...
}:
let
  modules = {
    nixos = [
      inputs.catppuccin.nixosModules.default
      inputs.disko.nixosModules.default
      inputs.home-manager.nixosModules.default
      inputs.lix-module.nixosModules.default
      inputs.mangowm.nixosModules.mango
      inputs.tgirlpkgs.nixosModules.default
    ];

    darwin = [
      inputs.lix-module.darwinModules.default
      inputs.home-manager.darwinModules.default
      inputs.tgirlpkgs.darwinModules.default
    ];
  };
in
{
  imports = [ inputs.easy-hosts.flakeModule ];

  easy-hosts = {
    hosts.crona = {
      path = "${self}/nix/hosts/crona";
      class = "nixos";
      arch = "x86_64";
    };

    shared.specialArgs = {
      inherit self inputs;
    };

    perClass = class: {
      specialArgs = { inherit class; };
      modules = lib.getAttr class modules;
    };
  };
}

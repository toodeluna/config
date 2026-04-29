{
  self,
  inputs,
  lib,
  ...
}:
let
  modules = {
    shared = [
      "${self}/nix/modules"
    ];

    nixos = [
      inputs.agenix.nixosModules.default
      inputs.catppuccin.nixosModules.default
      inputs.disko.nixosModules.default
      inputs.home-manager.nixosModules.default
      inputs.lix-module.nixosModules.default
      inputs.tgirlpkgs.nixosModules.default
    ];

    darwin = [
      inputs.agenix.darwinModules.default
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

    shared = {
      specialArgs = { inherit self inputs; };
      modules = modules.shared;
    };

    perClass = class: {
      specialArgs = { inherit class; };
      modules = lib.getAttr class modules;
    };
  };
}

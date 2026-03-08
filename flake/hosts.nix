{
  lib,
  self,
  inputs,
  ...
}:
let
  modules.darwin = [
    inputs.home-manager.darwinModules.default
    inputs.lix-module.darwinModules.default
    inputs.nix-homebrew.darwinModules.default
    inputs.oomf-time.darwinModules.default
  ];

  modules.nixos = [
    inputs.disko.nixosModules.default
    inputs.home-manager.nixosModules.default
    inputs.lix-module.nixosModules.default
  ];
in
{
  imports = [ inputs.easy-hosts.flakeModule ];

  easy-hosts = {
    hosts.blackstar = {
      class = "nixos";
      arch = "x86_64";
      path = "${self}/hosts/blackstar";
    };

    hosts.crona = {
      class = "nixos";
      arch = "x86_64";
      path = "${self}/hosts/crona";
    };

    hosts.excalibur = {
      class = "darwin";
      arch = "aarch64";
      path = "${self}/hosts/excalibur";
    };

    shared = {
      specialArgs = { inherit self inputs; };
    };

    perClass = class: {
      modules = lib.getAttr class modules;
    };
  };
}

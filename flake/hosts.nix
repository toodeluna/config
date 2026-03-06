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
    inputs.home-manager.nixosModules.default
    inputs.lix-module.nixosModules.default
  ];
in
{
  imports = [ inputs.easy-hosts.flakeModule ];

  easy-hosts = {
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

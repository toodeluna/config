{
  lib,
  self,
  inputs,
  ...
}:
let
  modules.darwin = [
    "${self}/modules/common"
    "${self}/modules/darwin"
    inputs.agenix.darwinModules.default
    inputs.home-manager.darwinModules.default
    inputs.lix-module.darwinModules.default
    inputs.nix-homebrew.darwinModules.default
    inputs.oomf-time.darwinModules.default
  ];

  modules.nixos = [
    "${self}/modules/common"
    "${self}/modules/nixos"
    inputs.agenix.nixosModules.default
    inputs.disko.nixosModules.default
    inputs.home-manager.nixosModules.default
    inputs.lix-module.nixosModules.default
  ];

  modules.iso = [
    "${self}/modules/common"
    "${self}/modules/nixos"
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

    hosts.soul = {
      class = "iso";
      arch = "x86_64";
      path = "${self}/hosts/soul";
    };

    hosts.tsubaki = {
      class = "nixos";
      arch = "x86_64";
      path = "${self}/hosts/tsubaki";
    };

    shared.specialArgs = {
      inherit self inputs;
      keys = import "${self}/secrets/keys.nix";
    };

    perClass = class: {
      modules = lib.getAttr class modules;
    };
  };

  flake.packages.x86_64-linux = {
    iso = self.nixosConfigurations.soul.config.system.build.isoImage;
  };
}

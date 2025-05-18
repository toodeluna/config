{
  self,
  inputs,
  constants,
  ...
}:
let
  perClassModules = {
    iso = [ ];

    nixos = [
      inputs.agenix.nixosModules.default
      inputs.catppuccin.nixosModules.default
      inputs.disko.nixosModules.default
      inputs.home-manager.nixosModules.default
      self.nixosModules.default
    ];

    darwin = [
      inputs.agenix.darwinModules.default
      inputs.home-manager.darwinModules.default
      inputs.homebrew.darwinModules.nix-homebrew
      self.darwinModules.default
    ];
  };

  mkHost = name: class: arch: {
    inherit class arch;
    path = "${self}/configurations/${name}";
  };
in
{
  imports = [ inputs.easy-hosts.flakeModule ];

  easyHosts = {
    hosts.crona = mkHost "crona" "nixos" "x86_64";
    hosts.excalibur = mkHost "excalibur" "darwin" "aarch64";

    shared.specialArgs = {
      inherit constants;
    };

    shared.modules = [
      inputs.lix.nixosModules.default
      "${self}/modules/common"
    ];

    perClass = class: {
      modules = perClassModules.${class};
    };
  };
}

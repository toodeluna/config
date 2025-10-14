{ self, inputs, ... }:
let
  modules.shared = [
    inputs.lix.nixosModules.default
  ];

  modules.darwin = [
    inputs.agenix.darwinModules.default
    inputs.homebrew.darwinModules.nix-homebrew
    inputs.home-manager.darwinModules.default
    self.darwinModules.default
  ];

  modules.nixos = [
    inputs.agenix.nixosModules.default
    inputs.disko.nixosModules.default
    inputs.home-manager.nixosModules.default
    self.nixosModules.default
  ];

  mkHost = name: arch: class: {
    inherit arch class;
    modules = [ (inputs.import-tree "${self}/hosts/${name}") ];
  };
in
{
  easy-hosts = {
    hosts.crona = mkHost "crona" "x86_64" "nixos";
    hosts.excalibur = mkHost "excalibur" "aarch64" "darwin";

    shared.modules = modules.shared;
    perClass = class: { modules = modules.${class} or [ ]; };
  };
}

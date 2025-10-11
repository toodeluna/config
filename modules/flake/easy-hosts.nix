{
  config,
  inputs,
  self,
  ...
}:
let
  mkHost = name: arch: class: {
    inherit arch class;
    modules = [ "${self}/hosts/${name}" ];
  };

  perClassModules.darwin = [
    config.flake.modules.darwin.base
    inputs.agenix.darwinModules.default
  ];

  perClassModules.nixos = [
    config.flake.modules.nixos.base
    inputs.agenix.nixosModules.default
  ];
in
{
  easy-hosts = {
    shared.modules = [ config.flake.modules.generic.base ];
    perClass = class: { modules = perClassModules.${class}; };

    hosts.excalibur = mkHost "excalibur" "aarch64" "darwin";
    hosts.crona = mkHost "crona" "x86_64" "nixos";
  };
}

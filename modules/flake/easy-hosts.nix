{ config, self, ... }:
let
  mkHost = name: arch: class: {
    inherit arch class;
    modules = [ "${self}/hosts/${name}" ];
  };
in
{
  easy-hosts = {
    shared.modules = [ config.flake.modules.generic.base ];
    perClass = class: { modules = [ config.flake.modules.${class}.base ]; };

    hosts.excalibur = mkHost "excalibur" "aarch64" "darwin";
    hosts.crona = mkHost "crona" "x86_64" "nixos";
  };
}

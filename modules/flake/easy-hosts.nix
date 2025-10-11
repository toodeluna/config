{ self, ... }:
let
  mkHost = name: arch: class: {
    inherit arch class;
    modules = [ "${self}/hosts/${name}" ];
  };
in
{
  easy-hosts = {
    hosts.excalibur = mkHost "excalibur" "aarch64" "darwin";
    hosts.crona = mkHost "crona" "x86_64" "nixos";
  };
}

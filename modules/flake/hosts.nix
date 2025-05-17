{ self, inputs, ... }:
let
  mkHost = name: class: arch: {
    inherit class arch;
    path = "${self}/configurations/${name}";
  };
in
{
  imports = [ inputs.easy-hosts.flakeModule ];

  easyHosts = {
    hosts.crona = mkHost "crona" "nixos" "x86_64";
  };
}

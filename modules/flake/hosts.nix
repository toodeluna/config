{ self, inputs, ... }:
let
  perClassModules = {
    nixos = [ inputs.disko.nixosModules.default ];
    darwin = [ ];
    iso = [ ];
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

    perClass = class: { modules = perClassModules.${class}; };
  };
}

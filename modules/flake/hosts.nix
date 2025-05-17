{ self, inputs, ... }:
let
  perClassModules = {
    iso = [ ];

    nixos = [
      inputs.disko.nixosModules.default
      "${self}/modules/common"
      "${self}/modules/nixos"
    ];

    darwin = [
      "${self}/modules/common"
      "${self}/modules/darwin"
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

    perClass = class: { modules = perClassModules.${class}; };
  };
}

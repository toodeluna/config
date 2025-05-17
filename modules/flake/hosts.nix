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
      inputs.disko.nixosModules.default
      inputs.catppuccin.nixosModules.default
      "${self}/modules/nixos"
    ];

    darwin = [
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

    shared.modules = [ "${self}/modules/common" ];
    shared.specialArgs = { inherit constants; };
    perClass = class: { modules = perClassModules.${class}; };
  };
}

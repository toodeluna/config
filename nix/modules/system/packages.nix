{ config, lib, ... }:
let
  packagesToInstall = lib.filterAttrs (name: package: package != null) config.soul.system.packages;
in
{
  options.soul.system.packages = lib.mkOption {
    description = "Extra packages to install.";
    type = lib.types.attrsOf lib.types.package;
    default = { };
  };

  config.environment = {
    defaultPackages = [ ];
    systemPackages = builtins.attrValues packagesToInstall;
  };
}

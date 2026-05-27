{ config, lib, ... }:
let
  cfg = config.soul.system.domain;
in
{
  options.soul.system.domain = lib.mkOption {
    description = "The domain name of this host.";
    example = "shibusen.org";
    type = lib.types.str;
  };

  config = {
    lib.soul = {
      mkSubdomain = subdomain: "${subdomain}.${config.networking.domain}";
    };

    soul.system = {
      domain = lib.mkDefault "${config.networking.hostName}.local";
    };

    networking = {
      domain = cfg;
      fqdn = cfg;
    };
  };
}

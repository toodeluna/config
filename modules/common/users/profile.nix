{ lib, config, ... }:
let
  inherit (config.soul) profile;
in
{
  options.soul.profile = {
    username = lib.mkOption {
      description = "The username of the main user.";
      type = lib.types.strMatching "([a-z0-9]+)";
      default = "luna";
    };

    name = lib.mkOption {
      description = "The full name of the main user.";
      type = lib.types.str;
      default = "Luna Heyman";
    };
  };

  config.users.users.profile = {
    name = profile.username;
    description = profile.name;
  };
}

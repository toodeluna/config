{
  pkgs,
  lib,
  config,
  ...
}:
let
  homeRoot = if pkgs.stdenv.hostPlatform.isLinux then "home" else "Users";
in
{
  options.custom.profile = {
    username = lib.mkOption {
      type = lib.types.strMatching "([a-z0-9]+)";
      description = "The username for the main user.";
      default = "luna";
    };

    name = lib.mkOption {
      type = lib.types.str;
      description = "The full name of the main user.";
      default = "Luna Heyman";
    };

    email = lib.mkOption {
      type = lib.types.str;
      description = "The email address of the main user.";
      default = "luna.heyman@proton.me";
    };

    home = lib.mkOption {
      readOnly = true;
      type = lib.types.str;
      description = "The home directory of the main user. Automatically determined for the system.";
      default = "/${homeRoot}/${config.custom.profile.username}";
    };
  };

  config.users.users.profile = {
    name = config.custom.profile.username;
    description = config.custom.profile.name;
    home = config.custom.profile.home;
  };
}

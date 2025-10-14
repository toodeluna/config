{
  pkgs,
  self,
  lib,
  config,
  ...
}:
let
  inherit (config.soul) profile;

  home = self.lib.conditional pkgs {
    linux = "home";
    darwin = "Users";
  };
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

    email = lib.mkOption {
      description = "The email address of the main user.";
      type = lib.types.str;
      default = "luna.heyman@proton.me";
    };
  };

  config = {
    users.users.profile = {
      name = profile.username;
      description = profile.name;
      home = "/${home}/${profile.username}";
    };

    home-manager = {
      users.profile = self.homeModules.default;
    };
  };
}

{ lib, ... }:
{
  flake.modules.generic.base =
    { config, ... }:
    {
      options.soul.profile = {
        username = lib.mkOption {
          type = lib.types.strMatching "([a-z0-9]+)";
          description = "The username of the main user.";
          default = "luna";
        };

        name = lib.mkOption {
          type = lib.types.str;
          description = "The full name of the main user.";
          default = "Luna Heyman";
        };
      };

      config.users.users.profile = {
        name = config.soul.profile.username;
        description = config.soul.profile.name;
      };
    };

  flake.modules.darwin.base =
    { config, ... }:
    {
      system.primaryUser = config.soul.profile.username;

      users = {
        knownUsers = [ config.soul.profile.username ];

        users.profile = {
          uid = 501;
          createHome = true;
        };
      };
    };

  flake.modules.nixos.base.users.users.profile = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
}

{ config, lib, ... }:
{
  users = lib.mkIf config.soul.secrets.enable {
    mutableUsers = false;

    users = {
      root.hashedPasswordFile = config.age.secrets.password.path;
      profile.hashedPasswordFile = config.age.secrets.password.path;
    };
  };
}

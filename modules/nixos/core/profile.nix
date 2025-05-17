{ config, ... }:
{
  users.mutableUsers = false;
  users.groups.profile.name = config.custom.profile.username;

  users.users.profile = {
    isNormalUser = true;
    group = config.custom.profile.username;
    hashedPasswordFile = config.age.secrets.password.path;
    extraGroups = [ "wheel" ];
  };

  users.users.root = {
    hashedPasswordFile = config.age.secrets.password.path;
  };
}

{ config, ... }:
{
  users.groups.profile = {
    name = config.custom.profile.username;
  };

  users.users.profile = {
    isNormalUser = true;
    group = config.custom.profile.username;
    extraGroups = [ "wheel" ];
  };
}

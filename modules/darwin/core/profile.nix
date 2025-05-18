{ config, ... }:
{
  system.primaryUser = config.custom.profile.username;
  users.knownUsers = [ config.custom.profile.username ];
}

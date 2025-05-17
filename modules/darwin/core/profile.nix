{ config, ... }:
{
  users.knownUsers = [ config.custom.profile.username ];
}

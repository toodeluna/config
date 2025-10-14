{ config, ... }:
let
  inherit (config.soul) profile;
in
{
  system.primaryUser = profile.username;
  users.knownUsers = [ profile.username ];

  users.users.profile = {
    uid = 501;
    createHome = true;
  };
}

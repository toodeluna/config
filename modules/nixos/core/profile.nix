{ lib, config, ... }:
let
  inherit (config.soul) profile;
in
{
  options.soul.profile.makeUser = lib.mkOption {
    description = "Whether to create a user account for this profile.";
    type = lib.types.bool;
    default = true;
  };

  config.users.users.profile = {
    enable = profile.makeUser;
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };
}

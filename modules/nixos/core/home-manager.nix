{ self, ... }:
{
  home-manager.users.profile.imports = [ "${self}/modules/home/nixos" ];
}

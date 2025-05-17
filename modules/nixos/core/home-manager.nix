{ self, ... }:
{
  home-manager.users.profile.imports = [ "${self}/modules/nixos/home" ];
}

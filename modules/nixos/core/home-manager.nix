{ self, ... }:
{
  home-manager.users.profile.imports = [ self.homeModules.nixos ];
}

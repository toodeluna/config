{ self, ... }:
{
  home-manager.users.profile.imports = [ self.homeModules.darwin ];
}

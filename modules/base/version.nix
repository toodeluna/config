{ self, ... }:
{
  flake.modules.generic.base = {
    system.configurationRevision = self.rev or self.dirtRev or null;
  };

  flake.modules.darwin.base = {
    system.stateVersion = 6;
  };

  flake.modules.nixos.base = {
    system.stateVersion = "25.05";
  };
}

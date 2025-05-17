{ pkgs, self, ... }:
{
  system = {
    stateVersion = if pkgs.stdenv.hostPlatform.isLinux then "25.05" else 6;
    configurationRevision = self.rev or self.dirtRev or null;
  };
}

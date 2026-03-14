{ class, ... }:
{
  fonts.enableDefaultPackages = false;
  system.disableInstallerTools = config.soul.system.type != "iso";
}

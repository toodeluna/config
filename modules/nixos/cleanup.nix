{ class, ... }:
{
  fonts.enableDefaultPackages = false;
  system.disableInstallerTools = class != "iso";
}

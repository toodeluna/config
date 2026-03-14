{ self, lib, ... }:
{
  console.useXkbConfig = true;
  networking.useNetworkd = true;

  programs.git.enable = true;
  programs.neovim.enable = true;

  environment.defaultPackages = [ ];
  fonts.enableDefaultPackages = false;

  image = {
    baseName = lib.mkImageMediaOverride "soul";
    extension = "iso";
  };

  services.xserver.xkb = {
    layout = "us";
    options = "caps:escape";
  };
}

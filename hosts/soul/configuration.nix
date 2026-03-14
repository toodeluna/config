{ self, lib, ... }:
{
  soul.system = {
    type = "iso";
  };

  console.useXkbConfig = true;
  networking.useNetworkd = true;

  programs.git.enable = true;
  programs.neovim.enable = true;

  image = {
    baseName = lib.mkImageMediaOverride "soul";
    extension = "iso";
  };

  services.xserver.xkb = {
    layout = "us";
    options = "caps:escape";
  };
}

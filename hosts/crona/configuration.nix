{ self, pkgs, ... }:
{
  soul.hardware = {
    amdgpu.enable = true;
    audio.enable = true;
    graphics.enable = true;
  };

  soul.theme = {
    wallpaper = "${self}/assets/wallpapers/catppuccin-blossoms.png";
  };

  programs = {
    lazygit.enable = true;
    neovim.enable = true;
  };

  environment = {
    systemPackages = [
      pkgs.discord
      pkgs.ghostty
      pkgs.rofi
    ];
  };
}

{ self, pkgs, ... }:
{
  soul.hardware = {
    amdgpu.enable = true;
    audio.enable = true;
    graphics.enable = true;
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

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
    nh.enable = true;
    zsh.enable = true;
  };

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  environment = {
    variables = {
      NIXOS_OZONE_WL = "1";
    };

    systemPackages = [
      pkgs.discord
      pkgs.ghostty
      pkgs.rofi
    ];
  };

  fonts.packages = [
    pkgs.nerd-fonts.fira-code
    pkgs.noto-fonts
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-cjk-serif
    pkgs.noto-fonts-color-emoji
    pkgs.work-sans
  ];
}

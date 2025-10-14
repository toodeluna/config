{ self, pkgs, ... }:
{
  time.timeZone = "Europe/Brussels";
  i18n.defaultLocale = "en_US.UTF-8";
  console.useXkbConfig = true;

  soul.hardware = {
    graphics.enable = true;
    amdgpu.enable = true;
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  services = {
    pipewire.enable = true;
    openssh.enable = true;
  };

  services.xserver = {
    xkb = {
      layout = "us";
      options = "caps:escape";
    };
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

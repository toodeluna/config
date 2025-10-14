{ self, pkgs, ... }:
{
  time.timeZone = "Europe/Brussels";
  i18n.defaultLocale = "en_US.UTF-8";
  console.useXkbConfig = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  boot = {
    initrd = {
      kernelModules = [ "amdgpu" ];
    };

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  users.users.profile = {
    shell = pkgs.zsh;
  };

  services = {
    pipewire.enable = true;
    openssh.enable = true;
  };

  services.xserver = {
    videoDrivers = [
      "amdgpu"
    ];

    xkb = {
      layout = "us";
      options = "caps:escape";
    };
  };

  programs = {
    git.enable = true;
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

    shells = [
      pkgs.bashInteractive
      pkgs.zsh
    ];

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

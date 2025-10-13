{ self, pkgs, ... }:
{
  time.timeZone = "Europe/Brussels";
  i18n.defaultLocale = "en_US.UTF-8";
  console.useXkbConfig = true;

  system = {
    stateVersion = "25.05";
    configurationRevision = self.rev or self.dirtRev or null;
  };

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

  nixpkgs.config = {
    allowAliases = false;
    allowUnfree = true;
  };

  nix = {
    channel.enable = false;
    optimise.automatic = true;

    settings = {
      keep-going = true;
      warn-dirty = false;
      use-xdg-base-directories = true;

      trusted-users = [ "@wheel" ];
      allowed-users = [ "@wheel" ];

      experimental-features = [
        "flakes"
        "nix-command"
      ];
    };
  };

  users.users.luna = {
    isNormalUser = true;
    description = "Luna Heyman";
    extraGroups = [ "wheel" ];
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

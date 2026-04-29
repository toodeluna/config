{
  config,
  inputs,
  pkgs,
  self,
  ...
}:
{
  soul.hardware = {
    amdgpu.enable = true;
    audio.enable = true;
    bluetooth.enable = true;
    intelcpu.enable = true;
  };

  soul.system.packages = {
    inherit (pkgs) spotify qbittorrent;
  };

  programs.dconf.enable = true;
  programs.gamemode.enable = true;

  fonts.enableDefaultPackages = false;

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "blue";
    plymouth.enable = false;
  };

  catppuccin.sources = {
    palette = inputs.catppuccin-palette;
  };

  boot = {
    consoleLogLevel = 3;
    initrd.verbose = false;

    kernelParams = [
      "quiet"
      "udev.log_level=3"
      "systemd.show_status=auto"
    ];
  };

  boot.loader = {
    timeout = 0;
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  boot.plymouth = {
    enable = true;
    theme = "plymouth-gif-theme";
    themePackages = [ pkgs.custom.plymouth-gif-theme ];
  };

  age.secrets = {
    password.file = "${self}/nix/secrets/crona/password.age";
  };

  users.users.luna = {
    isNormalUser = true;
    description = "Luna Heyman";
    hashedPasswordFile = config.age.secrets.password.path;

    extraGroups = [
      "wheel"
      "video"
      "audio"
      "gamemode"
    ];
  };

  home-manager.users = {
    luna = ./home.nix;
  };

  programs.ssh.knownHosts = {
    github = {
      hostNames = [ "github.com" ];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
    };
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = false;
  };

  programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  environment.variables = {
    NIXOS_OZONE_WL = "1";
  };

  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.noto-fonts
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-cjk-serif
    pkgs.noto-fonts-color-emoji
    pkgs.work-sans
  ];

  fonts.fontconfig = {
    enable = true;

    defaultFonts = {
      monospace = [ "JetBrainsMono Nerd Font" ];
      emoji = [ "Noto Color Emoji" ];

      serif = [
        "Noto Serif"
        "Noto Cjk Serif"
      ];

      sansSerif = [
        "Work Sans"
        "Noto Cjk Sans"
      ];
    };
  };
}

{
  config,
  inputs,
  lib,
  pkgs,
  self,
  ...
}:
{
  soul.hardware = {
    amdgpu.enable = true;
    bluetooth.enable = true;
    intelcpu.enable = true;
  };

  soul.system.packages = {
    inherit (pkgs) discord spotify qbittorrent;
  };

  programs.dconf.enable = true;
  programs.gamemode.enable = true;

  fonts.enableDefaultPackages = false;

  services.udisks2.enable = true;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "home-manager-backup";

    extraSpecialArgs = {
      inherit self inputs;
    };

    sharedModules = [
      inputs.catppuccin.homeModules.default
      inputs.nixvim.homeModules.default
      inputs.tgirlpkgs.homeModules.default
      inputs.zen-browser.homeModules.default
    ];
  };

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

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    jack.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;

    extraConfig.pipewire."10-quantum" = {
      "context.properties"."default.clock.min-quantum" = 1024;
    };

    extraConfig.pipewire."99-rnnoise"."context.modules" = lib.singleton {
      name = "libpipewire-module-filter-chain";

      args = {
        "node.description" = "Noise cancelling source";
        "media.name" = "Noise cancelling source";

        "filter.graph".nodes = lib.singleton {
          type = "ladspa";
          name = "rnnoise";
          label = "noise_suppressor_mono";
          plugin = "${pkgs.rnnoise-plugin}/lib/ladspa/librnnoise_ladspa.so";

          control = {
            "VAD Threshold (%)" = 95;
            "VAD Grace Period (ms)" = 200;
            "Retroactive VAD Grace (ms)" = 0;
          };
        };

        "capture.props" = {
          "node.name" = "capture.rnnoise_source";
          "audio.rate" = 48000;
        };

        "playback.props" = {
          "node.name" = "rnnoise_source";
          "media.class" = "Audio/Source";
          "audio.rate" = 48000;
        };
      };
    };
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

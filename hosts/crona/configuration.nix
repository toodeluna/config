{
  self,
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
let
  inherit (config.services.displayManager.sessionData) desktops;
in
{
  soul.system = {
    type = "desktop";
  };

  console.useXkbConfig = true;
  networking.useNetworkd = true;

  programs.gamemode.enable = true;
  programs.neovim.enable = true;
  programs.niri.enable = true;
  programs.fish.enable = true;
  programs.git.enable = true;

  services.resolved.enable = true;

  security.rtkit.enable = true;

  users.mutableUsers = false;

  environment.defaultPackages = [ ];
  fonts.enableDefaultPackages = false;

  home-manager = {
    users.luna = ./home.nix;
  };

  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
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

    alsa = {
      enable = true;
      support32Bit = true;
    };

    extraConfig.pipewire = {
      "10-quantum" = {
        "context.properties"."default.clock.min-quantum" = 1024;
      };

      "99-rnnoise" = {
        "context.modules" = lib.singleton {
          name = "libpipewire-module-filter-chain";

          args = {
            "node.description" = "Noise cancelling source";
            "media.name" = "Noise cancelling source";

            "filter.graph" = {
              nodes = lib.singleton {
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
    };
  };

  services.xserver.xkb = {
    layout = "us";
    options = "caps:escape";
  };

  services.greetd = {
    enable = true;

    settings.default_session = {
      users = "greeter";
      command = ''${lib.getExe pkgs.tuigreet} --asterisks --sessions "${desktops}/share/wayland-sessions"'';
    };
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    ipv4 = true;
    ipv6 = true;
    openFirewall = true;

    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };

  age.secrets = {
    password.file = "${self}/secrets/crona/password.age";
  };

  users.users.luna = {
    isNormalUser = true;
    description = "Luna Heyman";
    hashedPasswordFile = config.age.secrets.password.path;

    extraGroups = [
      "audio"
      "gamemode"
      "video"
      "wheel"
    ];
  };

  users.users.root = {
    hashedPasswordFile = config.age.secrets.password.path;
  };

  fonts.fontconfig.defaultFonts = {
    emoji = [ "Noto Color Emoji" ];
    monospace = [ "JetBrainsMono Nerd Font" ];

    serif = [
      "Noto Serif"
      "Noto Cjk Serif"
    ];

    sansSerif = [
      "Work Sans"
      "Noto Cjk Sans"
    ];
  };

  environment.variables = {
    NIXOS_OZONE_WL = "1";
  };

  environment.systemPackages = [
    pkgs.crosspatch
    pkgs.discord
    pkgs.gimp
    pkgs.pcsx2
    pkgs.qbittorrent
    pkgs.signal-desktop
    pkgs.spotify
    pkgs.syncplay
    pkgs.wiremix
    pkgs.xwayland-satellite
  ];

  fonts.packages = [
    pkgs.material-icons
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.noto-fonts
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-cjk-serif
    pkgs.noto-fonts-color-emoji
    pkgs.work-sans
  ];
}

{
  inputs,
  pkgs,
  self,
  keys,
  ...
}:
{
  soul.hardware = {
    amdgpu.enable = true;
    audio.enable = true;
    bluetooth.enable = true;
    intelcpu.enable = true;
  };

  soul.system.boot = {
    quiet = true;
    splash = true;
  };

  soul.system.root = {
    password = "${self}/nix/secrets/crona/password.age";
  };

  soul.system.users.luna = {
    email = "luna@toodeluna.net";
    firstName = "Luna";
    lastName = "Heyman";
    password = "${self}/nix/secrets/crona/password.age";
  };

  soul.system.home = {
    imports = [ ./home.nix ];
  };

  soul.system.packages = {
    inherit (pkgs) spotify qbittorrent signal-desktop;
    inherit (pkgs.kdePackages) kdenlive;
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

  programs.ssh.knownHosts = {
    github = {
      hostNames = [ "github.com" ];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
    };

    blackstar = {
      hostNames = [ "toodeluna.net" ];
      publicKey = keys.blackstar.root;
    };

    crona = {
      hostNames = [ "crona.local" ];
      publicKey = keys.crona.root;
    };

    tsubaki = {
      hostNames = [ "tsubaki.local" ];
      publicKey = keys.tsubaki.root;
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
    pkgs.maple-mono.NF
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

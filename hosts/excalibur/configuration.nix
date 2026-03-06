{
  config,
  inputs,
  lib,
  pkgs,
  self,
  ...
}:
{
  time.timeZone = "Europe/Brussels";

  programs.oomf-time.enable = true;
  services.openssh.enable = true;

  security.sudo.extraConfig = "Defaults env_reset,pwfeedback";
  security.pam.services.sudo_local.touchIdAuth = true;

  system = {
    stateVersion = 6;
    configurationRevision = self.rev or self.dirtRev or null;
    primaryUser = "luna";
  };

  system.startup = {
    chime = false;
  };

  system.tools = {
    darwin-option.enable = false;
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };

  system.defaults.magicmouse = {
    MouseButtonMode = "TwoButton";
  };

  system.defaults.trackpad = {
    Clicking = true;
    TrackpadRightClick = true;
  };

  system.defaults.dock = {
    orientation = "left";
    tilesize = 32;
    autohide = true;
    mru-spaces = false;
    show-recents = false;
    static-only = true;
  };

  system.defaults.finder = {
    AppleShowAllExtensions = true;
    AppleShowAllFiles = true;
    QuitMenuItem = false;
  };

  system.defaults.NSGlobalDomain = {
    AppleInterfaceStyle = "Dark";
    AppleMeasurementUnits = "Centimeters";
    AppleTemperatureUnit = "Celsius";
  };

  nix = {
    channel.enable = false;
    optimise.automatic = true;
    gc.automatic = true;

    settings = {
      keep-going = true;
      keep-outputs = true;
      keep-derivations = true;

      warn-dirty = false;
      use-xdg-base-directories = true;

      allowed-users = [ "@admin" ];
      trusted-users = [ "@admin" ];

      experimental-features = [
        "flakes"
        "lix-custom-sub-commands"
        "nix-command"
        "pipe-operator"
      ];
    };
  };

  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    mutableTaps = false;
    autoMigrate = true;
    user = config.system.primaryUser;

    taps = {
      "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
      "homebrew/homebrew-core" = inputs.homebrew-core;
    };
  };

  homebrew = {
    enable = true;
    taps = builtins.attrNames config.nix-homebrew.taps;

    onActivation = {
      cleanup = "zap";
      upgrade = true;
      autoUpdate = true;
    };
  };

  nixpkgs.config = {
    allowAliases = false;
    allowUnfree = true;
  };

  nixpkgs.overlays = [
    inputs.firefox-addons.overlays.default
  ];

  users = {
    knownUsers = [ "luna" ];

    users.luna = {
      uid = 501;
      createHome = true;
      home = "/Users/luna";
      description = "Luna Heyman";
      shell = pkgs.bashInteractive;
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "home-manager-backup";
    sharedModules = [ inputs.zen-browser.homeModules.default ];
    users.luna = ./home.nix;
  };

  programs.bash.interactiveShellInit = ''
    if [[ $- == *i* ]]; then
      exec "${lib.getExe pkgs.nushell}"
    fi
  '';

  environment.systemPackages = [
    pkgs.discord
    pkgs.lix-diff
    pkgs.spotify
    pkgs.vscode
  ];

  environment.shells = [
    pkgs.nushell
  ];

  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
  ];

  homebrew.casks = [
    "citrix-workspace"
    "ghostty"
    "microsoft-outlook"
    "microsoft-teams"
    "sol"
  ];
}

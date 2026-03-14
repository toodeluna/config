{
  config,
  inputs,
  lib,
  pkgs,
  self,
  ...
}:
{
  system = {
    primaryUser = "luna";
  };

  soul.system = {
    type = "laptop";
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
    users.luna = ./home.nix;
  };

  environment.systemPackages = [
    pkgs.discord
    pkgs.spotify
    pkgs.vscode
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

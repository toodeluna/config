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

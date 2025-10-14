{
  pkgs,
  self,
  inputs,
  config,
  lib,
  ...
}:
{
  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    mutableTaps = false;
    user = "luna";

    taps = {
      "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
      "homebrew/homebrew-core" = inputs.homebrew-core;
    };
  };

  homebrew = {
    enable = true;
    taps = lib.attrNames config.nix-homebrew.taps;

    onActivation = {
      upgrade = true;
      autoUpdate = true;
      cleanup = "zap";
    };

    casks = [
      "google-chrome"
      "microsoft-outlook"
      "microsoft-teams"
      "spotify"
      "zen"
    ];
  };

  users = {
    users.profile = {
      shell = pkgs.zsh;
    };
  };

  environment = {
    shells = [
      pkgs.bashInteractive
      pkgs.zsh
    ];

    systemPackages = [
      pkgs.ghostty-bin
      pkgs.git
      pkgs.lazygit
      pkgs.neovim
      pkgs.nh
      pkgs.raycast
      pkgs.vscode
    ];
  };

  programs = {
    zsh.enable = true;
  };

  fonts.packages = [
    pkgs.nerd-fonts.fira-code
    pkgs.work-sans
  ];
}

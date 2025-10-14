{
  config,
  inputs,
  lib,
  ...
}:
let
  inherit (config.soul) profile;
in
{
  options.soul = {
    casks = lib.mkOption {
      description = "Extra homebrew casks to install.";
      type = lib.types.listOf lib.types.str;
      default = [ ];
      apply = lib.unique;
    };

    brews = lib.mkOption {
      description = "Extra homebrew formulae to install.";
      type = lib.types.listOf lib.types.str;
      default = [ ];
      apply = lib.unique;
    };
  };

  config = {
    nix-homebrew = {
      enable = true;
      enableRosetta = true;
      mutableTaps = false;
      user = profile.username;

      taps = {
        "homebrew/homebrew-bundle" = inputs.homebrew-bundle;
        "homebrew/homebrew-cask" = inputs.homebrew-cask;
        "homebrew/homebrew-core" = inputs.homebrew-core;
      };
    };

    homebrew = {
      inherit (config.soul) brews casks;

      enable = true;
      taps = lib.attrNames config.nix-homebrew.taps;

      onActivation = {
        upgrade = true;
        autoUpdate = true;
        cleanup = "zap";
      };
    };
  };
}

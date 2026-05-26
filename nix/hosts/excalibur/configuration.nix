{
  config,
  inputs,
  pkgs,
  ...
}:
{
  programs.oomf-time.enable = true;
  security.pam.services.sudo_local.touchIdAuth = true;

  soul.system.users.luna = {
    primary = true;
    firstName = "Luna";
    lastName = "Heyman";
    email = "luna@toodeluna.net";
  };

  soul.system.home = {
    imports = [ ./home.nix ];
  };

  soul.system.packages = {
    inherit (pkgs)
      spotify
      signal-desktop
      vscode
      quoteit
      ;
  };

  nix-homebrew = {
    enable = true;
    enableRosetta = true;
    autoMigrate = true;
    mutableTaps = false;
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

    casks = [
      "citrix-workspace"
      "microsoft-outlook"
      "microsoft-teams"
      "sol"
    ];
  };

  fonts.packages = [
    pkgs.work-sans
    pkgs.nerd-fonts.jetbrains-mono
  ];

  programs.ssh.knownHosts = {
    github = {
      hostNames = [ "github.com" ];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
    };
  };
}

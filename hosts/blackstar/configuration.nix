{ self, ... }:
let
  keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEGqjgwVNyOXW0dl9GNgu5/y9KuDF+NCKnmcSUYQPFbO luna@crona"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM4Dhobhj1+/qQAHUsnVsVemPWUyKdvs2lgX3/zy+fG+ root@crona"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIxCvGO9OqARsPJl/bKRumMHC/zFgRyFLEVQrru/z7qr luna@excalibur"
  ];
in
{
  time.timeZone = "Europe/Brussels";
  i18n.defaultLocale = "en_US.UTF-8";

  console.useXkbConfig = true;
  networking.useNetworkd = true;

  programs.git.enable = true;
  programs.neovim.enable = true;

  services.openssh.enable = true;

  security.sudo.extraConfig = "Defaults env_reset,pwfeedback";

  environment.defaultPackages = [ ];
  fonts.enableDefaultPackages = false;

  system = {
    stateVersion = "26.06";
    configurationRevision = self.rev or self.dirtRev or null;
  };

  nix = {
    channel.enable = false;
    optimise.automatic = true;

    settings = {
      keep-going = true;
      keep-outputs = true;
      keep-derivations = true;

      warn-dirty = false;
      use-xdg-base-directories = true;

      allowed-users = [ "@wheel" ];
      trusted-users = [ "@wheel" ];

      experimental-features = [
        "flakes"
        "lix-custom-sub-commands"
        "nix-command"
        "pipe-operator"
      ];
    };
  };

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  nixpkgs.config = {
    allowAliases = false;
    allowUnfree = true;
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
  };

  services.xserver.xkb = {
    layout = "us";
    options = "caps:escape";
  };

  users.users.luna = {
    isNormalUser = true;
    description = "Luna Heyman";
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys = { inherit keys; };
  };

  users.users.root = {
    openssh.authorizedKeys = { inherit keys; };
  };
}

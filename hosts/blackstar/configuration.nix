{ config, self, keys, ... }:
{
  time.timeZone = "Europe/Brussels";
  i18n.defaultLocale = "en_US.UTF-8";

  console.useXkbConfig = true;
  networking.useNetworkd = true;

  programs.git.enable = true;
  programs.neovim.enable = true;

  services.openssh.enable = true;

  security.sudo.extraConfig = "Defaults env_reset,pwfeedback";

  users.mutableUsers = false;

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

  age.secrets = {
    password.file = "${self}/secrets/blackstar/password.age";
  };

  users.users.luna = {
    isNormalUser = true;
    description = "Luna Heyman";
    extraGroups = [ "wheel" ];
    hashedPasswordFile = config.age.secrets.password.path;

    openssh.authorizedKeys.keys = [
      keys.crona.luna
      keys.excalibur.luna
    ];
  };

  users.users.root = {
    openssh.authorizedKeys.keys = [
      keys.crona.luna
      keys.excalibur.luna
    ];
  };
}

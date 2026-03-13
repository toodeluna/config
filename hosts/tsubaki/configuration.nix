{
  config,
  keys,
  lib,
  self,
  pkgs,
  ...
}:
{
  i18n.defaultLocale = "en_US.UTF-8";

  console.useXkbConfig = true;
  networking.useNetworkd = true;

  programs.git.enable = true;
  programs.neovim.enable = true;

  environment.defaultPackages = [ ];
  fonts.enableDefaultPackages = false;

  users.mutableUsers = false;

  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
  };

  services.xserver.xkb = {
    layout = "us";
    options = "caps:escape";
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
    hashedPasswordFile = config.age.secrets.password.path;

    openssh.authorizedKeys.keys = [
      keys.crona.luna
      keys.excalibur.luna
    ];
  };

  age.secrets = {
    password.file = "${self}/secrets/tsubaki/password.age";
  };
}

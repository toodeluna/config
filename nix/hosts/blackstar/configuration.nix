{
  config,
  keys,
  self,
  ...
}:
{
  soul.hardware = {
    amdcpu.enable = true;
  };

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
    configurationLimit = 10;
  };

  users.users.luna = {
    isNormalUser = true;
    description = "Luna Heyman";
    hashedPasswordFile = config.age.secrets.password.path;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [ keys.crona.luna ];
  };

  age.secrets = {
    password.file = "${self}/nix/secrets/blackstar/password.age";
  };

  services.openssh.settings = {
    PasswordAuthentication = false;
  };
}

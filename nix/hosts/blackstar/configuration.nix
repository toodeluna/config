{ config, self, ... }:
{
  soul.hardware = {
    amdcpu.enable = true;
  };

  soul.system.boot = {
    loader = "grub";
  };

  soul.system.users.luna = {
    email = "luna@toodeluna.net";
    firstName = "Luna";
    lastName = "Heyman";
    password = "${self}/nix/secrets/blackstar/password.age";
  };

  users.users.root = {
    hashedPasswordFile = config.age.secrets."users/luna".path;
  };
}

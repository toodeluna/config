{ self, ... }:
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
}

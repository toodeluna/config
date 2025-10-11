{ self, ... }:
{
  flake.modules.generic.base.age.secrets = {
    password.file = "${self}/secrets/password.age";
  };
}

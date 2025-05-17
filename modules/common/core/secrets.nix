{ self, ... }:
{
  age.secrets.password.file = "${self}/secrets/password.age";
}

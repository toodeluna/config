{
  self,
  lib,
  config,
  ...
}:
{
  options.soul.secrets.enable = lib.mkEnableOption "secret management with agenix" // {
    default = true;
  };

  config.age.secrets = lib.mkIf config.soul.secrets.enable {
    password.file = "${self}/secrets/password.age";
  };
}

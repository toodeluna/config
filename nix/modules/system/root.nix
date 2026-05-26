{
  config,
  keys,
  lib,
  mkNixosModule,
  ...
}:
let
  cfg = config.soul.system.root;
in
mkNixosModule {
  options.soul.system.root = {
    password = lib.mkOption {
      description = "The path to the root password secret.";
      example = ./root-password.age;
      type = lib.types.path;
    };
  };

  config = {
    users.users.root = {
      hashedPasswordFile = config.age.secrets.root-password.path;
      openssh.authorizedKeys.keys = keys.all;
    };

    age.secrets = {
      root-password.file = cfg.password;
    };
  };
}

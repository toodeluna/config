{
  flake.modules.nixos.base =
    { config, ... }:
    {
      users = {
        mutableUsers = false;
        users.root.hashedPasswordFile = config.age.secrets.password.path;
      };
    };
}

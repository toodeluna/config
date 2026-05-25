{
  config,
  lib,
  mkModule,
  pkgs,
  keys,
  ...
}:
let
  cfg = config.soul.system.users;
  usernames = lib.mapAttrsToList (name: value: value.name) cfg;

  existingGroups = lib.mapAttrsToList (name: value: value.name) config.users.groups;
  doesGroupExist = name: builtins.elem name existingGroups;

  wantedGroups = builtins.filter doesGroupExist [
    "wheel"
    "video"
    "audio"
    "gamemode"
  ];

  authorizedKeys = [
    keys.blackstar.root
    keys.blackstar.luna
    keys.crona.root
    keys.crona.luna
  ];

  mapUsers =
    function:
    cfg
    |> builtins.attrValues
    |> lib.imap1 (index: value: lib.nameValuePair value.name (function index value))
    |> lib.listToAttrs;

  user = lib.types.submodule (
    { config, name, ... }:
    {
      options = {
        name = lib.mkOption {
          defaultText = "<name>";
          description = "The username of the user.";
          example = "maka";
          type = lib.types.strMatching "([a-z0-9]+)";
        };

        primary = lib.mkOption {
          default = false;
          description = "Whether this is the primary user of the system.";
          example = true;
          type = lib.types.bool;
        };

        email = lib.mkOption {
          description = "The primary email address of the user.";
          example = "maka.albarn@proton.me";
          type = lib.types.str;
        };

        firstName = lib.mkOption {
          description = "The first name of the user.";
          example = "Maka";
          type = lib.types.str;
        };

        lastName = lib.mkOption {
          description = "The last name of the user.";
          example = "Albarn";
          type = lib.types.str;
        };

        fullName = lib.mkOption {
          defaultText = ''"''${config.firstName} ''${config.lastName}"'';
          description = "The full name of the user.";
          example = "Maka Albarn";
          type = lib.types.str;
        };

        password = lib.mkOption {
          default = null;
          description = "The path to the password secret file.";
          example = ./password.age;
          type = lib.types.nullOr lib.types.path;
        };
      };

      config = {
        name = lib.mkDefault name;
        fullName = lib.mkDefault "${config.firstName} ${config.lastName}";
      };
    }
  );
in
mkModule {
  shared.options.soul.system.users = lib.mkOption {
    description = "An attribute set of users to create on the system.";
    default = { };
    type = lib.types.attrsOf user;
  };

  shared.config = {
    users.users = mapUsers (
      index: user: {
        description = user.fullName;
        shell = pkgs.bashInteractive;
        openssh.authorizedKeys.keys = authorizedKeys;
      }
    );

    home-manager.users = mapUsers (
      index: user: {
        _module.args = { inherit user; };
      }
    );
  };

  nixos.config = {
    users.users = mapUsers (
      index: user: {
        isNormalUser = true;
        extraGroups = wantedGroups;
        hashedPasswordFile = config.age.secrets."users/${user.name}".path or null;
      }
    );

    age.secrets = lib.mapAttrs' (
      name: value: lib.nameValuePair "users/${value.name}" { file = value.password; }
    ) cfg;
  };

  darwin.config = {
    system.primaryUser = cfg |> builtins.attrValues |> lib.findSingle (user: user.primary) null null;
    users.knownUsers = usernames;

    users.users = mapUsers (
      index: user: {
        uid = 500 + index;
        createHome = true;
        home = "/Users/${user.name}";
      }
    );
  };
}

{
  config,
  keys,
  lib,
  self,
  pkgs,
  ...
}:
{
  soul.system = {
    type = "server";
  };

  console.useXkbConfig = true;
  networking.useNetworkd = true;

  programs.git.enable = true;
  programs.neovim.enable = true;

  users.mutableUsers = false;

  environment.defaultPackages = [ ];
  fonts.enableDefaultPackages = false;

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  systemd.services.podman-yamtrack-network = {
    description = "Create yamtrack podman network";
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };

    script = ''
      ${lib.getExe pkgs.podman} network exists yamtrack || ${lib.getExe pkgs.podman} network create yamtrack
    '';
  };

  virtualisation.oci-containers.containers.redis = {
    image = "docker.io/library/redis:8-alpine";
    volumes = [ "/var/lib/yamtrack-redis:/data" ];
    ports = [ "127.0.0.1:6379:6379" ];
    networks = [ "yamtrack" ];
  };

  virtualisation.oci-containers.containers.yamtrack = {
    image = "ghcr.io/fuzzygrim/yamtrack:latest";
    dependsOn = [ "redis" ];
    volumes = [ "/var/lib/yamtrack/db:/yamtrack/db" ];
    ports = [ "127.0.0.1:4242:8000" ];
    networks = [ "yamtrack" ];
    environmentFiles = [ config.age.secrets.yamtrack-secret.path ];

    environment = {
      TZ = config.time.timeZone;
      REDIS_URL = "redis://redis:6379";
      URLS = "https://yamtrack.toodeluna.net";
      REGISTRATION = "False";
      ADMIN_ENABLED = "True";
    };
  };

  services.xserver.xkb = {
    layout = "us";
    options = "caps:escape";
  };

  services.anki-sync-server = {
    enable = true;
    address = "127.0.0.1";

    users = lib.singleton {
      username = "luna@toodeluna.net";
      passwordFile = config.age.secrets.anki-password-luna.path;
    };
  };

  services.nginx = {
    enable = true;

    virtualHosts."anki.toodeluna.net" = {
      forceSSL = true;
      enableACME = true;

      locations."/" = {
        proxyPass = "http://${config.services.anki-sync-server.address}:${toString config.services.anki-sync-server.port}";
        proxyWebsockets = true;
      };
    };

    virtualHosts."yamtrack.toodeluna.net" = {
      forceSSL = true;
      enableACME = true;

      locations."/" = {
        proxyPass = "http://127.0.0.1:4242";
        proxyWebsockets = true;
      };
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "luna@toodeluna.net";
  };

  age.secrets = {
    password.file = "${self}/secrets/blackstar/password.age";
    anki-password-luna.file = "${self}/secrets/blackstar/anki/luna.age";
    yamtrack-secret.file = "${self}/secrets/blackstar/yamtrack/secret.age";
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
    openssh.authorizedKeys.keys = [
      keys.crona.luna
      keys.excalibur.luna
    ];
  };
}

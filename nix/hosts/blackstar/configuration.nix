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

  security.acme = {
    acceptTerms = true;
    defaults.email = "luna@toodeluna.net";
  };

  services.tangled.knot = {
    enable = true;
    stateDir = "/var/lib/tangled/knot";

    repo = {
      scanPath = "${config.services.tangled.knot.stateDir}/repos";
    };

    server = {
      owner = "did:plc:5odpemgsnxty3zbaahu77rhv";
      hostname = "knot.toodeluna.net";
    };
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  services.nginx = {
    enable = true;

    virtualHosts.${config.services.tangled.knot.server.hostname} = {
      enableACME = true;
      forceSSL = true;

      locations."/" = {
        proxyPass = "http://${config.services.tangled.knot.server.listenAddr}";
        proxyWebsockets = true;
      };
    };
  };
}

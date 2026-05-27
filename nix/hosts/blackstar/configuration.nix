{ config, self, ... }:
{
  soul.hardware = {
    amdcpu.enable = true;
  };

  soul.system = {
    domain = "toodeluna.net";
    boot.loader = "grub";
    root.password = "${self}/nix/secrets/blackstar/password.age";
  };

  soul.system.users.luna = {
    primary = true;
    email = "luna@toodeluna.net";
    firstName = "Luna";
    lastName = "Heyman";
    did = "did:plc:5odpemgsnxty3zbaahu77rhv";
    password = "${self}/nix/secrets/blackstar/password.age";
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = config.lib.soul.primaryUser.email;
  };

  services.tangled.knot = {
    enable = true;
    stateDir = "/var/lib/tangled/knot";

    repo = {
      scanPath = "${config.services.tangled.knot.stateDir}/repos";
    };

    server = {
      owner = config.lib.soul.primaryUser.did;
      hostname = config.lib.soul.mkSubdomain "knot";
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

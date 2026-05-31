{ config, self, ... }:
{
  soul.hardware = {
    intelcpu.enable = true;
  };

  soul.system = {
    root.password = "${self}/nix/secrets/tsubaki/password.age";
  };

  soul.system.users.luna = {
    primary = true;
    email = "luna@toodeluna.net";
    firstName = "Luna";
    lastName = "Heyman";
    did = "did:plc:5odpemgsnxty3zbaahu77rhv";
    password = "${self}/nix/secrets/tsubaki/password.age";
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];

  services.jellyfin = {
    enable = true;
    openFirewall = true;
  };

  services.nginx = {
    enable = true;

    virtualHosts.${config.lib.soul.mkSubdomain "jellyfin"} = {
      locations."/" = {
        proxyPass = "http://127.0.0.1:8096";
        proxyWebsockets = true;
      };
    };
  };
}

{
  pkgs,
  config,
  lib,
  ...
}:
{
  options.soul.gaming.steam = {
    enable = lib.mkEnableOption "steam";
  };

  config = lib.mkIf config.soul.gaming.steam.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };
  };
}

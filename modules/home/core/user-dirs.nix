{
  lib,
  pkgs,
  config,
  ...
}:
{
  xdg.userDirs = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
    enable = true;
    createDirectories = true;

    music = "${config.home.homeDirectory}/music";
    desktop = "${config.home.homeDirectory}/desktop";
    documents = "${config.home.homeDirectory}/documents";
    download = "${config.home.homeDirectory}/downloads";
    pictures = "${config.home.homeDirectory}/pictures";
    publicShare = "${config.home.homeDirectory}/public";
    templates = "${config.home.homeDirectory}/templates";
    videos = "${config.home.homeDirectory}/videos";

    extraConfig = {
      XDG_GITHUB_DIR = "${config.home.homeDirectory}/github";
    };
  };
}

{ config, ... }:
let
  home = config.home.homeDirectory;
in
{
  xdg = {
    enable = true;

    userDirs = {
      enable = true;
      createDirectories = true;
      music = "${home}/music";
      documents = "${home}/documents";
      download = "${home}/downloads";
      pictures = "${home}/pictures";
      videos = "${home}/videos";
      publicShare = "${home}/";
      templates = "${home}/";
      desktop = "${home}/";
      extraConfig.XDG_GITHUB_DIR = "${home}/github";
    };

    mimeApps = {
      enable = true;

      defaultApplications = {
        "text/html" = "zen.desktop";
        "application/pdf" = "zen.desktop";
        "x-scheme-handler/http" = "zen.desktop";
        "x-scheme-handler/https" = "zen.desktop";
        "x-scheme-handler/ftp" = "zen.desktop";
        "x-scheme-handler/about" = "zen.desktop";
        "x-scheme-handler/unknown" = "zen.desktop";
      };
    };
  };
}

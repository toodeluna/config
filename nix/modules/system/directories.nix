{ mkNixosModule, ... }:
mkNixosModule {
  soul.system.home =
    { config, ... }:
    let
      inherit (config.home) homeDirectory;
    in
    {
      home = {
        preferXdgDirectories = true;
      };

      xdg.userDirs = {
        enable = true;
        createDirectories = true;

        desktop = "${homeDirectory}/desktop";
        documents = "${homeDirectory}/documents";
        download = "${homeDirectory}/downloads";
        music = "${homeDirectory}/music";
        pictures = "${homeDirectory}/pictures";
        publicShare = "${homeDirectory}/share";
        templates = "${homeDirectory}/templates";
        videos = "${homeDirectory}/videos";
        projects = "${homeDirectory}/projects";

        extraConfig = {
          GAMES_DIR = "${homeDirectory}/games";
        };
      };
    };
}

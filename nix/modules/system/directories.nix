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
        music = "${homeDirectory}/media/music";
        pictures = "${homeDirectory}/media/photos";
        publicShare = "${homeDirectory}/share";
        templates = "${homeDirectory}/templates";
        videos = "${homeDirectory}/media/videos";

        extraConfig = {
          CODE_DIR = "${homeDirectory}/code";
          GAMES_DIR = "${homeDirectory}/media/games";
        };
      };
    };
}

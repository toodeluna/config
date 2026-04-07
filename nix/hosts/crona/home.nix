{
  colors,
  config,
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  inherit (config.home) homeDirectory;

  nixvimArgs = {
    inherit osConfig;
    homeConfig = config;
  };

  palette = lib.getAttr config.catppuccin.flavor (
    lib.importJSON "${config.catppuccin.sources.palette}/palette.json"
  );
in
{
  _module.args = { inherit (palette) colors; };

  programs.home-manager.enable = true;

  home = {
    stateVersion = "26.05";
    preferXdgDirectories = true;
  };

  catppuccin = {
    inherit (osConfig.catppuccin) enable flavor accent;
    sources.palette = osConfig.catppuccin.sources.palette;
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

  programs.git = {
    enable = true;

    signing = {
      signByDefault = true;
      format = "ssh";
      key = "${homeDirectory}/.ssh/id_ed25519.pub";
    };

    settings = {
      core.ignorecase = false;
      pull.rebase = true;
      init.defaultBranch = "main";

      user = {
        name = "Luna Heyman";
        email = "luna@toodeluna.net";
      };

      alias = {
        lga = "log --decorate --oneline --graph";
        put = "push --set-upstream";
        ui = "!${lib.getExe pkgs.lazygit}";
      };
    };
  };

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    vimdiffAlias = true;
    viAlias = true;
    useGlobalPkgs = true;

    imports = [
      ./neovim.nix
      { _module.args = nixvimArgs; }
    ];
  };

  wayland.windowManager.mango = {
    enable = true;

    settings = {
      borderpx = 2;
      border_radius = 6;

      bordercolor = "0x${builtins.substring 1 (-1) colors.overlay0.hex}ff";
      focuscolor = "0x${builtins.substring 1 (-1) colors.blue.hex}ff";
    };

    settings.monitorrule = [
      "name:DP-1,scale:1.75,width:2840,height:2160"
    ];

    settings.bind = [
      "SUPER, R, reload_config"

      "SUPER, Q, killclient"
      "SUPER+SHIFT_L, Q, quit"

      "SUPER, RETURN, spawn, ${lib.getExe pkgs.kitty}"
      "SUPER, SPACE, spawn, ${lib.getExe pkgs.rofi} -show drun"

      "SUPER, H, focusdir, left"
      "SUPER, J, focusdir, down"
      "SUPER, K, focusdir, up"
      "SUPER, L, focusdir, right"

      "SUPER+SHIFT_L, H, exchange_client, left"
      "SUPER+SHIFT_L, J, exchange_client, down"
      "SUPER+SHIFT_L, K, exchange_client, up"
      "SUPER+SHIFT_L, L, exchange_client, right"
    ];
  };
}

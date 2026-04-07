{
  config,
  osConfig,
  pkgs,
  lib,
  ...
}:
let
  inherit (config.home) homeDirectory;

  nixvimArgs = {
    inherit osConfig;
    homeConfig = config;
  };
in
{
  programs.home-manager.enable = true;

  home = {
    stateVersion = "26.05";
    preferXdgDirectories = true;
  };

  catppuccin = {
    inherit (osConfig.catppuccin) enable flavor accent;
    sources.palette = osConfig.catppuccin.sources.palette;
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
}

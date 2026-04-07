{ homeConfig, ... }:
{
  opts = {
    termguicolors = true;
    wrap = false;
    scrolloff = 10;

    number = true;
    relativenumber = true;

    shiftwidth = 4;
    tabstop = 4;
    softtabstop = 4;
    expandtab = false;
    smartindent = true;
    list = true;

    hlsearch = false;
    incsearch = true;
  };

  colorschemes.catppuccin = {
    enable = true;

    settings = {
      flavour = homeConfig.catppuccin.flavor;
      transparent_background = true;
    };
  };

  files."ftplugin/nix.lua".localOpts = {
    shiftwidth = 2;
    tabstop = 2;
    softtabstop = 2;
    expandtab = true;
  };
}

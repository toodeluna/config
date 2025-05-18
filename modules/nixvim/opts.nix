{
  globals = {
    mapleader = " ";
  };

  opts = {
    cursorline = true;
    number = true;
    relativenumber = true;
    wrap = false;
    scrolloff = 10;

    list = true;
    expandtab = false;
    smartindent = true;
    tabstop = 4;
    softtabstop = 0;
    shiftwidth = 4;

    ignorecase = true;
    smartcase = true;
    undofile = true;
    backup = false;
    swapfile = false;
  };

  files."ftplugin/nix.lua".localOpts = {
    expandtab = true;
    tabstop = 2;
    shiftwidth = 2;
  };
}

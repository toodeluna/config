{ lib, ... }:
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

  keymaps = [
    {
      mode = "n";
      key = "<leader>q";
      action = lib.nixvim.mkRaw "vim.cmd.exit";
    }
    {
      mode = "n";
      key = "<leader>h";
      action = "<C-w>h";
    }
    {
      mode = "n";
      key = "<leader>j";
      action = "<C-w>j";
    }
    {
      mode = "n";
      key = "<leader>k";
      action = "<C-w>k";
    }
    {
      mode = "n";
      key = "<leader>l";
      action = "<C-w>l";
    }
    {
      mode = "n";
      key = "J";
      action = "mzJ`z";
    }
    {
      mode = "v";
      key = "J";
      action = ":m '>+1<CR>gv=gv";
      options.silent = true;
    }
    {
      mode = "v";
      key = "K";
      action = ":m '<-2<CR>gv=gv";
      options.silent = true;
    }
  ];
}

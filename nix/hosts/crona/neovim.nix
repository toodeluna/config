{
  homeConfig,
  lib,
  pkgs,
  ...
}:
{
  globals.mapleader = " ";

  plugins.lualine.enable = true;
  plugins.noice.enable = true;
  plugins.telescope.enable = true;

  plugins.mini = {
    enable = true;
    mockDevIcons = true;

    modules = {
      icons.style = "glyph";
      files = { };
    };
  };

  opts = {
    signcolumn = "yes";
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

  plugins.lsp = {
    enable = true;

    servers = {
      nixd.enable = true;
    };
  };

  plugins.blink-cmp = {
    enable = true;

    settings.keymap = {
      preset = "enter";
      "<Tab>" = [ "select_next" ];
      "<S-Tab>" = [ "select_prev" ];
    };
  };

  plugins.conform-nvim = {
    enable = true;

    settings.format_on_save = {
      timeout_ms = 500;
      lsp_format = "fallback";
    };

    settings.formatters_by_ft = {
      bash = [ "shfmt" ];
      just = [ "just" ];
      nix = [ "nixfmt" ];
      sh = [ "shfmt" ];
    };

    settings.formatters_by_ft._ = [
      "squeeze_blanks"
      "trim_whitepace"
      "trim_newlines"
    ];

    settings.formatters = {
      just.command = lib.getExe pkgs.just;
      nixfmt.command = lib.getExe pkgs.nixfmt;
    };

    settings.formatters.shfmt = {
      command = lib.getExe pkgs.shfmt;

      args = [
        "-s"
        "-i"
        "2"
      ];
    };
  };

  plugins.treesitter = {
    enable = true;
    highlight.enable = true;
    indent.enable = true;

    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      bash
      gitattributes
      gitignore
      just
      markdown
      nix
    ];
  };

  files."ftplugin/nix.lua".localOpts = {
    shiftwidth = 2;
    tabstop = 2;
    softtabstop = 2;
    expandtab = true;
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>fe";
      action = lib.nixvim.mkRaw "MiniFiles.open";
      options.desc = "Toggle file explorer";
    }
    {
      mode = "n";
      key = "<leader>fp";
      action = lib.nixvim.mkRaw ''require("telescope.builtin").find_files'';
      options.desc = "Find files";
    }
  ];
}

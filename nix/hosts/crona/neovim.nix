{
  homeConfig,
  lib,
  pkgs,
  ...
}:
{
  globals.mapleader = " ";

  plugins.lualine.enable = true;
  plugins.neo-tree.enable = true;
  plugins.noice.enable = true;
  plugins.oil.enable = true;
  plugins.telescope.enable = true;

  plugins.mini = {
    enable = true;
    mockDevIcons = true;

    modules = {
      icons.style = "glyph";
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

      "<Tab>" = [
        "select_next"
        "fallback"
      ];

      "<S-Tab>" = [
        "select_prev"
        "fallback"
      ];
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
      qml = [ "qmlformat" ];
      sh = [ "shfmt" ];
    };

    settings.formatters_by_ft._ = [
      "squeeze_blanks"
      "trim_whitespace"
      "trim_newlines"
    ];

    settings.formatters = {
      just.command = lib.getExe pkgs.just;
      nixfmt.command = lib.getExe pkgs.nixfmt;
      qmlformat.command = lib.getExe' pkgs.kdePackages.qtdeclarative "qmlformat";
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
      devicetree
      gitattributes
      gitignore
      just
      markdown
      nix
      qmljs
    ];
  };

  files."ftplugin/nix.lua".localOpts = {
    shiftwidth = 2;
    tabstop = 2;
    softtabstop = 2;
    expandtab = true;
  };

  files."ftplugin/qml.lua".localOpts = {
    expandtab = true;
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>fe";
      action = ":Neotree toggle<CR>";
      options.desc = "Toggle file tree";
      options.silent = true;
    }
    {
      mode = "n";
      key = "-";
      action = ":Oil<CR>";
      options.desc = "Open file explorer";
      options.silent = true;
    }
    {
      mode = "n";
      key = "<leader>fp";
      action = lib.nixvim.mkRaw ''require("telescope.builtin").find_files'';
      options.desc = "Find files";
    }
  ];
}

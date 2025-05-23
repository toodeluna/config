{
  plugins.lspconfig.enable = true;

  plugins.blink-cmp = {
    enable = true;

    settings.keymap = {
      preset = "enter";
      "<Tab>" = [ "select_next" ];
      "<S-Tab>" = [ "select_prev" ];
    };
  };

  lsp.servers = {
    nixd.enable = true;
    rust_analyzer.enable = true;
  };
}

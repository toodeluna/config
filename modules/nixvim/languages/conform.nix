{ pkgs, ... }:
{
  plugins.conform-nvim = {
    enable = true;

    settings = {
      formatters_by_ft = {
        nix = [ "nixfmt" ];
        rust = [ "rustfmt" ];
        markdown = [ "prettierd" ];
      };

      format_on_save = {
        timeout_ms = 500;
        lsp_format = "fallback";
      };
    };
  };

  extraPackages = [
    pkgs.rustfmt
    pkgs.nixfmt-rfc-style
    pkgs.prettierd
  ];
}

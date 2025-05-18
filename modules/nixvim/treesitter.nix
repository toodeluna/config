{ pkgs, ... }:
{
  plugins.treesitter = {
    enable = true;

    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      c
      cpp
      html
      javascript
      markdown
      nix
      rust
      typescript
    ];

    settings = {
      highlight.enable = true;
      indent.enable = true;
    };
  };
}

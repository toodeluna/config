{ pkgs, ... }:
{
  extraPackages = [ pkgs.ripgrep ];
  plugins.web-devicons.enable = true;

  plugins.telescope = {
    enable = true;

    extensions.file-browser = {
      enable = true;
      settings.grouped = true;
    };

    keymaps = {
      "<leader>fp".action = "find_files";
      "<leader>fg".action = "live_grep";
      "<leader>fe".action = "file_browser path=%:p:h select_buffer=true";
    };
  };
}

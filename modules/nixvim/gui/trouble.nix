{
  plugins.trouble.enable = true;

  keymaps = [
    {
      key = "<leader>e";
      action = ":Trouble diagnostics toggle<CR>";
      options.silent = true;
    }
  ];
}

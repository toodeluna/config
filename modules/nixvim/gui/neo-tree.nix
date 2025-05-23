{
  plugins.neo-tree.enable = true;

  keymaps = [
    {
      key = "<leader>ft";
      action = ":Neotree toggle<CR>";
      options.silent = true;
    }
  ];
}

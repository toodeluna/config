{
  treefmt,
  nixfmt,
  prettier,
}:
treefmt.withConfig {
  runtimeInputs = [
    nixfmt
    prettier
  ];

  settings = {
    tree-root-file = "flake.nix";

    formatter.nixfmt = {
      command = "nixfmt";
      includes = [ "*.nix" ];
    };

    formatter.prettier = {
      command = "prettier";
      includes = [ "*.md" ];
    };
  };
}

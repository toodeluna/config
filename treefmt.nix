{
  treefmt,
  kdePackages,
  nixfmt,
  prettier,
}:
treefmt.withConfig {
  runtimeInputs = [
    kdePackages.qtdeclarative
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

    formatter.qmlformat = {
      command = "qmlformat";
      options = [ "-i" ];
      includes = [ "*.qml" ];
    };
  };
}

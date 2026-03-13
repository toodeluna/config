{
  treefmt,
  just,
  kdePackages,
  nixfmt,
  prettier,
  bash,
}:
treefmt.withConfig {
  runtimeInputs = [
    bash
    just
    kdePackages.qtdeclarative
    nixfmt
    prettier
  ];

  settings = {
    tree-root-file = "flake.nix";

    formatter.just = {
      command = "bash";
      includes = [ "justfile" ];

      options = [
        "-euc"
        ''for file in "$@"; do just --fmt --unstable --justfile "$file"; done''
        "--"
      ];
    };

    formatter.nixfmt = {
      command = "nixfmt";
      includes = [ "*.nix" ];
    };

    formatter.prettier = {
      command = "prettier";

      includes = [
        "*.md"
        "*.yml"
      ];
    };

    formatter.qmlformat = {
      command = "qmlformat";
      options = [ "-i" ];
      includes = [ "*.qml" ];
    };
  };
}

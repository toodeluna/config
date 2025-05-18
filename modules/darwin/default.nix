{
  imports = [
    ./core/home-manager.nix
    ./core/homebrew.nix
    ./core/i18n.nix
    ./core/keyboard.nix
    ./core/profile.nix
    ./core/sudo.nix
    ./core/trackpad.nix

    ./gui/dock.nix
    ./gui/packages.nix

    ./options/shell.nix
  ];
}

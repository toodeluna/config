{
  imports = [
    ./core/home-manager.nix
    ./core/neovim.nix
    ./core/nix.nix
    ./core/overlays.nix
    ./core/packages.nix
    ./core/profile.nix
    ./core/secrets.nix
    ./core/ssh.nix
    ./core/sudo.nix
    ./core/version.nix
    ./core/zsh.nix

    ./gui/fonts.nix
    ./gui/packages.nix

    ./options/gaming.nix
    ./options/gui.nix
  ];
}

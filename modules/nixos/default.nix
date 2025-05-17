{
  imports = [
    ./core/boot.nix
    ./core/catppuccin.nix
    ./core/home-manager.nix
    ./core/i18n.nix
    ./core/profile.nix
    ./core/ssh.nix
    ./core/tty.nix
    ./core/xserver.nix

    ./gui/graphics.nix
    ./gui/greetd.nix
    ./gui/hyprland.nix
    ./gui/pipewire.nix
    ./gui/quiet-boot.nix
  ];
}

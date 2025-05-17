{
  pkgs,
  lib,
  osConfig,
  ...
}:
{
  programs.waybar = lib.mkIf osConfig.custom.modules.gui.enable {
    enable = true;

    settings.main = {
      layer = "top";
      position = "top";

      margin-left = 10;
      margin-right = 10;
      margin-top = 10;

      modules-left = [ "hyprland/workspaces" ];
      modules-center = [ "custom/music" ];
      modules-right = [
        "pulseaudio"
        "pulseaudio/slider"
        "clock"
      ];

      "hyprland/workspaces" = {
        active-only = false;
        format = "";
        persistent-workspaces."*" = lib.range 1 9;
      };

      "custom/music" = {
        format = "  {}";
        exec = "${pkgs.playerctl}/bin/playerctl metadata --format='{{ artist }} - {{ title }}'";
        on-click = "${pkgs.playerctl}/bin/playerctl play-pause";
        interval = 3;
      };

      pulseaudio = {
        format = "  {volume}%";
        format-muted = "  {volume}%";
      };

      "pulseaudio/slider" = {
        min = 0;
        max = 100;
        orientation = "horizontal";
      };

      clock = {
        format = "󰥔  {:%H:%M %D}";
      };
    };

    style = ''
      * {
        font-family: monospace;
        font-size: 14px;
      }

      #waybar {
        background: transparent;
      }

      #workspaces {
        background-color: @surface0;
        border-radius: 0.5rem;
        border: 1px solid @mauve;
        padding-right: 4px;
      }

      #workspaces button {
        transition: none;
        color: @pink;
      }

      #workspaces button:hover {
        border-color: transparent;
        background: none;
      }

      #workspaces button.active {
        color: @sky;
      }

      #pulseaudio-slider {
        margin-right: 1rem;
      }

      #pulseaudio-slider trough {
        min-width: 14rem;
        min-height: 0.5rem;
        background-color: @overlay1;
        border: none;
      }

      #pulseaudio-slider highlight {
        background-color: @pink;
        border: none;
      }

      #pulseaudio-slider slider {
        min-width: 0px;
        min-height: 0px;
        background-image: none;
        background-color: @text;
        border: none;
        box-shadow: none;
      }

      #pulseaudio {
        margin-right: 1rem;
      }

      #custom-music,
      #clock,
      #pulseaudio,
      #pulseaudio-slider {
        background-color: @surface0;
        padding: 0 1rem;
        border: 1px solid @mauve;
        border-radius: 0.5rem;
      }
    '';
  };
}

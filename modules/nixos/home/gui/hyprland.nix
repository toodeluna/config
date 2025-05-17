{
  pkgs,
  lib,
  osConfig,
  inputs',
  ...
}:
{
  wayland.windowManager.hyprland = lib.mkIf osConfig.custom.modules.gui.enable {
    enable = true;
    systemd.enable = false;

    extraConfig = ''
      submap = resize
      binde = , h, resizeactive, -50 0
      binde = , j, resizeactive, 0 50
      binde = , k, resizeactive, 0 -50
      binde = , l, resizeactive, 50 0
      bind = , escape, submap, reset
      submap = reset
    '';

    settings = {
      "$mod" = "SUPER";
      "$terminal" = "${pkgs.uwsm}/bin/uwsm app ${pkgs.foot}/bin/foot";
      "$browser" = "${pkgs.uwsm}/bin/uwsm app ${inputs'.zen-browser.packages.default}/bin/zen";
      "$fileManager" = "${pkgs.uwsm}/bin/uwsm app ${pkgs.nemo}/bin/nemo";
      "$menu" =
        ''${pkgs.uwsm}/bin/uwsm app ${pkgs.rofi-wayland}/bin/rofi -- -show drun -run-command "${pkgs.uwsm}/bin/uwsm app \"{cmd}\""'';

      exec-once = [
        "systemctl --user enable --now hyprpaper.service"
        "${pkgs.waybar}/bin/waybar"
      ];

      bind = [
        "$mod, Q, killactive"
        "$mod SHIFT, Q, exit"
        "$mod, F, togglefloating"
        "$mod SHIFT, F, fullscreen"
        "$mod, R, submap, resize"

        "$mod, return, exec, $terminal"
        "$mod, space, exec, $menu"
        "$mod, B, exec, $browser"
        "$mod, E, exec, $fileManager"

        "$mod, H, movefocus, l"
        "$mod, J, movefocus, d"
        "$mod, K, movefocus, u"
        "$mod, L, movefocus, r"

        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, J, movewindow, d"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, L, movewindow, r"

        "$mod, 0, workspace, 0"
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"

        "$mod SHIFT, 0, movetoworkspace, 0"
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"

        ''$mod, S, exec, ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | ${pkgs.wl-clipboard}/bin/wl-copy''
        "$mod SHIFT, S, exec, ${pkgs.grim}/bin/grim - | ${pkgs.wl-clipboard}/bin/wl-copy"
        "$mod, C, exec, ${pkgs.hyprpicker}/bin/hyprpicker | ${pkgs.wl-clipboard}/bin/wl-copy"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      windowrule = [
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];

      bezier = [
        "linear, 0, 0, 1, 1"
        "easeOut, 0.33, 1, 0.68, 1"
      ];

      animation = [
        "windowsIn, 1, 5, easeOut, slide bottom"
        "windowsOut, 1, 20, easeOut, popin"
        "windowsMove, 1, 2, linear"
        "workspaces, 1, 2, linear, slide"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;
        gaps_workspaces = 0;
        border_size = 1;
        resize_corner = 0;
        no_border_on_floating = false;
        resize_on_border = true;
        allow_tearing = false;
        layout = "master";

        "col.active_border" = "$mauve $pink 45deg";
        "col.inactive_border" = "$surface1";
      };

      decoration = {
        rounding = 5;
        rounding_power = 2.0;
        shadow.enabled = true;
      };

      animations = {
        enabled = true;
        first_launch_animation = true;
      };

      input = {
        kb_layout = osConfig.services.xserver.xkb.layout;
        kb_options = osConfig.services.xserver.xkb.options;
      };

      xwayland = {
        enabled = true;
        force_zero_scaling = true;
      };

      misc = {
        middle_click_paste = false;
        disable_hyprland_logo = true;
        force_default_wallpaper = 0;
      };
    };
  };
}

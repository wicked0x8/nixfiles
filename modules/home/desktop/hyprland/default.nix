{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.mine) user;
  cfg = config.mine.desktop.hyprland;
in
{
  options.mine.desktop.hyprland = {
    home = mkEnableOption "enable hyprland home-manager config";
  };

  config = mkIf cfg.home {
    home-manager.users.${user.name} = {
      wayland.windowManager.hyprland = {
        enable = true;
        package = pkgs.hyprland;

        extraConfig = ''
          exec-once = alacritty
          monitor= eDP-1, 1920x1080@60.00, 0x0, 1
        '';

        settings = {
          "$mod" = "SUPER";

          env = [ "XCURSOR_SIZE=32" ];

          general = {
            layout = "dwindle";
            gaps_in = 5;
            gaps_out = 5;

	   "col.active_border" = "rgb(${config.colorScheme.palette.base05}) rgb(${config.colorScheme.palette.base00}) 45deg";
	   "col.inactive_border" = "rgb(${config.colorScheme.palette.base01})";
          };

          group = {
            groupbar = {
              height = "14";
              font_size = "12";
              indicator_height = "6";
            };
          };

          master = {
            new_status = true;
          };

          misc = {
            key_press_enables_dpms = false;
          };

          bezier = [
            "default, 0.12, 0.92, 0.08, 1.0"
            "wind, 0.12, 0.92, 0.08, 1.0"
            "overshot, 0.18, 0.95, 0.22, 1.03"
            "liner, 1, 1, 1, 1"
          ];

          animation = [
            "windows, 1, 5, wind, popin 60%"
            "windowsIn, 1, 6, overshot, popin 60%"
            "windowsOut, 1, 4, overshot, popin 60%"
            "windowsMove, 1, 4, overshot, slide"
            "layers, 1, 4, default, popin"
            "fadeIn, 1, 7, default"
            "fadeOut, 1, 7, default"
            "fadeSwitch, 1, 7, default"
            "fadeShadow, 1, 7, default"
            "fadeDim, 1, 7, default"
            "fadeLayers, 1, 7, default"
            "workspaces, 1, 5, overshot, slidevert"
            "border, 1, 1, liner"
            "borderangle, 1, 24, liner, loop"
          ];

          decoration = {
            rounding = 5;
          };

          bindm = [
            "$mod, mouse:272, resizewindow"
            "$mod, mouse:273, movewindow"
          ];

          bind = [
            "$mod_shift, space, togglefloating"
            "$mod, F, fullscreen"
            "$mod, B, exec, firefox"
            "$mod_shift, Q, killactive"
            "$mod, T, exec, alacritty"
            # Mouse Focus
            "$mod, H, movefocus, l"
            "$mod, L, movefocus, r"
            "$mod, K, movefocus, u"
            "$mod, J, movefocus, d"
            # Window Management
            #"$mod_shift, H, movewindoworgroup, l"
            #"$mod_shift, L, movewindoworgroup, r"
            #"$mod_shift, K, movewindoworgroup, u"
            #"$mod_shift, J, movewindoworgroup, d"
            # Workspace Switcher
            #"$mod, TAB, workspace, previous"
            #"$mod, T, togglegroup"
            #"$mod, C, changegroupactive, b"
            #"$mod, V, changegroupactive, f"
          ]
          ++ builtins.concatLists (
            builtins.genList (
              x:
              let
                ws =
                  let
                    c = (x + 1) / 10;
                  in
                  builtins.toString (x + 1 - (c * 10));
              in
              [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod_SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            ) 10
          );
        };
      };
    };
  };
}

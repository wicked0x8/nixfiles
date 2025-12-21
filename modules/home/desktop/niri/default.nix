
{ lib, config, pkgs, inputs, user, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.mine) user;
  cfg = config.mine.desktop.niri;
in
{
  options.mine.desktop.niri = {
    home = mkEnableOption "enable niri wayland compositor hm config";
  };

  config = mkIf cfg.home {
    home-manager.users.${user.name} = { pkgs, config, lib, ... }: {
      imports = [ inputs.niri.homeModules.config ];
      nixpkgs.overlays = [ inputs.niri.overlays.niri ];

      programs.niri.package = pkgs.niri-unstable;
      programs.niri.settings = {

       # includes = [
       #   "dms/colors.kdl"
       #   "dms/layout.kdl"
       #   "dms/alttab.kdl"
       #   "dms/wpblur.kdl"
       # ];

        # Monitors
        outputs = {
          "eDP-1" = {
            mode = { width = 1920; height = 1080; refresh = 60.0; };
            position = { x = 0; y = 0; };
            scale = 1.0;
          };
          "HDMI-A-1" = {
            mode = { width = 1920; height = 1080; refresh = 75.0; };
            position = { x = 1920; y = 0; };
            scale = 1.0;
          };
        };

        # Input
        input = {
          mod-key = "Super";
          keyboard = {
            repeat-delay = 600;
            repeat-rate = 25;
            xkb = {
              layout = "us,ru";
              options = "grp:lalt_lshift_toggle";
            };
          };
          touchpad = {
            tap = true;
            natural-scroll = false;
          };
        };

        environment = {
          XDG_CURRENT_DESKTOP = "niri";
          QT_QPA_PLATFORM = "wayland";
          ELECTRON_OZONE_PLATFORM_HINT = "auto";
          QT_QPA_PLATFORMTHEME = "gtk3";
          QT_QPA_PLATFORMTHEME_QT6 = "gtk3";
        };

        binds = with config.lib.niri.actions; {
          "Mod+T".action.spawn = "alacritty";
          "Mod+B".action.spawn = "firefox";

          "Mod+H".action = focus-column-left;
          "Mod+J".action = focus-window-down;
          "Mod+K".action = focus-window-up;
          "Mod+L".action = focus-column-right;

          "Mod+Ctrl+H".action = move-column-left;
          "Mod+Ctrl+J".action = move-window-down;
          "Mod+Ctrl+K".action = move-window-up;
          "Mod+Ctrl+L".action = move-column-right;
        };
      };
    };
  };
}


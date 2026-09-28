{
  lib,
  config,
  inputs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.mine) user;
  cfg = config.mine.desktop.paneru;
in
{
  options.mine.desktop.paneru = {
    home = mkEnableOption "enable paneru home module";
  };

  config = mkIf cfg.home {
    home-manager.users.${user.name} = {
      imports = [
        inputs.paneru.homeModules.paneru
      ];

      services.paneru = {
        enable = true;
        # Equivalent to what you would put into `~/.paneru` (See Configuration options below).
        settings = {
          options = {
            preset_column_widths = [
              0.25
              0.33
              0.5
              0.66
              0.75
            ];
            swipe_gesture_fingers = 4;
            animation_speed = 4000;
            auto_center = true;

            padding_top = 4;
            padding_bottom = 4;
            padding_left = 4;
            padding_right = 4;
          };

          bindings = {
            window_focus_west = "cmd - h";
            window_focus_east = "cmd - l";
            window_focus_north = "cmd - k";
            window_focus_south = "cmd - j";
            window_swap_west = "alt - h";
            window_swap_east = "alt - l";
            window_swap_first = "alt + shift - h";
            window_swap_last = "alt + shift - l";
            window_center = "alt - c";
            window_resize = "alt - r";
            window_fullwidth = "alt - f";
            window_manage = "ctrl + alt - t";
            window_stack = "alt - ]";
            window_unstack = "alt + shift - ]";
            quit = "ctrl + alt - q";
          };

          windows.all = {
            title = ".*";
            horizontal_padding = 4;
            vertical_padding = 4;
          };
        };
      };
    };
  };
}

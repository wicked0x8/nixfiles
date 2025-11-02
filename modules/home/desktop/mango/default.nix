{ lib, config, pkgs, inputs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.mine) user;
  cfg = config.mine.desktop.mango;
  mangoModule = inputs.mango.nixosModules.mango;
in
{
  # Import mango Home Manager module for mango-specific HM options
  imports = [ mangoModule ];

  # Declare your custom option
  options.mine.desktop.mango = {
    home = mkEnableOption "Enable mango wayland compositor";
  };

  # Conditional config to enable mango session and wayland window manager
  config = mkIf cfg.home {
    home-manager.users.${user.name} = {
      home.sessionVariables = {
        XDG_CURRENT_SESSION = "mango";
        XDG_SESSION_TYPE = "wayland";
      };

      # Enable mango wm in the user environment
      wayland.windowManager.mango = {
        enable = true;
        package = inputs.mango;

        settings = ''
          # Put mango config here
        '';

        autostart_sh = ''
          # Put autostart commands here (without shebang)
        '';
      };
    };
  };
}

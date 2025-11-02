{ lib, config, pkgs, inputs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.mine) user;
  cfg = config.mine.desktop.mango;
  mangoModule = inputs.mango.nixosModules.mango;
in
{
  options.mine.desktop.mango = {
    home = mkEnableOption "Enable mango wayland compositor";
  };

  config = mkIf cfg.home {
    home-manager.users.${user.name} = {
      home.sessionVariables = {
        XDG_CURRENT_SESSION = "mango";
        XDG_SESSION_TYPE = "wayland";
      };

      wayland.windowManager.mango = {
        enable = true;

        settings = ''
          # Put mango config here
        '';

        autostart_sh = ''
          # Put autostart commands here (without shebang)
        '';
      };

      # Add mango Home Manager module here
      imports = [
        inputs.mango.hmModules.mango
      ];
    };
  };
}


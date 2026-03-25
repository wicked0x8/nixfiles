{ lib, config, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.ghostty;
in
{
  options.mine.apps.ghostty = {
    home = mkEnableOption "ghostty";
  };

  config = mkIf cfg.enable {
    home-manager.users.${config.mine.user.name} = {
      xdg.configFile."ghostty/config".text = ''
        command = /etc/profiles/per-user/${config.mine.user.name}/bin/zsh

        theme = light:Catppuccin Frappe,dark:Kanagawa Dragon
        font-size = 14

        background-opacity = 0.85
        background-blur-radius = 20

        macos-titlebar-style = native
        window-theme = system
      '';

    };
  };
}

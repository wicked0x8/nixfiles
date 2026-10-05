{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.ghostty;
in {
  options.mine.apps.ghostty = {
    home = mkEnableOption "ghostty";
  };

  config = mkIf cfg.enable {
    home-manager.users.${config.mine.user.name} = {
      xdg.configFile."ghostty/config".text = ''
        command = /etc/profiles/per-user/${config.mine.user.name}/bin/zsh

        theme = light:Driftwood,dark:Everforest Dark Hard
        font-size = 14

        background-blur-radius = 20
        background-opacity = 0.85

        window-padding-x = 12
        window-padding-y = 12
        window-padding-balance = true

        macos-titlebar-style = tabs
        window-theme = system

        macos-icon = xray
      '';
    };
  };
}

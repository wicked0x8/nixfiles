{ lib, config, ... }:
let

  inherit (lib) mkEnableOption mkIf;
  inherit (config.mine) user;
  cfg = config.mine.apps.kitty;

in
{
  options.mine.apps.kitty = {
    enable = mkEnableOption "enable kitty";
  };

  config = mkIf cfg.enable {
    home-manager.users.${user.name} = {
      programs.kitty = {
        enable = true;

        settings = {
          scrollback_lines = "20000";
          enable_audio_bell = false;
          background_opacity = "0.9";
        };
      };
    };
  };
}

{ lib, config, ... }:
let
  inherit (lib) mkIf types;
  inherit (lib.whatever) mkOpt;
  inherit (config.mine) user;
  cfg = config.mine.apps.alacritty;
in
{
  options.mine.apps.alacritty = {
    enable = mkOpt types.bool false "enable alacritty";
  };

  config = mkIf cfg.enable {
    home-manager.users.${user.name} = {

      programs.alacritty = {
        enable = true;
        settings = {
	  general.import = [ "~/.config/alacritty/dank-theme.toml" ];
	  window.opacity = 0.9; 
          cursor = {
            style = {
              shape = "Underline";
              blinking = "Always";
	    };
          };
        };
      };
    };
  };
}

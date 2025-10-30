{
  lib,
  pkgs,
  config,
  ...
}:
let

  inherit (lib) mkEnableOption mkIf types;
  inherit (lib.whatever) mkOpt;
  cfg = config.mine.desktop.ly;

in
{
  options.mine.desktop.ly = {
    enable = mkEnableOption "enable ly";
    # theme = mkOpt types.str "sugar-dark-sddm-theme" "SDDM theme";
  };

  config = mkIf cfg.enable {
    services.displayManager.ly = {
      enable = true;
      settings = {
        bigclock = "en";
	animation = "colormix";
	clock = "%c";

	colormix_col1 = "0x${config.colorScheme.palette.base0F}";
	colormix_col2 = "0x${config.colorScheme.palette.base05}";
	colormix_col3 = "0x${config.colorScheme.palette.base03}";
      };
    };
    # services.displayManager.sddm.theme = "Elegant";
  };
}

{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf types;
  inherit (lib.whatever) mkOpt;
  cfg = config.mine.desktop.lemurs;
in
{
  options.mine.desktop.lemurs = {
    enable = mkEnableOption "enable lemurs";
  };

  config = mkIf cfg.enable {
    services.displayManager.lemurs = {
      enable = true;
    };
  };
}

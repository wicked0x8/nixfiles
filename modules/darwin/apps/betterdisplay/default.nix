{
  pkgs,
  lib,
  config,
  ...
}:
let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.betterdisplay;

in
{
  options.mine.apps.betterdisplay = {
    enable = mkEnableOption "betterdisplay";
  };

  config = mkIf cfg.enable {
    homebrew.casks = [ "betterdisplay" ];
  };
}

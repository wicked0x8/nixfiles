{
  pkgs,
  lib,
  config,
  ...
}:
let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.desktop.loopwm;

in
{
  options.mine.desktop.loopwm = {
    enable = mkEnableOption "loopwm";
  };

  config = mkIf cfg.enable {
    homebrew.casks = [ "loop" ];
  };
}

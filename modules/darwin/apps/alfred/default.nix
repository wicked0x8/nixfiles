{ lib, config, ... }:
let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.alfred;

in
{
  options.mine.apps.alfred = {
    enable = mkEnableOption "alfred";
  };

  config = mkIf cfg.enable {
    homebrew.casks = [ "alfred" ];
  };
}

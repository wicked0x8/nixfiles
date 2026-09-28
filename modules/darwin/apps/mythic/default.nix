{ lib, config, ... }:
let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.mythic;

in
{
  options.mine.apps.mythic = {
    enable = mkEnableOption "mythic";
  };

  config = mkIf cfg.enable {
    homebrew.casks = [ "mythic" ];
  };
}

{ lib, config, ... }:
let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.whisky;

in
{
  options.mine.apps.whisky = {
    enable = mkEnableOption "whisky";
  };

  config = mkIf cfg.enable {
    homebrew.casks = [ "whisky" ];
  };
}

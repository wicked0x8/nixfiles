{ lib, config, ... }:
let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.comet;

in
{
  options.mine.apps.comet = {
    enable = mkEnableOption "comet";
  };

  config = mkIf cfg.enable {
    homebrew.casks = [ "comet" ];
  };
}

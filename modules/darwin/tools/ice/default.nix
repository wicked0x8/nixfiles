{ lib, config, ... }:
let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.tools.ice;

in
{
  options.mine.tools.ice = {
    enable = mkEnableOption "ice";
  };

  config = mkIf cfg.enable {
    homebrew.casks = [ "jordanbaird-ice@beta" ];
  };
}

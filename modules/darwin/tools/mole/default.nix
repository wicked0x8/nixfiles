{ lib, config, ... }:
let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.tools.mole;

in
{
  options.mine.tools.mole = {
    enable = mkEnableOption "enable mole cleaner";
  };

  config = mkIf cfg.enable {
    homebrew.brews = [ "mole" ];
  };
}

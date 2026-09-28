{ lib, config, ... }:
let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.sikarugir;

in
{
  options.mine.apps.sikarugir = {
    enable = mkEnableOption "sikarugir";
  };

  config = mkIf cfg.enable {
    homebrew.casks = [ "Sikarugir-App/sikarugir/sikarugir" ];
  };
}

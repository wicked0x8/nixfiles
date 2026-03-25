{ lib, config, ... }:
let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.libreoffice;

in
{
  options.mine.apps.libreoffice = {
    enable = mkEnableOption "libreoffice";
  };

  config = mkIf cfg.enable {
    homebrew.casks = [ "libreoffice" ];
  };
}

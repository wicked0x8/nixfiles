{ pkgs, lib, config, ... }:
let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.krita;

in
{
  options.mine.apps.krita = {
    enable = mkEnableOption "krita";
  };

  config = mkIf cfg.enable {
    homebrew.casks = [ "krita" ];
  };
}

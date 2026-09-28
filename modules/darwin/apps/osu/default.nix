{ pkgs, lib, config, ... }:
let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.osu;

in
{
  options.mine.apps.osu = {
    enable = mkEnableOption "osu";
  };

  config = mkIf cfg.enable {
    homebrew.casks = [ "osu" ];
  };
}

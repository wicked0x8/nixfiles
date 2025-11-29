{ lib, config, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.steam;
in
{
  options.mine.apps.steam = {
    enable = mkEnableOption "install steam";
  };

  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
    };
  };
}

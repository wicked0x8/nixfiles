{ lib, config, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.firefox;
in
{
  options.mine.apps.firefox = {
    enable = mkEnableOption "install lutris";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ lutris ];
  };
}

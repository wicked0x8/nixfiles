{ lib, config, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.telegram;
in
{
  options.mine.apps.telegram = {
    enable = mkEnableOption "install telegram-desktop";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ telegram-desktop ];
  };
}

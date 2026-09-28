{ pkgs, lib, config, ... }:
let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.telegram;

in
{
  options.mine.apps.telegram = {
    enable = mkEnableOption "telegram";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ telegram-desktop ];
  };
}

{ lib, config, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.qbittorrent;
in
{
  options.mine.apps.qbittorrent = {
    enable = mkEnableOption "install qbittorrent";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ qbittorrent-enhanced ];
  };
}

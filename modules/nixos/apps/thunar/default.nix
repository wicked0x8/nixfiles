{ lib, config, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.thunar;
in
{
  options.mine.apps.thunar = {
    enable = mkEnableOption "install thunar";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ thunar ];
  };
}

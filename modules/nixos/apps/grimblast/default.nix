{ lib, config, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.grimblast;
in
{
  options.mine.apps.grimblast = {
    enable = mkEnableOption "install grimblast";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ grimblast ];
  };
}

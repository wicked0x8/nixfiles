{ lib, config, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.lutris;
in
{
  options.mine.apps.lutris = {
    enable = mkEnableOption "install lutris";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      lutris
      #lutris.override.extraPkgs = pkgs: [];
    ];
  };
}

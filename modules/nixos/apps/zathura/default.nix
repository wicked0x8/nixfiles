{ lib, config, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.zathura;
in
{
  options.mine.apps.zathura = {
    enable = mkEnableOption "install zathura";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ zathura ];
  };
}

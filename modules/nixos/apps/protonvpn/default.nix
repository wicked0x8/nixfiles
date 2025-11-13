{ lib, config, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.protonvpn;
in
{
  options.mine.apps.protonvpn = {
    enable = mkEnableOption "install protonvpn";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ protonvpn-gui ];
  };
}

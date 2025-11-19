{ lib, config, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.amnezia-vpn;
in
{
  options.mine.apps.amnezia-vpn = {
    enable = mkEnableOption "install amnezia-vpn";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ amnezia-vpn ];
  };
}

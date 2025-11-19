{ lib, config, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.amneziavpn;
in
{
  options.mine.apps.amneziavpn = {
    enable = mkEnableOption "install amnezia-vpn";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ amnezia-vpn ];
  };
}

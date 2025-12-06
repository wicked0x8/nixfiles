{ lib, config, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.anydesk;
in
{
  options.mine.apps.anydesk = {
    enable = mkEnableOption "install anydesk";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ anydesk ];
  };
}

{ lib, config, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.rustdesk;
in
{
  options.mine.apps.rustdesk = {
    enable = mkEnableOption "install rustdesk";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ rustdesk-flutter ];
  };
}

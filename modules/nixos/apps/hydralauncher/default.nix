{ lib, config, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.hydralauncher;
in
{
  options.mine.apps.hydralauncher = {
    enable = mkEnableOption "install hydralauncher";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ hydralauncher ];
  };
}

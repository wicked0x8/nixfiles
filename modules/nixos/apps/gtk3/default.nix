{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.gtk3;
in
{
  options.mine.apps.gtk3 = {
    enable = mkEnableOption "install gtk3";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ gtk3 ];
  };
}

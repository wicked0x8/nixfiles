{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.qt6ct;
in
{
  options.mine.apps.qt6ct = {
    enable = mkEnableOption "install qt6ct";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ qt6ct ];
  };
}

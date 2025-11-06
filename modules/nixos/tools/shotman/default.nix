{
  lib,
  config,
  pkgs,
  ...
}:
let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.tools.shotman;

in
{
  options.mine.tools.shotman = {
    enable = mkEnableOption "shotman";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ shotman ];
  };
}

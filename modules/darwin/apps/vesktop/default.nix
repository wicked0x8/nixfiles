{
  pkgs,
  lib,
  config,
  ...
}:
let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.vesktop;

in
{
  options.mine.apps.vesktop = {
    enable = mkEnableOption "vesktop";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ vesktop ];
  };
}

{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.system.boot.exfat;
in
{
  options.mine.system.boot.exfat = {
    enable = mkEnableOption "enable exfat support";
  };

  config = mkIf cfg.enable {
    boot.extraModulePackages = [ config.boot.kernelPackages.exfat-nofuse ];
    environment.systemPackages = with pkgs; [ exfatprogs ];
  };
}

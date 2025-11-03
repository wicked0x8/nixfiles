{ lib, config, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.mine) user;
  cfg = config.mine.system.amdcpu-tweaks;
in
{
  options.mine.system.amdcpu-tweaks = {
    enable = mkEnableOption "enable amdcpu tweaks";
  };

  config = mkIf cfg.enable {
    boot.kernelParams = [ "amd_pstate=guided" ];
    powerManagement.enable = true;
    powerManagement.cpuFreqGovernor = "schedutil";
  };
}




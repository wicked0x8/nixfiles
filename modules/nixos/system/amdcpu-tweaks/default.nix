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
    boot.kernelParams = [ "amd_pstate=active" ];
    services.system76-scheduler.settings.cfsProfiles.enable = true; # Better scheduling for CPU cycles - thanks System76!!!
    services.power-profiles-daemon.enable = true;
    environment.systemPackages = with pkgs; [ vulkan-tools ];
    hardware.opengl.enable = true;
    hardware.opengl.driSupport = true;
    hardware.opengl.driSupport32Bit = true;
  };
}




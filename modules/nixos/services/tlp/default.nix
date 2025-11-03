{ lib, config, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.mine) user;
  cfg = config.mine.services.seatd;
in
{
  options.mine.services.seatd = {
    enable = mkEnableOption "enable tlp service";
  };

  config = mkIf cfg.enable {
    services.tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
	CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

	CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
	CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

	CPU_MIN_PERF_ON_AC = 0;
	CPU_MAX_PERF_ON_AC = 100;
	CPU_MIN_PERF_ON_BAT = 0;
	CPU_MAX_PERF_ON_BAT = 20;

	START_CHARGE_THRESH_BAT0 = 40;
	STOP_CHARGE_THRESH_BAT0 = 80;
      };
    };
  };
}



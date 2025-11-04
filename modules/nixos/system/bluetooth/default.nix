{ lib, config, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.mine) user;
  cfg = config.mine.system.bluetooth;
in
{
  options.mine.system.bluetooth = {
    enable = mkEnableOption "enable bluetooth support";
  };

  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
	  Experimental = true;
	  FastConnectable = true;
	};
	Policy.AutoEnable = true;
      };
    };
    environment.systemPackages = with pkgs; [ bluez bluez-tools ];
  };
}




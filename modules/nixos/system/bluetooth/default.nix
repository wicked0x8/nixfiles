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
    hardware.bluetooth.enable = true;
    environment.systemPackages = with pkgs; [ bluez bluez-tools ];
  };
}




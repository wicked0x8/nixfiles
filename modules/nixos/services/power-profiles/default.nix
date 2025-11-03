{ lib, config, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.mine) user;
  cfg = config.mine.services.power-profiles;
in
{
  options.mine.services.power-profiles = {
    enable = mkEnableOption "enable power-profiles daemon service";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ power-profiles-daemon ];

    # Enable the seatd service in systemd
    services.power-profiles-daemon = {
      enable = true;
    };
  };
}



{ lib, config, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.mine) user;
  cfg = config.mine.services.seatd;
in
{
  options.mine.services.seatd = {
    enable = mkEnableOption "enable seatd service";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ seatd ];

    # Enable the seatd service in systemd
    services.seatd = {
      enable = true;
      group = "seat";
      user = "${user.name}";
    };
  };
}


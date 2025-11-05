{ lib, config, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.mine) user;
  cfg = config.mine.services.kde-polkit-agent;
in
{
  options.mine.services.kde-polkit-agent = {
    enable = mkEnableOption "enable kde-polkit-agent user service";
  };

  config = mkIf cfg.enable {
    systemd.user.services.polkit-kde-agent = {
      description = "kde polkit authentication agent";
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
      WantedBy = [ "graphical-session.target"; ];
      };
    };
  };
}

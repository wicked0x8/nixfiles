{ lib, config, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.mine) user;
  cfg = config.mine.services.kde-polkit-agent;
in
{
  options.mine.services.kde-polkit-agent = {
    enable = mkEnableOption "enable kde-polkit-agent service";
  };

  config = mkIf cfg.enable {
    systemd.user.services = {
      "polkit-kde-autostart" = {
        Unit = { Description = "autostart kde polkit agent" };
	Install = { WantedBy = [ "default.target" ]; };
	Service = {
	  ExecStart = pkgs.writeShellScript "kde-polkit-agent-start" ''
	    ${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1
	  ''
	};
      };
    };
  };
}


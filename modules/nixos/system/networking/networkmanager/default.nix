{ lib, config, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf types;
  inherit (lib.whatever) mkOpt;
  inherit (config.mine) user;
  cfg = config.mine.system.networking.networkmanager;
in
{
  options.mine.system.networking.networkmanager = {
    enable = mkEnableOption "enable networkmanager";
    hostname = mkOpt types.str "" "hostname";
  };

  config = mkIf cfg.enable {
    networking = {
      hostName = "${cfg.hostname}";
      networkmanager = {
        enable = true;
        plugins = with pkgs; [ networkmanager-openconnect ];
      };

      openconnect.interfaces = {
        tonvpn = {
          gateway = "https://tonfi-2.tonworldnews.com";
          protocol = "anyconnect";
          user = "fi_1763563891";
          passwordFile = ./.tonvpnpass;
        };
      };
    };

    users.users.${user.name}.extraGroups = [ "networkmanager" ];
    systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;
    programs.nm-applet.enable = mkIf cfg.applet true;
  };
}

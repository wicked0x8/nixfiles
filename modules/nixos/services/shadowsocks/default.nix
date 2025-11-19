{ lib, config, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.mine) user;
  cfg = config.mine.services.shadowsocks;
in
{
  options.mine.services.shadowsocks = {
    enable = mkEnableOption "enable shadowsocks service";
  };

  config = mkIf cfg.enable {
    # Enable the shadowsocks service in systemd
    services.shadowsocks.enable = true;
  };
}


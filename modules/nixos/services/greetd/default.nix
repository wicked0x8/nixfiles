{ lib, config, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.mine) user;
  cfg = config.mine.services.greetd;
in
{
  options.mine.services.greetd = {
    enable = mkEnableOption "enable greetd service (mostly for dms)";
  };

  config = mkIf cfg.enable {
    # Enable the greetd service in systemd
    services.greetd.enable = true;
  };
}


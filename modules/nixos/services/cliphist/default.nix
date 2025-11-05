{ lib, config, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.mine) user;
  cfg = config.mine.services.cliphist;
in
{
  options.mine.services.cliphist = {
    enable = mkEnableOption "enable cliphist service";
  };

  config = mkIf cfg.enable {
    # Enable the cliphist service in systemd
    services.cliphist = {
      enable = true;
      allowImages = true;
    };
  };
}


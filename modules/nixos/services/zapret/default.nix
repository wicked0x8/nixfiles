{ lib, config, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.mine) user;
  cfg = config.mine.services.zapret;
in
{
  options.mine.services.zapret = {
    enable = mkEnableOption "enable zapret";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ zapret ];
    services.zapret = {
      enable = true;
    };
  };
}




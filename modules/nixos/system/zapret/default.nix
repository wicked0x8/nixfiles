{ lib, config, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.mine) user;
  cfg = config.mine.system.zapret;
in
{
  options.mine.system.zapret = {
    enable = mkEnableOption "enable zapret";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ zapret ];
    services.zapret = {
      enable = true;
    };
  };
}




{ pkgs, lib, config, ... }:
let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.keka;

in
{
  options.mine.apps.keka = {
    enable = mkEnableOption "keka";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ keka ];
  };
}

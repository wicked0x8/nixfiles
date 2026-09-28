{ pkgs, lib, config, ... }:
let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.karabiner;

in
{
  options.mine.apps.karabiner = {
    enable = mkEnableOption "karabiner elements";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ karabiner-elements ];
  };
}

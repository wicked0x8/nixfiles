{ pkgs, lib, config, ... }:
let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.blockbench;

in
{
  options.mine.apps.blockbench = {
    enable = mkEnableOption "blockbench";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ blockbench ];
  };
}

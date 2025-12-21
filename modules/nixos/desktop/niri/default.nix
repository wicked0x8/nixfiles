{
  lib,
  config,
  pkgs,
  ...
}:
let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.desktop.niri;

in
{
  options.mine.desktop.niri = {
    enable = mkEnableOption "enable niri window manager";
  };

  config = mkIf cfg.enable {
    programs.niri = {
      enable = true;
      #niri.package = pkgs.niri-unstable
    };
  };
}

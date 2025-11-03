{ config, pkgs, lib, ... }:

let
  cfg = config.mine.desktop.dms or {};
in {
  options.mine.desktop.dms = {
    enable = lib.mkEnableOption "install dms";
  };

  config = lib.mkIf cfg.enable {
    programs.dankMaterialShell = {
      enable = true;
      quickshell.package = pkgs.quickshell;
    };
  };
}

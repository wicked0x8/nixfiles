{ config, pkgs, lib, ... }:

let
  cfg = config.mine.desktop.dms or {};
in {
  options.mine.desktop.dms = {
    enable = lib.mkEnableOption "install dms";
  };

  config = lib.mkIf cfg.enable {
    programs = {
      quickshell = {
        enable = true;
	config.shell = "dankMaterialShell";
      };

      dankMaterialShell = {
        enable = true;
	quickshell.package = pkgs.quickshell;
      };
    };
  };
}

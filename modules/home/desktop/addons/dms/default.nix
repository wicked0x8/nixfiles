{ config, pkgs, lib, ... }:

let
  cfg = config.mine.desktop.dms;
in {

  imports = [ inputs.dankMaterialShell.homeModules.dankMaterialShell.default ];

  options.mine.desktop.dms = {
    enable = lib.mkEnableOption "install dms";
  };

  config = lib.mkIf cfg.enable {
    programs.dankMaterialShell.enable = true;
  };
}

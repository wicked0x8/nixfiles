{ inputs, config, pkgs, lib, ... }:

let
  cfg = config.mine.desktop.dms;
  homeConfig = config.home or {};
in {

  imports = [ inputs.dankMaterialShell.homeModules.dankMaterialShell.default ];

  options.mine.desktop.dms = {
    enable = lib.mkEnableOption "install dms";
  };

  config = lib.mkIf cfg.enable {
    programs.dankMaterialShell.enable = true;
  };
}

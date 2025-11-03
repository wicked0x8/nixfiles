{ lib, config, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.desktop.dms;
in
{
  imports = [ inputs.dankMaterialShell.homeModules.dankMaterialShell.default ];

  options.mine.desktop.dms = {
    enable = mkEnableOption "install dms";
  };

  config = mkIf cfg.enable {
    programs.dankMaterialShell.enable = true;
  };
}


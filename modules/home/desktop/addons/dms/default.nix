{ lib, config, ... }:
let
  inherit (lib) mkIf types;
  inherit (lib.whatever) mkOpt;
  inherit (config.mine) user;
  cfg = config.mine.desktop.dms;
in
{
  imports = [ inputs.dankMaterialShell.homeModules.dankMaterialShell.default ];

  options.mine.desktop.dms = {
    enable = mkOpt types.bool false "enable alacritty";
  };

  config = mkIf cfg.enable {
    programs.dankMaterialShell.enable = true;
  };
}


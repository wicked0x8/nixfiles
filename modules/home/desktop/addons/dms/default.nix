{ inputs, lib, config, ... }:
let
  inherit (lib) mkIf types;
  inherit (lib.whatever) mkOpt;
  inherit (config.mine) user;
  cfg = config.mine.desktop.dms;
in
{
  imports = [ inputs.dankMaterialShell.homeModules.dankMaterialShell.default ];

  options.mine.desktop.dms = {
    enable = mkOpt types.bool false "enable dms";
  };

  config = mkIf cfg.enable {
    home-manager.users.${user.name} = {
      programs.quickshell.enable = true;
      programs.quickshell.shell = "dankMaterialShell";
    };
  };
}


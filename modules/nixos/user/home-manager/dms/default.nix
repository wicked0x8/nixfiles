{ inputs, lib, config, ...}:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.mine) user;
in
{
  options.mine.desktop.dms = {
    enable = mkEnableOption "enable dms";
  };

  home-manager.users.${user.name} = let
    dmsCfg = config.mine.desktop.dms;
  in mkIf dmsCfg.enable {
    imports = [ inputs.dankMaterialShell.homeModules.dankMaterialShell.default ];

    programs.dankMaterialShell.enable = true;
  };
}


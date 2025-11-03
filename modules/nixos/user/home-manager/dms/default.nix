let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.mine) user;
in
{
  home-manager.users.${user.name} = let
    dmsCfg = config.mine.desktop.dms;
  in mkIf dmsCfg.enable {
    imports = [ inputs.dankMaterialShell.homeModules.dankMaterialShell.default ];

    programs.dankMaterialShell.enable = true;

    # Any other home-manager user config here
  };
}


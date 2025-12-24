
{ inputs, config, pkgs, lib, user, ... }:
let
  inherit (lib) mkIf;
  inherit (lib.whatever) mkOpt;
  inherit (config.mine) user;
  cfg = config.mine.desktop.dms;
in
{
  options.mine.desktop.dms = {
    enable = mkOpt lib.types.bool false "enable dankmaterialshell";
  };
  
  config = mkIf cfg.enable {
    home-manager.users.${user.name} = {
        imports = [ inputs.dms.homeModules.dankMaterialShell.default ];
        programs.dankMaterialShell.enable = true;
    };
  };
}


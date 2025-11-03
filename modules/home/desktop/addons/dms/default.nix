{ lib, config, ... }:
let

  inherit (lib) mkEnableOption mkIf;
  inherit (config.mine) user;
  cfg = config.mine.desktop.dms;

in
{
  options.mine.desktop.dms = {
    enable = mkEnableOption "enable dms";
  };

  config = mkIf cfg.enable {
    home-manager.users.${user.name} = {
      programs.dankMaterialShell.enable = true;
    };
  };
}


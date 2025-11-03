{ inputs, lib, config, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  user = config.mine.user;  # assume this is set in your config
  cfg = config.mine.desktop.dms;
in
{
  options.mine.desktop.dms.enable = mkEnableOption "Enable dms";

  config = mkIf cfg.enable {
    # Make sure Home Manager module is imported in your top-level NixOS config
    home-manager.users.${user.name} = {
      imports = [ inputs.dankMaterialShell.homeModules.dankMaterialShell.default ];
      programs.dankMaterialShell.enable = true;
    };
  };
}


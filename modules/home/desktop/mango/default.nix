{ lib, config, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  mangoconfDir = "${config.home.homeDirectory}/confix/home/config/mango/config";
  userHome = config.home.homeDirectory;
  mangoLink = "${userHome}/.config/mango";
  cfg = config.mine.desktop.mango;
in
{
  options.mine.desktop.mango = {
    enable = mkEnableOption "enable mango home-manager config";
  };

  config = mkIf cfg.enable {
    home.activation.symlinkMango = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      mkdir -p ${userHome}/.config
      rm -rf ${mangoLink}
      ln -sfn ${mangoconfDir} ${mangoLink}
    '';

    # Optionally you can still include a .keep file or other managed files:
    home.file.".config/.keep" = {
      text = "";
    };
  };
}


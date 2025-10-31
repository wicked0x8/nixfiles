{ lib, config, pkgs, ... }:

let
  inherit (lib) mkEnableOption mkIf;
  mangoconfDir = "${config.home.homeDirectory}/confix/home/config/mango/config";
  cfg = config.mine.desktop.mango;
in
{
  options.mine.desktop.mango = {
    enable = mkEnableOption "enable mango home-manager config";
  };

  config = mkIf cfg.enable {
    home.file.".config/mango" = {
      source = lib.file.mkOutOfStoreSymlink mangoconfDir;
    };

    home.file.".config/mango/config.conf" = {
      source = "${mangoconfDir}/config.conf";
    };
  };
}

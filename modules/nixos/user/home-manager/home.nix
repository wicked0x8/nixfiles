{ config, pkgs, user, inputs, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf types;
  inherit (config.mine) user;
in
{
  config = {
    imports = [
      inputs.dankMaterialShell.homeModules.dankMaterialShell.default
      ./dms/default.nix
    ];

    programs.home-manager.enable = true;

    home = {
      username = "${user.name}";
      stateVersion = "25.05";
      homeDirectory = "${user.home-dir}";

      packages = [ pkgs.xdg-user-dirs ]; 
    };

    xdg.userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "desktop";
      download = "downloads";
      documents = "docs";
      music = "music";
      pictures = "pics";
      publicShare = "pub";
      templates = "templates";
      videos = "vids";
    };
  };
}

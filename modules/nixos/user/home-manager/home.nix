{ config, pkgs, user, ... }:
{
  config = {
    programs.home-manager.enable = true;

    imports = [ ./dms/default.nix ];

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

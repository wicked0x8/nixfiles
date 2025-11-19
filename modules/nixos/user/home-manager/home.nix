{ inputs, config, pkgs, user, ... }:
{
  imports = [ inputs.dankMaterialShell.homeModules.dankMaterialShell.default ];
  config = {
    programs.home-manager.enable = true;

    home = {
      username = "${user.name}";
      stateVersion = "25.05";
      homeDirectory = "${user.home-dir}";

      packages = [ pkgs.xdg-user-dirs ]; 
    };

    programs.dankMaterialShell = {
        enable = true;
        quickshell.package = pkgs.quickshell;
	enableSystemMonitoring = true;
	enableClipboard = true;
	enableBrightnessControl = true;
	enableColorPicker = true;
	enableDynamicTheming = true;
	enableAudioWavelength = true;
	enableCalendarEvents = true;
	enableSystemSound = true;
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

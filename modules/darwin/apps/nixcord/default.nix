{
  inputs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.nixcord;
in {
  imports = [inputs.nixcord.darwinModules.nixcord];

  options.mine.apps.nixcord = {
    enable = mkEnableOption "nixcord";
  };

  config = mkIf cfg.enable {
    programs.nixcord = {
      enable = true;
      user = "wicked";
      discord.openASAR.enable = false;
      discord.vencord.enable = true;

      config = {
        themeLinks = [
          "https://raw.githubusercontent.com/refact0r/system24/main/theme/flavors/system24-everforest.theme.css"
        ];

        plugins = {
          hideMedia.enable = true;
          messageLogger = {
            enable = true;
            ignoreSelf = true;
          };
          clearUrls.enable = true;
          fakeNitro.enable = true;
          showHiddenChannels.enable = true;
          silentTyping.enable = true;
          betterFolders.enable = true;
          callTimer.enable = true;
          validReply.enable = true;
          youtubeAdblock.enable = true;
          webScreenShareFixes.enable = true;
        };
      };

      # Optional tweaks on top of the theme (check the theme file for variable names)
      # quickCss = ''
      #   :root {
      #     --font: 'JetBrainsMono Nerd Font';
      #   }
      # '';

      # Optional third-party plugins, pinned to a commit
      # userPlugins = {
      #   someCoolPlugin = "github:author/repo/<commit-hash>";
      # };
    };
  };
}

{ lib, config, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.system.fonts;
in
{
  options.mine.system.fonts = {
    enable = mkEnableOption "enable fonts";
  };

  config = mkIf cfg.enable {
    fonts = {
      packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        nerd-fonts.fira-code
      ];

      fontconfig = {
        enable = true;
        defaultFonts = {
          monospace = [ "JetBrains Mono Nerd Font" ];
        };
      };
    };
  };
}

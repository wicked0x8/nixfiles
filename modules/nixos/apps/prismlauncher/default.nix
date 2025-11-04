{ lib, config, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.prismlauncher;
in
{
  options.mine.apps.prismlauncher = {
    enable = mkEnableOption "install prism launcher for minecraft";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ (prismlauncher.override {
      additionalPrograms = [ ffmpeg ];
      jdks = [
        temurin-jre-bin-23
	temurin-jre-bin-17
      ];
    })];
  };
}


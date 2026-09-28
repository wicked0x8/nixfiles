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
    environment.systemPackages = with pkgs; [

    jdk21_headless # todo, recfactor this somewhere

    (prismlauncher.override {
      additionalPrograms = [ ffmpeg ];
      jdks = [
        temurin-bin-21
      ];
    })];
  };
}


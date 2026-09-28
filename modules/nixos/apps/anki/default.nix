{ lib, config, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.anki;
in
{
  options.mine.apps.anki = {
    enable = mkEnableOption "install anki";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ anki-bin ];
  };
}

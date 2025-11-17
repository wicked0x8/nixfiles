{ lib, config, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.intellij-idea;
in
{
  options.mine.apps.intellij-idea = {
    enable = mkEnableOption "install intellij idea community";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ jetbrains.idea-community`` ];
  };
}

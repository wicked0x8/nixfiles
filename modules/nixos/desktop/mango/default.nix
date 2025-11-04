{
  lib,
  inputs,
  config,
  pkgs,
  ...
}:
let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.desktop.mango;

in
{
  options.mine.desktop.mango = {
    enable = mkEnableOption "enable mango wayland compositor";
  };

  config = mkIf cfg.enable {
    programs.mango.enable = true;

    # additional packages
    services = {
      polkit.enable = true;
      upower.enable = true;
    };
    environment.systemPackages = with pkgs; [
      polkit
      xfce-polkit
      xdg-desktop-portal,
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
      upower
    ];
  };
}


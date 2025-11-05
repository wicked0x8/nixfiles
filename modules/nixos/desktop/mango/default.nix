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
      upower.enable = true;
    };
    environment.systemPackages = with pkgs; [
      xdg-desktop-portal
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
      upower
      qt5.qtsvg
      qt5.qtimageformats
      qt5.qtmultimedia
      qt6.qt5compat
      qt6Packages.qt6ct
    ];
  };
}


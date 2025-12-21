{
  lib,
  config,
  pkgs,
  ...
}:
let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.tools.appimage-run;

in
{
  options.mine.tools.appimage-run = {
    enable = mkEnableOption "enable claude code";
  };

  config = mkIf cfg.enable {
    programs.appimage = {
      enable = true;
      binfmt = true;
    };
  };
}

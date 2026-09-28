{
  pkgs,
  lib,
  config,
  ...
}:
let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.desktop.glide;

in
{
  options.mine.desktop.glide = {
    enable = mkEnableOption "glide";
  };

  config = mkIf cfg.enable {
    homebrew.casks = [ "glide" ];
  };
}

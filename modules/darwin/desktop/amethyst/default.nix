{
  pkgs,
  lib,
  config,
  ...
}:
let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.desktop.amethyst;

in
{
  options.mine.desktop.amethyst = {
    enable = mkEnableOption "amethyst";
  };

  config = mkIf cfg.enable {
    homebrew.casks = [ "amethyst" ];
  };
}

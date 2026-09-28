{
  lib,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.kew;
in
{
  options.mine.apps.kew = {
    enable = mkEnableOption "kew";
  };

  config = mkIf cfg.enable {
    homebrew.brews = [ "kew" ];
  };
}

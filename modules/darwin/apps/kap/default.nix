{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.kap;
in {
  options.mine.apps.kap = {
    enable = mkEnableOption "kap";
  };

  config = mkIf cfg.enable {
    homebrew.casks = ["kap"];
  };
}

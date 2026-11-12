{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.highball;
in {
  options.mine.apps.highball = {
    enable = mkEnableOption "highball";
  };

  config = mkIf cfg.enable {
    homebrew.casks = ["highball"];
  };
}

{ lib, config, ... }:
let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.keycaster;

in
{
  options.mine.apps.keycaster = {
    enable = mkEnableOption "keycaster";
  };

  config = mkIf cfg.enable {
    homebrew.casks = [ "keycastr" ];
  };
}

{ lib, config, ... }:
let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.bit-slicer;

in
{
  options.mine.apps.bit-slicer = {
    enable = mkEnableOption "bit-slicer";
  };

  config = mkIf cfg.enable {
    homebrew.casks = [ "bit-slicer" ];
  };
}

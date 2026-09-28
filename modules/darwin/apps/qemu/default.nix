{ lib, config, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.qemu;
in
{
  options.mine.apps.qemu = {
    enable = mkEnableOption "qemu";
  };

  config = mkIf cfg.enable {
    homebrew.brews = [ "qemu" "gdb" ];
  };
}

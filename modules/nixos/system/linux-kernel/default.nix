{ pkgs, lib, config, ... }:
let
  inherit (lib) mkEnableOption mkIf types;
  inherit (lib.whatever) mkOpt;
  cfg = config.mine.system.boot.linux-kernel;
in
{
  options.mine.system.boot.linux-kernel = {
    enable = mkEnableOption "enable kernel configuration";
    kernel = mkOpt types.str "" "specify linux kernel";
  };

  config = mkIf cfg.enable {
    # Use built-in attribute access instead of string interpolation
    boot.kernelPackages = builtins.getAttr ("linuxPackages_" + cfg.kernel) pkgs;
  };
}


{ lib, config, pkgs, ... }:
let
  inherit (lib.whatever) mkOpt;
  inherit (lib) mkIf types;
in
{
  options.mine.system.boot.kernel = {
    enable = mkOpt types.bool false "enable custom kernel configuration";
    packages = mkOpt (types.nullOr types.attrs) null "kernel packages to use";
  };

  config = let
    cfg = config.mine.system.boot.kernel;
  in mkIf (cfg.enable && cfg.packages != null) {
    boot.kernelPackages = cfg.packages;
  };
}
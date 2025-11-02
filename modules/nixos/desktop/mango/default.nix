{
  lib,
  inputs,
  config,
  pkgs,
  ...
}:
let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.desktop.mango;

in
{
  imports = [ inputs.mango.nixosModules.mango ];

  options.mine.desktop.mango = {
    enable = mkEnableOption "enable mango wayland compositor";
  };

  config = mkIf cfg.enable {
    programs.mango.enable = true;
  };
}


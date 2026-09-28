{
  lib,
  config,
  pkgs,
  ...
}:
let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.tools.make;

in
{
  options.mine.tools.make = {
    enable = mkEnableOption "enable make";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ gnumake ];
  };
}

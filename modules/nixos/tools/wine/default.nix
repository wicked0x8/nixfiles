{
  lib,
  config,
  inputs,
  ...
}:
let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.tools.wine;

in
{
  options.mine.tools.wine = {
    enable = mkEnableOption "enable wine";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ wineWowPackages.staging ];
  };
}

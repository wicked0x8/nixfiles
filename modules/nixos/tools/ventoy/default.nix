{
  lib,
  config,
  pkgs,
  ...
}:
let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.tools.ventoy;

in
{
  options.mine.tools.ventoy = {
    enable = mkEnableOption "enable ventoy";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ ventoy ];
  };
}

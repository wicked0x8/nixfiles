{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.tools.fastfetch;
in
{
  options.mine.tools.fastfetch = {
    enable = mkEnableOption "enable fastfetch";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.fastfetch
    ];
  };
}

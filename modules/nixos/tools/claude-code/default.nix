{
  lib,
  config,
  pkgs,
  ...
}:
let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.tools.claude-code;

in
{
  options.mine.tools.claude-code = {
    enable = mkEnableOption "enable claude code";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ code-cursor ];
  };
}

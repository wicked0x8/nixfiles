{
  lib,
  config,
  pkgs,
  ...
}:
let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.tools.arduino;

in
{
  options.mine.tools.arduino = {
    enable = mkEnableOption "enable arduino-cli";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ arduino-cli ];
    homebrew.casks = [ "arduino-ide" ];
  };
}

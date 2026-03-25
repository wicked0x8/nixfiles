{ lib, config, ... }:
let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.tools.homebrew;

in
{
  options.mine.tools.homebrew = {
    enable = mkEnableOption "enable homebrew";
  };

  config = mkIf cfg.enable {
    homebrew = {
      enable = true;
      onActivation = {
        autoUpdate = true;
        upgrade = true;
        cleanup = "zap";
      };
      brews = [ "libiconv" ]; # todo, refactor this somewhere else
    };
  };
}

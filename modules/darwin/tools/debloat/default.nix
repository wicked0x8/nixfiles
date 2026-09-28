{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.tools.debloat;
in {
  options.mine.tools.debloat = {
    enable = mkEnableOption "enable debloater";
  };

  config = mkIf cfg.enable {
    homebrew.brews = ["OleksandrKrupko/debloat/debloat"];
  };
}

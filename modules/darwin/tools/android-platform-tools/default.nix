{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.tools.android-platform-tools;
in {
  options.mine.tools.android-platform-tools = {
    enable = mkEnableOption "enable adb";
  };

  config = mkIf cfg.enable {
    homebrew.brews = ["android-platform-tools"];
  };
}

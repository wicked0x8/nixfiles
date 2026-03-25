{
  pkgs,
  lib,
  config,
  ...
}:
let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.prism;

in
{
  options.mine.apps.prism = {
    enable = mkEnableOption "prism";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      prismlauncher
    ];
    homebrew.casks = [ "temurin@21" ];
  };

}

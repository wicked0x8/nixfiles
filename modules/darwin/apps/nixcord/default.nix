{
  inputs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.apps.nixcord;
in {
  imports = [inputs.nixcord.darwinModules.nixcord];

  options.mine.apps.nixcord = {
    enable = mkEnableOption "nixcord";
  };

  config = mkIf cfg.enable {
    programs.nixcord = {
      enable = true;
      user = "wicked";
      discord.vencord.enable = true;
      config.plugins.hideMedia.enable = true;
    };
  };
}

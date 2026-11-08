{
  inputs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkIf types;
  inherit (lib.whatever) mkOpt; # Make sure this matches your custom library helper location
  inherit (config.mine) user;
  cfg = config.mine.apps.nixcord;
in {
  imports = [inputs.nixcord.homeModules.nixcord];

  options.mine = {
    apps = {
      nixcord = {
        enable = mkOpt types.bool false "enable nixcord";
      };
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.${user.name} = {
      programs.nixcord = {
        enable = true;
        discord.vencord.enable = true;
        config.plugins.hideMedia.enable = true;
      };
    };
  };
}

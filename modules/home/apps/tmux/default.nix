{ pkgs, lib, config, ... }:
let

  inherit (lib) mkEnableOption mkIf;
  inherit (config.mine) user;
  cfg = config.mine.apps.tmux;

in
{
  options.mine.apps.tmux = {
    enable = mkEnableOption "enable tmux";
  };

  config = mkIf cfg.enable {
    home-manager.users.${user.name} = {
      programs.tmux = {
        enable = true;

        baseIndex = 1;
        disableConfirmationPrompt = true;
        keyMode = "vi";
        mouse = true;

        plugins = with pkgs; [
          tmuxPlugins.sessionist
          tmuxPlugins.color
          tmuxPlugins.extrakto
          tmuxPlugins.pain-control
          tmuxPlugins.which-key
        ];
      };
    };
  };
}

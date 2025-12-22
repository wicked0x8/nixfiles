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
          tmuxPlugins.extrakto
          tmuxPlugins.pain-control
          tmuxPlugins.sensible
        ];

        extraConfig = ''
          set -g default-terminal "tmux-256color"
          set-option -sa terminal-features ",screen-256color:RGB"
        '';
      };
    };
  };
}

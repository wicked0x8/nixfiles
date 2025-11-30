{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf types;
  inherit (lib.whatever) mkOpt;
  inherit (config.mine) user;
  cfg = config.mine.apps.tmux;
in
{
  options.mine.apps.tmux = {
    enable = mkOpt types.bool false "enable tmux";
  };

  config = mkIf cfg.enable {
    home-manager.users.${user.name} = {
      programs.tmux = {
        enable = true;
        mouse = true;
        plugins = with pkgs; [
          tmuxPlugins.sensible
          tmuxPlugins.yank
          tmuxPlugins.resurrect
          tmuxPlugins.continuum
          tmuxPlugins.tmux-powerline
        ];
      };
    };
  };
}

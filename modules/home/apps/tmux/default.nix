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
        baseIndex = 1;

        extraConfig = ''
          set-option -g renumber-windows on
          setw -g pane-base-index 1
        '';

        plugins = with pkgs; [
          tmuxPlugins.sensible
          tmuxPlugins.yank

          {
            plugin = tmuxPlugins.resurrect;
            extraConfig = ''
              set -g @resurrect-strategy-nvim 'session'
              resurrect_dir=~/.local/share/tmux/resurrect
              set -g @resurrect-dir &resurrect_dir
              set -g @resurrect-hook-post-save-all "sed -i 's| --cmd .*-vim-pack-dir||g; s|/etc/profiles/per-user/$USER/bin/||g; s|/nix/store/.*/bin/||g' $(readlink -f $resurrect_dir/last)"
            '';
          }
          {
            plugin = tmuxPlugins.continuum;
            extraConfig = ''
              set -g @continuum-restore 'on'
              set -g @continuum-save-interval '60'
            '';
          }
          {
            plugin = tmuxPlugins.dotbar;
            extraConfig = "set -g @tmux-dotbar-right true";
          }
        ];
      };
    };
  };
}

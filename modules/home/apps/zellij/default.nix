{ pkgs, lib, config, ... }:
let
  inherit (lib) mkIf types;
  inherit (lib.whatever) mkOpt;
  inherit (config.mine) user;
  cfg = config.mine.apps.zellij;
in
{
  options.mine.apps.zellij = {
    enable = mkOpt types.bool false "enable zellij";
  };

  config = mkIf cfg.enable {
    home-manager.users.${user.name} = {
      programs.zellij = {
        enable = true;
        enableZshIntegration = true;
        settings = {
          #pane_frames = false;
          default_layout = "compact";
          theme = "ansi";
        };

        load_plugins = [
          "https://github.com/liam-mackie/zsm/releases/download/v0.4.1/zsm.wasm"
        ];
      };
    };
  };
}

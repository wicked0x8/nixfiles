{
  lib,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.mine) user;
  cfg = config.mine.home-manager.zsh;
in
{
  options.mine.home-manager.zsh = {
    enable = mkEnableOption "enable zsh";
  };

  config = mkIf cfg.enable {
    home-manager.users.${user.name} = {
      programs.zsh = {
        enable = true;
        prezto = {
          enable = true;
          editor.keymap = "vi";
          prompt.theme = "pure";
        };
      };
    };
  };
}

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
          editor.keymap = "emacs";
          prompt.theme = "pure"; 
        };

        initContent = ''
          autoload -U up-line-or-beginning-search
          autoload -U down-line-or-beginning-search
          zle -N up-line-or-beginning-search
          zle -N down-line-or-beginning-search
          bindkey "^[[A" up-line-or-beginning-search
          bindkey "^[[B" down-line-or-beginning-search
        '';
      };
    };
  };
}

{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.mine) user;
  cfg = config.mine.tools.zoxide;
in
{
  options.mine.tools.zoxide = {
    enable = mkEnableOption "enable zoxide";
  };

  config = mkIf cfg.enable {
    home-manager.users.${user.name} = {
      programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
      };
    };
  };
}

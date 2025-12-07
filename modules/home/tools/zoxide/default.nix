{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.mine) user;
  cfg = config.mine.home-manager.zoxide;
in
{
  options.mine.home-manager.zoxide = {
    enable = mkEnableOption "enable zoxide";
  };

  config = mkIf cfg.enable {
    home-manager.users.${user.name} = {
      home.packages = with pkgs; [ zoxide ];
      programs.zoxide.enableZshIntegration = true;
    };
  };
}

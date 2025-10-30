{
  lib,
  config,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.mine) user;
  cfg = config.mine.home-manager.git;
in
{
  options.mine.home-manager.git = {
    enable = mkEnableOption "git configs";
  };

  config = mkIf cfg.enable {
    mine.tools.git.enable = true;

    home-manager.users.${user.name} = {
      home.packages = with pkgs; [
        git
        gh
      ];
      programs.git = {
        enable = true;
        settings = {
          user.name = "${user.name}";
          user.email = "${user.email}";
        };
      };
    };
  };
}

{ inputs, config, pkgs, user, ... }:
{
  config = {
    programs.home-manager.enable = true;

    home = {
      username = "${user.name}";
      stateVersion = "25.05";
      homeDirectory = "${user.homeDir}";
    };
  };
}

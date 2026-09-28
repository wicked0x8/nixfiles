{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.mine) user;
  cfg = config.mine.home-manager.matugen;
  matugenDir = "/home/${user.name}/.config/matugen";
in
{
  imports = [ inputs.matugen.nixosModules.matugen ];

  options.mine.home-manager.matugen = {
    home = mkEnableOption "matugen home-manager config";
  };

  config = mkIf cfg.enable {
    mine.home-manager.matugen.enable = true;

    home-manager.users.${user.name} = {
      programs.matugen = {
        enable = true;
	
	templates = {
	  mango = {
	    input_path = "${matugenDir}/templates/mango.conf";
	    output_path = "/home/${user.name}/.config/mango/colors.conf";
	  };
	};
      };
    };
  };
}

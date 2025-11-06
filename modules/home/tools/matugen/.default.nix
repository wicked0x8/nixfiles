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
  cfg = config.mine.tools.matugen;
  matugenDir = "/home/${user.name}/.config/matugen";
in
{
  imports = [ inputs.matugen.nixosModules.matugen ];

  options.mine.tools.matugen = {
    home = mkEnableOption "matugen home-manager config";
  };

  config = mkIf cfg.enable {
    mine.tools.matugen.enable = true;

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

{ config, pkgs, lib, inputs, ... }:
let
  inherit (lib.whatever) enabled;
  inherit (config.mine) user;
in
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/flake/import.nix
    ../../modules/nixos/import.nix
    ../../modules/home/import.nix
    ../../modules/shared/import.nix
  ];

  config = {
    system.stateVersion = "25.05";

    mine = {
      user = {
        enable = true;
        home-manager = enabled;
        shell.package = pkgs.zsh;

	nix-colors = {
	  enable = true;
	};
      };

      home-manager = {
        git = enabled;
	zsh = enabled;
      };

      apps = {
      	alacritty = enabled;
        firefox = enabled;
      };

      desktop = {
      	hyprland = {
	  enable = true;
	  home = true;
	};
	ly = enabled;
      };

      tools = {
        fastfetch = enabled;
        nixvim = enabled;
      };

      devshells = {
        fabric = enabled;
      };

      system = {
        boot.grub = enabled;

        networking = {
          networkmanager = {
            enable = true;
            hostname = "nixos-btw";
          };
        };
	fonts = enabled;
        nix.flakes = enabled;
      };
    };
  };
}

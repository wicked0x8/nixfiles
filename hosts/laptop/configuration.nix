{ config, pkgs, lib, inputs, ... }:
let
  inherit (lib.whatever) enabled;
  inherit (config.mine) user;
in
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/import.nix
    ../../modules/home/import.nix
    ../../modules/shared/import.nix
  ];

  config = {
    system.stateVersion = "25.05";
    boot.kernelPackages = pkgs.linuxPackages_zen; # todo, refactor this somewhere idk..
    documentation.nixos.enable = false; # this too.
    nixpkgs.config.allowUnfree = true;

    i18n = {
      defaultLocale = "en_US.UTF-8/UTF-8";
      extraLocales = [ "ru_RU.UTF-8/UTF-8" ];
    };

    environment.variables = {
      QT_QPA_PLATFORMTHEME = "qt5ct";
    };

    mine = {
      user = {
        enable = true;
        home-manager = enabled;
        shell.package = pkgs.zsh;

	#nix-colors = enabled;
      };

      home-manager = {
        git = enabled;
	zsh = enabled;
      };

      apps = {
      	alacritty = enabled;
        firefox = enabled;
	prismlauncher = enabled;
	obsidian = enabled;
	telegram = enabled;
      };

      desktop = {
      	#hyprland = {
	#  enable = true;
	#  home = true;
	#};
	mango = {
	  enable = true;
	  home = true;
	};
	ly = enabled;
      };

      tools = {
        fastfetch = enabled;
        nixvim = enabled;
      };

      services = {
        seatd = enabled;
	cliphist = enabled;
	kde-polkit-agent = enabled;
      };

      system = {
        boot.grub = enabled;

        networking = {
          networkmanager = {
            enable = true;
            hostname = "laptop";
          };
        };
	bluetooth = enabled;
	amdcpu-tweaks = enabled;
	fonts = enabled;
        nix.flakes = enabled;
      };
    };
  };
}

{
  pkgs,
  lib,
  ...
}:
let
  inherit (lib.whatever) enabled;
in
{
  imports = [
    ./cachix.nix
    ./hardware-configuration.nix
    ../../modules/nixos/import.nix
    ../../modules/home/import.nix
    ../../modules/shared/import.nix
  ];

  config = {
    system.stateVersion = "25.05";
    nixpkgs.config.allowUnfree = true;

    i18n = {
      extraLocales = [ "ru_RU.UTF-8/UTF-8" ];
    };

    environment.variables = {
      QT_QPA_PLATFORMTHEME = "gtk3";
      QT_QPA_PLATFORMTHEME_QT6 = "gtk3";
    };

    mine = {
      user = {
        enable = true;
        home-manager = enabled;
        shell.package = pkgs.zsh;
      };

      home-manager = {
        git = enabled;
        zsh = enabled;
      };

      apps = {
        tmux = enabled;
        alacritty = enabled;
        firefox = enabled;
        prismlauncher = enabled;
        obsidian = enabled;
        telegram = enabled;
        anki = enabled;
        lutris = enabled;
        qbittorrent = enabled;
        zathura = enabled;
        vscodium = enabled;
        steam = enabled;
        rustdesk = enabled;
      };

      desktop = {
        mango = {
          enable = true;
          home = true;
        };
        #ly = enabled;
        lemurs = enabled;
        dms = enabled;
      };

      tools = {
        fastfetch = enabled;
        nixvim = enabled;
        shotman = enabled;
        wine = enabled;
        make = enabled;
        zoxide = enabled;
        appimage-run = enabled;
      };

      services = {
        seatd = enabled;
        cliphist = enabled;
        zapret = enabled;
      };

      system = {
        boot = {
          grub = enabled;
          kernel = {
            enable = true;
            packages = pkgs.linuxPackages_zen;
          };
        };

        documentation = {
          enable = false;
        };

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

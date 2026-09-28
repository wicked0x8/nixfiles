{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib.whatever) enabled;
  inherit (config.mine) user;
in {
  imports = [
    ../../modules/darwin/import.nix
    ../../modules/home/import.nix
    ../../modules/shared/import.nix
  ];

  config = {
    nixpkgs = {
      hostPlatform = "aarch64-darwin";
      config.allowUnfree = true;
    };

    nix = {
      settings = {
        experimental-features = "nix-command flakes";
      };
      optimise.automatic = true;
      package = pkgs.nix;
    };

    system = {
      stateVersion = 5;
      primaryUser = "${user.name}";
    };

    environment.variables = {
      PATH = "/usr/bin/:$PATH";
    };

    mine = {
      user = {
        enable = true;
        home-manager = enabled;
        shell.package = pkgs.zsh;
      };

      home-manager = {
        zsh = enabled;
        git = enabled;
      };

      apps = {
        ghostty = {
          enable = true;
          home = true;
        };
        libreoffice = enabled;
        steam = enabled;
        vesktop = enabled;
        krita = enabled;
        keka = enabled;
        prism = enabled;
        kap = enabled;
        #kew = enabled;
      };

      tools = {
        homebrew = enabled;
        arduino = enabled;
        nixvim = enabled;
        fastfetch = enabled;
        mole = enabled;
        debloat = enabled;
      };

      system = {
        utils = {
          dev = true;
          enable = true;
        };
      };
    };
  };
}

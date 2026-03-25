{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (lib.whatever) enabled;
  inherit (config.mine) user;
in
{
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

      desktop.yabai = enabled;

      apps = {
        ghostty = {
          enable = true;
          home = true;
        };
        mumble = {
          enable = true;
          server = false;
          serverPassword = "qwerty1234";
          superUserPassword = "betterthanqwerty1234";
          serverBinaryPath = "/Users/${user.name}/.local/bin/murmurd";
        };
        keka = enabled;
        libreoffice = enabled;
        prism = enabled;
        adguard-vpn = enabled;
        bit-slicer = enabled;
      };

      tools = {
        homebrew = enabled;
        ice = enabled;
        nixvim = enabled;
        fastfetch = enabled;
        mole = enabled;
        arduino = enabled;
        zoxide = enabled;
      };

      system = {
        utils = {
          enable = true;
          dev = true;
        };
      };
    };
  };
}

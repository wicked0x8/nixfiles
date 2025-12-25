{
  pkgs,
  lib,
  config,
  ...
}:
let

  inherit (lib) mkEnableOption mkIf;
  inherit (config.mine) user;
  cfg = config.mine.apps.helix;

in
{
  options.mine.apps.helix = {
    enable = mkEnableOption "enable helix";
  };

  config = mkIf cfg.enable {
    home-manager.users.${user.name} = {
      programs.helix = {
        enable = true;
        settings = {
          theme = "base16_terminal";
          editor = {
            line-number = "relative";
            mouse = false;

            cursor-shape = {
              insert = "bar";
              normal = "block";
              select = "underline";
            };

          };
        };
        languages.language = [
          {
            name = "nix";
            auto-format = true;
            formatter.command = lib.getExe pkgs.nixfmt-rfc-style;
          }
        ];
      };
    };
  };
}

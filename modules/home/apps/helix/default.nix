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

            statusline = {
              center = [ "version-control" ];
              left = [ "mode", "spinner", "file-name", "read-only-indicator", "file-modification-indicator" ];
            };

            indent-guides = {
              character = "|";
              render = true;
            };

            whitespace.render = {
              tab = "all";
              tabpad = "all";
              newline = "none";
            };

            lsp = {
              display-inlay-hints = true;
            };

            file.picker = { hidden = false; };
          };
        };

        languages.language = [
          {
            name = "nix";
            auto-format = true;
            formatter.command = lib.getExe pkgs.nixfmt-rfc-style;
          }

          {
            name = "rust";
            auto-format = true;
            language-servers = [ "rust-analyzer" ];
            file-types = [ "rs" ];
            comment-token = "//";
            indent = {
              tab-width = 4;
              unit = "    ";
            };
          }
        ];
      };
    };
  };
}

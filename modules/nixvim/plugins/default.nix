{ pkgs, ... }:
{
  programs.nixvim = {
    plugins = {
      barbecue.enable = true;
      snacks.enable = true;
      colorizer.enable = true;
      cmp.enable = true;
      cmp-buffer.enable = true;
      cmp-emoji.enable = true;
      cmp-git.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp-path.enable = true;
      lsp-format.enable = true;
      luasnip.enable = true;

      lsp = {
        enable = true;
	servers = {
	  rust_analyzer = {
	    installCargo = true;
	    installRustc = true;
	  };
	  pyright.enable = true;
	};
      };

      treesitter = {
        enable = true;
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          rust
          nix
          python
          json
          toml
          yaml
          vim
          vimdoc
          regex
        ];
      };

      noice = {
        enable = true;
        settings = {
          presets = {
            bottom_search = true;
            long_message_to_split = true;
          };
          routes = [
            {
              view = "notify";
              filter = {
                event = "msg_showmode";
              };
            }
            {
              view = "cmdline_output";
              filter = {
                event = "msg_show";
                min_height = 15;
              };
            }
          ];
        };
      };

      lualine = {
        enable = true;
        settings = {
          sections = {
            lualine_c = [ "filename" ];
          };
        };
      };
    };
  };
}

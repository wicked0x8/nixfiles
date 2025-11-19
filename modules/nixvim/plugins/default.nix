{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    rustup clang
  ];

  programs.nixvim = {
    plugins = {
      # Existing plugins
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
      smear-cursor.enable = true;
      oil.enable = true;
      nvim-autopairs.enable = true;

      # Treesitter with essential languages
      treesitter = {
        enable = true;
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          rust
          python
          nix
          json
          toml
          yaml
          vim
          vimdoc
          regex
        ];
      };

      # LSP support
      lsp = {
        enable = true;
        servers = {
          rust-analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
            cargo.allFeatures = true;
            check.command = "clippy";
          };
          pyright.enable = true;
        };
      };

      # UI Improvements
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
              filter = { event = "msg_showmode"; };
            }
            {
              view = "cmdline_output";
              filter = { event = "msg_show"; min_height = 15; };
            }
          ];
        };
      };

      lualine = {
        enable = true;
        settings = { sections = { lualine_c = [ "filename" ]; }; };
      };
    };
    extraPlugins = with pkgs; [
      vimPlugins.transparent-nvim
    ];
  };
}


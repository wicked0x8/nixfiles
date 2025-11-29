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
      web-devicons.enable = true;
      indent-blankline.enable = true;
      nvim-tree.enable = true;
      tiny-inline-diagnostic.enable = true;


      # Configuring completion system
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "right"; }
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "buffer"; }
            { name = "nvim_lua"; }
            { name = "path"; }
          ];
          snippet = {
            expand = "luasnip";
          };
          mapping = {
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Down>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<Up>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete()";
          };
        };
      };

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
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
          pyright.enable = true;
        };
        diagnostics = {
          enable = true;
          signs.enable = true;
          virtualText = true;
          underline = true;
          updateInInsertMode = false;
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


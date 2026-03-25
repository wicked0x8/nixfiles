{ pkgs, ... }:

{
  programs.nixvim = {
    config = {

      extraPackages = with pkgs; [
        lazygit
      ];

      # ── Core options ────────────────────────────────────────────────────────
      opts = {
        clipboard = "unnamedplus";
        number = true;
        relativenumber = true;
        signcolumn = "yes";
        termguicolors = true;
        cursorline = true;
        scrolloff = 8;
        sidescrolloff = 8;
        expandtab = true;
        shiftwidth = 2;
        tabstop = 2;
        autoindent = true;
        smartindent = true;
        ignorecase = true;
        smartcase = true;
        hlsearch = true;
        incsearch = true;
        splitright = true;
        splitbelow = true;
        undofile = true;
        updatetime = 250;
        timeoutlen = 300;
        wrap = false;
      };

      globals = {
        mapleader = " ";
        maplocalleader = " ";
      };

      colorschemes.catppuccin = {
        enable = true;
        settings = {
          flavour = "mocha";
          transparent_background = true;
          integrations = {
            cmp = true;
            gitsigns = true;
            telescope.enabled = true;
            treesitter = true;
            notify = true;
            noice = true;
            indent_blankline.enabled = true;
            mini.enabled = true;
            lualine = true;
            which_key = true;
          };
        };
      };

      plugins = {
        barbecue.enable = true;
        oil.enable = true;
        web-devicons.enable = true;

        # ── Smooth scrolling ────────────────────────────────────────────────
        # cinnamon gives per-scroll easing with configurable step/timing
        cinnamon = {
          enable = true;
          settings = {
            extra_keymaps = true; # <C-u/d/b/f>, gg, G, n, N etc.
            extended_keymaps = false;
            default_keymaps = true;
            max_length = 500; # cap animation length (ms) so it never drags
            scroll_limit = 150; # lines — bail to instant beyond this
            options = {
              mode = "cursor"; # animate the cursor, not just the viewport
              time = 280; # total animation duration (ms)
              easing = "cubic"; # cubic ease-out feels natural
              max_delta = {
                line = 150;
                column = 200;
              };
            };
          };
        };

        snacks = {
          enable = true;
          settings = {
            bigfile.enabled = true;
            quickfile.enabled = true;
            statuscolumn.enabled = true;
            words.enabled = true;
            # ── lazygit integration ──────────────────────────────────────
            lazygit.enabled = true;
          };
        };

        # ── Cutlass: fix dd/x/s/c not clobbering clipboard ──────────────────
        # x/s/d all become black-hole deletes; use 'm' (move) to actually cut
        cutlass = {
          enable = true;
          settings = {
            cut_key = "m"; # explicit cut key — m[motion] moves to clipboard
            override = true; # override x, s as well as d
            exclude = [
              "ns"
              "nS"
            ]; # don't override these
          };
        };

        which-key = {
          enable = true;
          settings = {
            icons = {
              breadcrumb = "»";
              separator = "➜";
              group = "✦ ";
            };
            win.wo.winblend = 10;
          };
        };

        indent-blankline = {
          enable = true;
          settings = {
            indent.char = "│";
            scope.enabled = true;
            exclude.filetypes = [
              ""
              "help"
              "alpha"
              "dashboard"
              "neo-tree"
              "Trouble"
              "trouble"
              "lazy"
              "mason"
              "notify"
              "toggleterm"
              "lazyterm"
            ];
          };
        };

        notify = {
          enable = true;
          settings = {
            background_colour = "#1e1e2e";
            fps = 60;
            render = "compact";
            stages = "fade_in_slide_out";
            timeout = 3000;
          };
        };

        comment = {
          enable = true;
          settings.pre_hook = ''
            require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
          '';
        };

        ts-context-commentstring = {
          enable = true;
          disableAutoInitialization = true;
        };

        nvim-surround.enable = true;

        luasnip = {
          enable = true;
          settings = {
            history = true;
            updateevents = "TextChanged,TextChangedI";
          };
        };

        cmp = {
          enable = true;
          autoEnableSources = true;
          settings = {
            sources = [
              {
                name = "nvim_lsp";
                priority = 1000;
              }
              {
                name = "luasnip";
                priority = 750;
              }
              {
                name = "buffer";
                priority = 500;
                keyword_length = 3;
              }
              {
                name = "path";
                priority = 250;
              }
              {
                name = "emoji";
                priority = 100;
              }
            ];
            snippet.expand = ''
              function(args)
                require("luasnip").lsp_expand(args.body)
              end
            '';
            mapping = {
              "<CR>" = "cmp.mapping.confirm({ select = true })";
              "<C-Space>" = "cmp.mapping.complete()";
              "<C-e>" = "cmp.mapping.abort()";
              "<C-b>" = "cmp.mapping.scroll_docs(-4)";
              "<C-f>" = "cmp.mapping.scroll_docs(4)";
              "<Tab>" = ''
                cmp.mapping(function(fallback)
                  if cmp.visible() then
                    cmp.select_next_item()
                  elseif require("luasnip").expand_or_jumpable() then
                    require("luasnip").expand_or_jump()
                  else
                    fallback()
                  end
                end, { "i", "s" })
              '';
              "<S-Tab>" = ''
                cmp.mapping(function(fallback)
                  if cmp.visible() then
                    cmp.select_prev_item()
                  elseif require("luasnip").jumpable(-1) then
                    require("luasnip").jump(-1)
                  else
                    fallback()
                  end
                end, { "i", "s" })
              '';
            };
            window = {
              completion.border = "rounded";
              documentation.border = "rounded";
            };
          };
        };

        treesitter = {
          enable = true;
          settings = {
            highlight.enable = true;
            indent.enable = true;
          };
          grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
            bash
            c
            dockerfile
            gitcommit
            git_config
            gitignore
            json
            lua
            make
            markdown
            markdown_inline
            nix
            python
            regex
            rust
            toml
            vim
            vimdoc
            yaml
          ];
        };

        lsp = {
          enable = true;
          servers = {
            rust_analyzer = {
              enable = true;
              installCargo = false;
              installRustc = false;
              settings."rust-analyzer" = {
                check.command = "clippy";
                cargo.features = "all";
              };
            };
            pyright.enable = true;
            nixd.enable = true;
            lua_ls = {
              enable = true;
              settings.Lua = {
                diagnostics.globals = [ "vim" ];
                workspace.checkThirdParty = false;
                telemetry.enable = false;
              };
            };
          };
          keymaps = {
            diagnostic = {
              "<leader>e" = "open_float";
              "[d" = "goto_prev";
              "]d" = "goto_next";
              "<leader>dl" = "setloclist";
            };
            lspBuf = {
              "gd" = "definition";
              "gD" = "declaration";
              "gr" = "references";
              "gi" = "implementation";
              "gt" = "type_definition";
              "K" = "hover";
              "<leader>rn" = "rename";
              "<leader>ca" = "code_action";
              "<leader>fm" = "format";
            };
          };
        };

        lualine = {
          enable = true;
          settings = {
            options = {
              component_separators = {
                left = "";
                right = "";
              };
              section_separators = {
                left = "";
                right = "";
              };
              globalstatus = true;
              disabled_filetypes.statusline = [
                "dashboard"
                "alpha"
                "starter"
              ];
            };
            sections = {
              lualine_a = [ "mode" ];
              lualine_b = [
                "branch"
                {
                  __unkeyed-1 = "diff";
                  symbols = {
                    added = " ";
                    modified = " ";
                    removed = " ";
                  };
                }
                {
                  __unkeyed-1 = "diagnostics";
                  symbols = {
                    error = " ";
                    warn = " ";
                    info = " ";
                    hint = "󰌶 ";
                  };
                }
              ];
              lualine_c = [
                {
                  __unkeyed-1 = "filename";
                  path = 1;
                  symbols = {
                    modified = " ●";
                    readonly = "  ";
                    unnamed = "[No Name]";
                  };
                }
              ];
              lualine_x = [
                {
                  __unkeyed-1 = "filetype";
                  icon = {
                    align = "right";
                  };
                }
              ];
              lualine_y = [ "progress" ];
              lualine_z = [ "location" ];
            };
            inactive_sections = {
              lualine_a = [ ];
              lualine_b = [ ];
              lualine_c = [ "filename" ];
              lualine_x = [ "location" ];
              lualine_y = [ ];
              lualine_z = [ ];
            };
          };
        };

        telescope = {
          enable = true;
          keymaps = {
            "<leader>ff" = "find_files";
            "<leader>fg" = "live_grep";
            "<leader>fb" = "buffers";
            "<leader>fh" = "help_tags";
            "<leader>fd" = "diagnostics";
            "<leader>fr" = "resume";
          };
          settings.defaults = {
            file_ignore_patterns = [
              "node_modules"
              ".git/"
              "target/"
              ".direnv/"
              "__pycache__/"
              "%.lock"
            ];
            layout_config.horizontal.preview_width = 0.55;
            # faster sorting via fzf native
            vimgrep_arguments = [
              "rg"
              "--color=never"
              "--no-heading"
              "--with-filename"
              "--line-number"
              "--column"
              "--smart-case"
              "--hidden"
              "--glob=!.git/"
            ];
          };
          extensions = {
            fzf-native.enable = true;
            # ── telescope-undo: visual undo tree ──────────────────────────
            undo = {
              enable = true;
              settings = {
                side_by_side = true;
                layout_strategy = "vertical";
                layout_config.preview_height = 0.8;
              };
            };
          };
        };

        noice = {
          enable = true;
          settings = {
            lsp = {
              progress.enabled = true;
              hover.opts.border = "rounded";
              signature.enabled = true;
              override = {
                "vim.lsp.util.convert_input_to_markdown_lines" = true;
                "vim.lsp.util.stylize_markdown" = true;
                "cmp.entry.get_documentation" = true;
              };
            };
            presets = {
              bottom_search = true;
              command_palette = true;
              long_message_to_split = true;
              lsp_doc_border = true;
            };
          };
        };

        gitsigns = {
          enable = true;
          settings = {
            signs = {
              add.text = "+";
              change.text = "~";
              delete.text = "-";
              topdelete.text = "-";
              changedelete.text = "~";
              untracked.text = "+";
            };
            # ── useful gitsigns keymaps ──────────────────────────────────
            on_attach.__raw = ''
              function(bufnr)
                local gs = package.loaded.gitsigns
                local function map(mode, l, r, opts)
                  opts = opts or {}
                  opts.buffer = bufnr
                  vim.keymap.set(mode, l, r, opts)
                end
                -- Navigation
                map('n', ']c', function() if vim.wo.diff then return ']c' end vim.schedule(gs.next_hunk) return '<Ignore>' end, { expr = true })
                map('n', '[c', function() if vim.wo.diff then return '[c' end vim.schedule(gs.prev_hunk) return '<Ignore>' end, { expr = true })
                -- Actions
                map('n', '<leader>hs', gs.stage_hunk)
                map('n', '<leader>hr', gs.reset_hunk)
                map('v', '<leader>hs', function() gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end)
                map('v', '<leader>hr', function() gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end)
                map('n', '<leader>hS', gs.stage_buffer)
                map('n', '<leader>hu', gs.undo_stage_hunk)
                map('n', '<leader>hR', gs.reset_buffer)
                map('n', '<leader>hp', gs.preview_hunk)
                map('n', '<leader>hb', function() gs.blame_line({ full = true }) end)
                map('n', '<leader>hd', gs.diffthis)
                map('n', '<leader>hD', function() gs.diffthis('~') end)
                -- Toggle
                map('n', '<leader>tb', gs.toggle_current_line_blame)
                map('n', '<leader>td', gs.toggle_deleted)
              end
            '';
          };
        };

        toggleterm = {
          enable = true;
          settings = {
            open_mapping = "[[<C-t>]]";
            direction = "float";
            float_opts.border = "curved";
            shade_terminals = true;
          };
        };

        nvim-autopairs = {
          enable = true;
          settings.check_ts = true;
        };

        # ── Session management ───────────────────────────────────────────────
        # auto-session saves/restores per-cwd sessions transparently
        auto-session = {
          enable = true;
          settings = {
            auto_save_enabled = true;
            auto_restore_enabled = true;
            auto_session_suppress_dirs = [
              "~/"
              "~/Downloads"
              "/tmp"
            ];
          };
        };

        # ── mini: animate only (stripped down, cursor + window) ──────────────
        mini = {
          enable = true;
          modules = {
            animate = {
              cursor = {
                timing.__raw = "require('mini.animate').gen_timing.cubic({ duration = 120, unit = 'total' })";
              };
              resize = {
                timing.__raw = "require('mini.animate').gen_timing.linear({ duration = 60, unit = 'total' })";
              };
              open = {
                timing.__raw = "require('mini.animate').gen_timing.linear({ duration = 60, unit = 'total' })";
              };
              close = {
                timing.__raw = "require('mini.animate').gen_timing.linear({ duration = 60, unit = 'total' })";
              };
            };
          };
        };
      };

      keymaps = [
        # ── Buffer navigation ────────────────────────────────────────────────
        {
          key = "<S-h>";
          action = "<cmd>bprevious<cr>";
          mode = [ "n" ];
          options.silent = true;
        }
        {
          key = "<S-l>";
          action = "<cmd>bnext<cr>";
          mode = [ "n" ];
          options.silent = true;
        }
        {
          key = "<leader>bd";
          action = "<cmd>bdelete<cr>";
          mode = [ "n" ];
          options.silent = true;
        }
        # ── File ops ─────────────────────────────────────────────────────────
        {
          key = "<leader>w";
          action = "<cmd>w<cr>";
          mode = [ "n" ];
          options.silent = true;
        }
        {
          key = "<leader>q";
          action = "<cmd>q<cr>";
          mode = [ "n" ];
          options.silent = true;
        }
        {
          key = "<leader>Q";
          action = "<cmd>qa!<cr>";
          mode = [ "n" ];
          options.silent = true;
        }
        # ── Search ───────────────────────────────────────────────────────────
        {
          key = "<leader>/";
          action = "<cmd>Telescope live_grep<cr>";
          mode = [ "n" ];
          options.silent = true;
        }
        {
          key = "<leader>nh";
          action = "<cmd>nohl<cr>";
          mode = [ "n" ];
          options.silent = true;
        }
        # ── Telescope undo ───────────────────────────────────────────────────
        {
          key = "<leader>fu";
          action = "<cmd>Telescope undo<cr>";
          mode = [ "n" ];
          options.silent = true;
        }
        # ── Oil file manager ─────────────────────────────────────────────────
        {
          key = "-";
          action = "<cmd>Oil<cr>";
          mode = [ "n" ];
          options.silent = true;
        }
        # ── Window navigation ────────────────────────────────────────────────
        {
          key = "<C-h>";
          action = "<C-w>h";
          mode = [ "n" ];
          options.silent = true;
        }
        {
          key = "<C-j>";
          action = "<C-w>j";
          mode = [ "n" ];
          options.silent = true;
        }
        {
          key = "<C-k>";
          action = "<C-w>k";
          mode = [ "n" ];
          options.silent = true;
        }
        {
          key = "<C-l>";
          action = "<C-w>l";
          mode = [ "n" ];
          options.silent = true;
        }
        # ── Indent keep selection ────────────────────────────────────────────
        {
          key = "<";
          action = "<gv";
          mode = [ "v" ];
        }
        {
          key = ">";
          action = ">gv";
          mode = [ "v" ];
        }
        # ── Move lines ───────────────────────────────────────────────────────
        {
          key = "<A-j>";
          action = ":m .+1<CR>==";
          mode = [ "n" ];
          options.silent = true;
        }
        {
          key = "<A-k>";
          action = ":m .-2<CR>==";
          mode = [ "n" ];
          options.silent = true;
        }
        {
          key = "<A-j>";
          action = ":m '>+1<CR>gv=gv";
          mode = [ "v" ];
          options.silent = true;
        }
        {
          key = "<A-k>";
          action = ":m '<-2<CR>gv=gv";
          mode = [ "v" ];
          options.silent = true;
        }
        # ── Git (lazygit + gitsigns) ─────────────────────────────────────────
        {
          key = "<leader>gg";
          action.__raw = "function() Snacks.lazygit() end";
          mode = [ "n" ];
          options.silent = true;
          options.desc = "Lazygit";
        }
        {
          key = "<leader>gf";
          action.__raw = "function() Snacks.lazygit.log_file() end";
          mode = [ "n" ];
          options.silent = true;
          options.desc = "Lazygit file log";
        }
        {
          key = "<leader>gl";
          action.__raw = "function() Snacks.lazygit.log() end";
          mode = [ "n" ];
          options.silent = true;
          options.desc = "Lazygit log";
        }
        # ── Session ──────────────────────────────────────────────────────────
        {
          key = "<leader>ss";
          action = "<cmd>SessionSave<cr>";
          mode = [ "n" ];
          options.silent = true;
          options.desc = "Save session";
        }
        {
          key = "<leader>sr";
          action = "<cmd>SessionRestore<cr>";
          mode = [ "n" ];
          options.silent = true;
          options.desc = "Restore session";
        }
        {
          key = "<leader>sd";
          action = "<cmd>SessionDelete<cr>";
          mode = [ "n" ];
          options.silent = true;
          options.desc = "Delete session";
        }
      ];

      autoCmd = [
        {
          event = "TextYankPost";
          pattern = "*";
          callback.__raw = ''
            function()
              vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
            end
          '';
        }
        {
          event = "BufReadPost";
          pattern = "*";
          callback.__raw = ''
            function()
              local mark   = vim.api.nvim_buf_get_mark(0, [["]])
              local lcount = vim.api.nvim_buf_line_count(0)
              if mark[1] > 0 and mark[1] <= lcount then
                pcall(vim.api.nvim_win_set_cursor, 0, mark)
              end
            end
          '';
        }
        {
          event = "BufWritePre";
          pattern = "*";
          callback.__raw = ''
            function()
              vim.lsp.buf.format({ async = true })
            end
          '';
        }
      ];
    };
  };
}

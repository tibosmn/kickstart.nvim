-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim
return {
  {
    -- For file operations to work with LSP (updating imports, etc.)
    'antosha417/nvim-lsp-file-operations',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-neo-tree/neo-tree.nvim',
    },
    config = function()
      require('lsp-file-operations').setup()
    end,
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      { '3rd/image.nvim', opts = {} }, -- Image support in preview window
      {
        's1n7ax/nvim-window-picker', -- for open_with_window_picker keymaps
        version = '2.*',
        config = function()
          require('window-picker').setup {
            filter_rules = {
              include_current_win = false,
              autoselect_one = true,
              -- filter using buffer options
              bo = {
                -- if the file type is one of following, the window will be ignored
                filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
                -- if the buffer type is one of following, the window will be ignored
                buftype = { 'terminal', 'quickfix' },
              },
            },
          }
        end,
      },
    },
    lazy = true,
    config = function()
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = '',
          [vim.diagnostic.severity.WARN] = '',
          [vim.diagnostic.severity.INFO] = '',
          [vim.diagnostic.severity.HINT] = '󰌵',
        },
      }
      require('neo-tree').setup {
        close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
        popup_border_style = 'NC', -- or "" to use 'winborder' on Neovim v0.11+
        enable_git_status = true,
        enable_diagnostics = true,
        open_files_using_relative_paths = false,
        window = {
          mappings = {
            ['<C-s>'] = 'open_split', -- horizontal split
            ['s'] = '', -- disable default 's'

            ['<C-v>'] = 'open_vsplit', -- vertical split
            ['v'] = '', -- disable default 'v'

            [' '] = {
              'toggle_preview',
              config = {
                use_float = false,
                use_image_nvim = true,
                -- title = 'Neo-tree Preview',
              },
            },
          },
        },
        filesystem = {
          filtered_items = {
            visible = false, -- when true, they will just be displayed differently than normal items
            hide_by_name = {
              'node_modules',
            },
            hide_by_pattern = { -- uses glob style patterns
              '*.meta',
              '*/src/*/tsconfig.json',
            },
          },
          never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
            '.DS_Store',
            'thumbs.db',
          },
        },
      }

      vim.keymap.set('n', '<leader>e', '<Cmd>Neotree toggle<CR>')
    end,
  },
}


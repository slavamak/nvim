return {
  {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
    init = function()
      local bind = require('util').bind()
      bind('n', '<Leader>u', '<Cmd>UndotreeToggle<Cr>', 'Undotree toggle')
    end,
    config = function()
      vim.g.undotree_SetFocusWhenToggle = 1
    end,
  },

  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'nvim-telescope/telescope-ui-select.nvim',
    },
    config = function()
      local telescope = require 'telescope'
      local actions = require 'telescope.actions'
      local telescope_config = require 'telescope.config'
      local vimgrep_arguments = { unpack(telescope_config.values.vimgrep_arguments) }

      table.insert(vimgrep_arguments, '--hidden')
      table.insert(vimgrep_arguments, '--glob')
      table.insert(vimgrep_arguments, '!**/.git/*')

      telescope.setup {
        defaults = {
          mappings = {
            i = {
              ['<Left>'] = actions.preview_scrolling_left,
              ['<Right>'] = actions.preview_scrolling_right,
            },
            n = {
              ['<Left>'] = actions.preview_scrolling_left,
              ['<Right>'] = actions.preview_scrolling_right,
            },
          },
          vimgrep_arguments = vimgrep_arguments,
        },
        pickers = {
          find_files = {
            find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' },
          },
        },
      }

      telescope.load_extension 'ui-select'
    end,
  },

  {
    'numToStr/Comment.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = true,
  },

  {
    'kylechui/nvim-surround',
    event = { 'BufReadPre', 'BufNewFile' },
    config = true,
  },

  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
  },

  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    cmd = 'Neotree',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    opts = {
      close_if_last_window = true,
      popup_border_style = vim.g.border_chars,
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
      event_handlers = {
        {
          event = 'file_opened',
          handler = function()
            vim.cmd 'Neotree close'
          end,
        },
      },
    },
  },

  {
    'ThePrimeagen/vim-be-good',
    cmd = 'VimBeGood',
  },
}

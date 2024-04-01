return {
  {
    'rebelot/kanagawa.nvim',
    lazy = false,
    opts = {
      commentStyle = { italic = false },
      keywordStyle = { italic = false },
      statementStyle = { bold = false },
      overrides = function(colors)
        return {
          GitSignsAdd = { bg = 'none' },
          GitSignsChange = { bg = 'none' },
          GitSignsDelete = { bg = 'none' },
          LineNr = { bg = 'none' },
          SignColumn = { bg = 'none' },
          StatusLine = { fg = colors.theme.ui.special, bg = 'none' },
          StatusLineNC = { bg = 'none' },
        }
      end,
    },
  },

  {
    'projekt0n/github-nvim-theme',
    lazy = false,
    opts = {
      groups = {
        all = {
          Delimiter = { link = '@punctuation.delimiter' },
          StatusLine = { fg = 'fg3', bg = 'none' },
          StatusLineNC = { fg = 'palette.fg.muted', bg = 'none' },
        },
      },
    },
    config = function(_, opts)
      require('github-theme').setup(opts)
    end,
  },

  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'nvim-telescope/telescope-ui-select.nvim',
    },
    config = function()
      local telescope = require 'telescope'
      local telescope_config = require 'telescope.config'
      local vimgrep_arguments = { unpack(telescope_config.values.vimgrep_arguments) }

      table.insert(vimgrep_arguments, '--hidden')
      table.insert(vimgrep_arguments, '--glob')
      table.insert(vimgrep_arguments, '!**/.git/*')

      telescope.setup {
        defaults = {
          vimgrep_arguments = vimgrep_arguments
        },
        extensions = {
          ["ui-select"] = {
            require('telescope.themes').get_dropdown {}
          }
        },
        pickers = {
          find_files = {
            find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' },
          },
          git_files = {
            show_untracked = true
          },
        },
      }

      telescope.load_extension 'ui-select'
    end
  },

  {
    'stevearc/oil.nvim',
    cmd = 'Oil',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      default_file_explorer = false,
      delete_to_trash = true,
    },
    config = function(_, opts)
      require('oil').setup(opts)
    end
  },
}

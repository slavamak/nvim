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
          MiniStatuslineModeNormal = { bg = colors.theme.syn.fun, fg = colors.theme.ui.bg_m3 },
          MiniStatuslineModeInsert = { bg = colors.theme.diag.ok, fg = colors.theme.ui.bg },
          MiniStatuslineModeCommand = { bg = colors.theme.syn.operator, fg = colors.theme.ui.bg },
          MiniStatuslineModeVisual = { bg = colors.theme.syn.keyword, fg = colors.theme.ui.bg },
          MiniStatuslineModeReplace = { bg = colors.theme.syn.constant, fg = colors.theme.ui.bg },
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
          MiniStatuslineModeOther = { fg = 'bg1', bg = 'palette.orange.base', style = 'bold' },
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
      float = {
        max_width = 100,
        max_height = 20,
      },
    },
    config = function(_, opts)
      require('oil').setup(opts)
    end
  },

  {
    'j-hui/fidget.nvim',
    config = true,
  },

  {
    'echasnovski/mini.statusline',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'lewis6991/gitsigns.nvim'
    },
    event = 'VeryLazy',
    config = function()
      local statusline = require 'mini.statusline'
      statusline.setup {}

      statusline.section_location = function(args)
        if statusline.is_truncated(args.trunc_width) then return '%2l│%2v' end
        return '%2l:%L│%2v'
      end

      vim.api.nvim_create_autocmd('OptionSet', {
        callback = statusline.setup,
        group = vim.api.nvim_create_augroup('update-statusline', { clear = true }),
        pattern = 'background',
      })
    end
  }
}

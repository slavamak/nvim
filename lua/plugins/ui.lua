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
    'nvim-lualine/lualine.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'InsertEnter' },
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      options = {
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = { 'alpha', 'neo-tree' },
        theme = function()
          local utils = require 'lualine.utils.utils'
          local normal = utils.extract_highlight_colors 'StatusLine'
          local inactive = utils.extract_highlight_colors 'StatusLineNC'

          return {
            normal = {
              a = normal,
              b = normal,
              c = normal,
            },
            inactive = {
              a = inactive,
              b = inactive,
              c = inactive,
            },
          }
        end,
      },
      tabline = {
        lualine_a = {
          {
            'tabs',
            mode = 1,
            fmt = function(name, context)
              local buflist = vim.fn.tabpagebuflist(context.tabnr)
              local winnr = vim.fn.tabpagewinnr(context.tabnr)
              local bufnr = buflist[winnr]
              local filetype = vim.bo[bufnr].filetype
              local tab_name = name

              if filetype == 'netrw' then
                tab_name = 'File Tree'
              elseif filetype == 'TelescopePrompt' then
                tab_name = 'Telescope'
              end

              return tab_name
            end,
          },
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {
          {
            '',
            type = 'stl',
            on_click = function()
              vim.cmd 'tabclose'
            end,
          },
        },
      },
      winbar = {
        lualine_a = { '%f' },
      },
      inactive_winbar = {
        lualine_a = { '%f' },
      },
      sections = {
        lualine_a = {
          {
            '',
            type = 'stl',
            padding = { left = 1, right = 2 },
            on_click = function()
              vim.cmd 'Alpha'
            end,
          },
        },
        lualine_b = {
          'b:gitsigns_head',
          {
            'diff',
            colored = false,
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
          {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            sections = { 'error', 'warn' },
            diagnostics_color = {
              error = 'DiagnosticError',
              warn = 'DiagnosticWarn',
              info = 'DiagnosticInfo',
              hint = 'DiagnosticHint',
            },
            symbols = {
              error = ' ',
              warn = ' ',
              info = 'I',
              hint = 'H',
            },
            colored = false,
            update_in_insert = true,
            always_visible = false,
          },
        },
        lualine_c = { 'filename' },
        lualine_x = { { 'filetype', icons_enabled = false } },
        lualine_y = { { 'progress' } },
        lualine_z = { { 'location' } },
      },
    },
    config = function(_, opts)
      local lualine = require 'lualine'
      local util = require 'util'

      local lualine_setup = function()
        lualine.setup(opts)
        vim.o.showtabline = 1
      end

      lualine_setup()

      vim.api.nvim_create_autocmd('OptionSet', {
        callback = lualine_setup,
        group = util.augroup 'update_lualine_theme',
        pattern = 'background',
      })
    end,
  },

  {
    'goolord/alpha-nvim',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      local alpha = require 'alpha'
      local startify = require 'alpha.themes.startify'

      startify.section.header.val = {
        ' _  ___   _____ __  __ ',
        '| \\| \\ \\ / /_ _|  \\/  |',
        '| .` |\\ V / | || |\\/| |',
        '|_|\\_| \\_/ |___|_|  |_|',
      }

      alpha.setup(startify.config)
    end,
  },

  {
    'f-person/auto-dark-mode.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      set_dark_mode = function()
        vim.cmd 'colorscheme kanagawa-wave'
        vim.api.nvim_set_option_value('background', 'dark', {})
      end,
      set_light_mode = function()
        vim.cmd 'colorscheme github_light_default'
        vim.api.nvim_set_option_value('background', 'light', {})
      end,
      update_interval = 1000,
    },
  },

  {
    'lukas-reineke/virt-column.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      char = '│',
    },
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    main = 'ibl',
    opts = {
      indent = {
        char = '│',
      },
      scope = {
        show_start = false,
      },
    },
  },
}

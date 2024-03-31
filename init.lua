vim.g.mapleader = ' '
vim.g.netrw_browse_split = 0
vim.g.netrw_preview = 1
vim.g.netrw_alto = 0
vim.opt.cursorline = true
vim.opt.ignorecase = true
vim.opt.list = true
vim.opt.listchars = { space = '·', tab = '▸ ' }
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.shiftwidth = 2
vim.opt.sidescrolloff = 8
vim.opt.smartindent = true
vim.opt.smoothscroll = true
vim.opt.spell = true
vim.opt.spelllang = 'ru_ru,en_us'
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.statusline = '%f %m %= %Y %p%% %l:%c  '
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.undodir = os.getenv 'HOME' .. '/.cache/nvim/undodir'
vim.opt.undofile = true
vim.opt.updatetime = 300
vim.opt.wrap = false

vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Escape' })
vim.keymap.set({ 'n', 'i' }, '<Esc>', '<Cmd>noh<Cr><Esc>', { desc = 'Clear the search highlight' })
vim.keymap.set({ 'n', 'v' }, '<Leader>y', [["+y]], { desc = 'Copy to system clipboard' })
vim.keymap.set({ 'n', 'v' }, '<Leader>Y', [["+Y]], { desc = 'Copy a line to system clipboard' })
vim.keymap.set('x', '<Leader>p', [["_dP]], { desc = 'Paste yanked text without affecting registers' })
vim.keymap.set({ 'n', 'v' }, '<Leader>d', [["_d]], { desc = 'Delete selection without affecting registers' })
vim.keymap.set('v', 'J', ":m '>+1<Cr>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', 'K', ":m '>-2<Cr>gv=gv", { desc = 'Move selection up' })
vim.keymap.set('n', 'л', 'gk', { desc = 'Move cursor up' })
vim.keymap.set('n', 'о', 'gj', { desc = 'Move cursor down' })
vim.keymap.set('n', 'р', 'h', { desc = 'Move cursor left' })
vim.keymap.set('n', 'д', 'l', { desc = 'Move cursor right' })
vim.keymap.set('n', '<Leader>p', '<Cmd>Ex<Cr>', { desc = 'Open Netrw' })

vim.keymap.set('n', '<Leader>u', '<Cmd>UndotreeToggle<Cr>', { desc = 'Undotree toggle' })
vim.keymap.set('n', '<Leader>f', '<Cmd>Telescope find_files<Cr>', { desc = 'Find files' })
vim.keymap.set('n', '<Leader>s', '<Cmd>Telescope live_grep<Cr>', { desc = 'Search for a string' })
vim.keymap.set('n', '<Leader>S', '<Cmd>Telescope grep_string<Cr>', { desc = 'Search for a string under the cursor' })
vim.keymap.set('n', '<Leader>g', '<Cmd>Telescope git_files<Cr>', { desc = 'Git files' })
vim.keymap.set('n', '<Leader>b', '<Cmd>Telescope buffers<Cr>', { desc = 'Buffers' })
vim.keymap.set('n', '<Leader>h', '<Cmd>Telescope help_tags<Cr>', { desc = 'Help' })
vim.keymap.set('n', '<Leader>o', '<Cmd>Telescope oldfiles<Cr>', { desc = 'Recently opened' })
vim.keymap.set('n', '-', '<Cmd>Oil<Cr>', { desc = 'File explorer' })
vim.keymap.set('n', '_', '<Cmd>Oil --float<Cr>', { desc = 'File explorer in float window' })
vim.keymap.set('n', '<Leader>G', '<Cmd>Git<Cr>', { desc = 'Open git summary window' })
vim.keymap.set('n', '<Leader>P', '<Cmd>Git push<Cr>', { desc = 'Git push' })
vim.keymap.set('n', '<Leader>]h', '<Cmd>Gitsigns next_hunk<Cr>', { desc = 'Gitsigns next hunk' })
vim.keymap.set('n', '<Leader>[h', '<Cmd>Gitsigns prev_hunk<Cr>', { desc = 'Gitsigns prev hunk' })
vim.keymap.set('n', '<Leader>hs', '<Cmd>Gitsigns stage_hunk<Cr>', { desc = 'Gitsigns stage hunk' })
vim.keymap.set('n', '<Leader>hr', '<Cmd>Gitsigns reset_hunk<Cr>', { desc = 'Gitsigns reset hunk' })
vim.keymap.set('n', '<Leader>hS', '<Cmd>Gitsigns stage_buffer<Cr>', { desc = 'Gitsigns stage buffer' })
vim.keymap.set('n', '<Leader>hR', '<Cmd>Gitsigns reset_buffer<Cr>', { desc = 'Gitsigns reset buffer' })
vim.keymap.set('n', '<Leader>hp', '<Cmd>Gitsigns preview_hunk_inline<Cr>', { desc = 'Gitsigns preview hunk inline' })
vim.keymap.set('n', '<Leader>hP', '<Cmd>Gitsigns preview_hunk<Cr>', { desc = 'Gitsigns preview hunk' })

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
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
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
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
      local telescope_config = require 'telescope.config'
      local vimgrep_arguments = { unpack(telescope_config.values.vimgrep_arguments) }

      table.insert(vimgrep_arguments, '--hidden')
      table.insert(vimgrep_arguments, '--glob')
      table.insert(vimgrep_arguments, '!**/.git/*')

      telescope.setup {
        defaults = {
          vimgrep_arguments = vimgrep_arguments
        },
        pickers = {
          find_files = {
            hidden = true
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

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    cmd = 'TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      auto_install = true,
      ensure_installed = {
        'lua',
        'luadoc',
        'vim',
        'vimdoc',
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },

  {
    'numToStr/Comment.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = true,
  },

    {
    'tpope/vim-fugitive',
    cmd = { 'G', 'Git', 'Gfetch', 'Gpush', 'Gclog', 'Gdiffsplit' },
  },

  {
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPre',
    config = true,
  },
}

local opts = {
  defaults = {
    lazy = true,
  },
  install = {
    missing = true,
    colorscheme = { 'kanagawa-wave', 'github_light_default' },
  },
}

require('lazy').setup(plugins, opts)

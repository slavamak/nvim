return {
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
}

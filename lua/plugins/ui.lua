return {
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
      local colorscheme = vim.o.background == 'light' and 'github_light_default'
        or 'github_dark_default'
      vim.cmd.colorscheme(colorscheme)
    end,
  },

  {
    'j-hui/fidget.nvim',
    lazy = false,
    config = true,
  },
}

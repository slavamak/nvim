return {
  {
    'projekt0n/github-nvim-theme',
    lazy = false,
    priority = 1000,
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

      vim.api.nvim_create_autocmd('OptionSet', {
        desc = 'Automatically update colorscheme based on background option',
        group = vim.api.nvim_create_augroup('update-colorscheme', { clear = true }),
        pattern = 'background',
        callback = function()
          vim.cmd.colorscheme('github_' .. vim.o.background .. '_default')
        end,
      })
    end,
  },

  {
    'j-hui/fidget.nvim',
    lazy = false,
    config = true,
  },
}

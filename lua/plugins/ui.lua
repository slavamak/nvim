return {
  {
    'zenbones-theme/zenbones.nvim',
    dependencies = 'rktjmp/lush.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'zenwritten'
      vim.cmd 'highlight StatusLine guibg=NONE'
      vim.cmd 'highlight! link StatuslineNC LineNR'
      vim.cmd 'highlight! link StatuslineNR LineNR'
    end,
  },

  {
    'j-hui/fidget.nvim',
    lazy = false,
    config = true,
  },
}

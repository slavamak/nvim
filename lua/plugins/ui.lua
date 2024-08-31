return {
  {
    'zenbones-theme/zenbones.nvim',
    dependencies = 'rktjmp/lush.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'zenwritten'

      local function set_highlights()
        vim.api.nvim_set_hl(0, 'StatusLine', { bg = 'NONE' })
        vim.api.nvim_set_hl(0, 'StatusLineNC', { link = 'LineNR' })
      end

      set_highlights()

      vim.api.nvim_create_autocmd('OptionSet', {
        pattern = 'background',
        callback = set_highlights,
      })
    end,
  },

  {
    'j-hui/fidget.nvim',
    lazy = false,
    config = true,
  },
}

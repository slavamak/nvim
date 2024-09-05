return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    lazy = false,
    opts = {
      color_overrides = {
        latte = {
          base = '#eff1f5',
          mantle = '#eff1f5',
          crust = '#eff1f5',
        },
        mocha = {
          base = '#0a0c10',
          mantle = '#0a0c10',
          crust = '#0a0c10',
        },
      },
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)
      vim.cmd.colorscheme 'catppuccin'
    end,
  },

  {
    'j-hui/fidget.nvim',
    lazy = false,
    config = true,
  },
}

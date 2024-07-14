return {
  {
    'stevearc/conform.nvim',
    dependencies = 'neovim/nvim-lspconfig',
    cmd = 'ConformInfo',
    opts = {
      formatters_by_ft = {
        css = { { 'prettierd_css', 'stylelint' } },
        scss = { { 'prettierd_css', 'stylelint' } },
        javascript = { 'prettierd_js' },
        javascriptreact = { 'prettierd_js' },
        typescript = { 'prettierd_js' },
        typescriptreact = { 'prettierd_js' },
        liquid = { 'prettierd' },
        lua = { 'stylua' },
        bash = { 'shfmt' },
        sh = { 'shfmt' },
        zsh = { 'shfmt' },
        yaml = { 'prettierd' },
      },
      formatters = {
        shfmt = {
          prepend_args = { '-i', '2', '-s', '-ci', '-sr', '-ln', 'bash' },
        },
      },
      log_level = vim.log.levels.DEBUG,
    },
    config = function(_, opts)
      local conform = require 'conform'
      local conform_util = require 'conform.util'
      local lsp_util = require 'lspconfig.util'
      local prettierd = require 'conform.formatters.prettierd'

      opts.formatters.stylelint = {
        cwd = conform_util.root_file(lsp_util.insert_package_json({
          '.stylelintrc',
          '.stylelintrc.js',
          '.stylelintrc.cjs',
          '.stylelintrc.yaml',
          '.stylelintrc.yml',
          '.stylelintrc.json',
          'stylelint.config.js',
          'stylelint.config.cjs',
          'stylelint.config.mjs',
          'stylelint.config.ts',
        }, 'stylelint')),
        require_cwd = true,
      }

      opts.formatters.prettierd_js = vim.tbl_deep_extend('force', prettierd, {
        condition = conform_util.root_file {
          'node_modules/eslint-plugin-prettier',
          'node_modules/eslint-config-prettier',
        },
      })

      opts.formatters.prettierd_css = vim.tbl_deep_extend('force', prettierd, {
        condition = conform_util.root_file { 'node_modules/stylelint-prettier' },
      })

      conform.setup(opts)
    end,
  },
}

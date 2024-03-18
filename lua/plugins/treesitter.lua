return {
  'nvim-treesitter/nvim-treesitter-context',

  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    cmd = { 'TSUpdate' },
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'nvim-treesitter/playground',
    },
    opts = {
      auto_install = true,
      ensure_installed = {
        'astro',
        'bash',
        'css',
        'graphql',
        'html',
        'dockerfile',
        'git_config',
        'javascript',
        'jsdoc',
        'json',
        'json5',
        'jsonc',
        'lua',
        'luadoc',
        'make',
        'ruby',
        'toml',
        'typescript',
        'tsx',
        'vue',
        'yaml',
      },
      highlight = {
        enable = true,
        disable = function(_, buf)
          return require('util').is_large_or_minified(buf)
        end,
      },
      incremental_selection = {
        enable = true,
      },
      indent = {
        enable = true,
      },
      playground = {
        enable = true,
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}

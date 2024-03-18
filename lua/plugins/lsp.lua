return {
  {
    'folke/neodev.nvim',
    config = true,
    dependencies = {
      { 'folke/neoconf.nvim', config = true },
    },
  },

  {
    'williamboman/mason.nvim',
    build = ':MasonUpdate',
    cmd = { 'Mason', 'MasonUpdate', 'MasonInstall' },
    opts = {
      ensure_installed = {
        'ansible-lint',
        'eslint_d',
        'prettierd',
        'shfmt',
        'stylelint',
        'stylua',
      },
      ui = {
        border = vim.g.border_chars,
      },
    },
    config = function(_, opts)
      require('mason').setup(opts)

      local registry = require 'mason-registry'

      registry.refresh(function()
        for _, pkg_name in ipairs(opts.ensure_installed) do
          local pkg = registry.get_package(pkg_name)
          if not pkg:is_installed() then pkg:install() end
        end
      end)
    end,
  },

  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    build = ':LspStart',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'VonHeikemen/lsp-zero.nvim', branch = 'v3.x' },
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'folke/neodev.nvim',
      'b0o/schemastore.nvim',
      'stevearc/conform.nvim',
    },
    opts = {
      servers = {
        ansiblels = {},
        astro = {},
        bashls = {
          filetypes = { 'sh', 'bash', 'zsh' },
        },
        cssls = {
          on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = true
            client.server_capabilities.documentRangeFormattingProvider = true
          end,
        },
        emmet_language_server = {},
        eslint = {},
        graphql = {},
        html = {},
        jsonls = {
          on_new_config = function(new_config)
            new_config.settings.json.schemas = new_config.settings.json.schemas or {}
            vim.list_extend(new_config.settings.json.schemas, require('schemastore').json.schemas())
          end,
          settings = {
            json = {
              format = {
                enable = true,
              },
              validate = { enable = true },
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              format = {
                enable = true,
              },
              workspace = {
                checkThirdParty = false,
              },
            },
          },
        },
        pylsp = {},
        ruby_ls = {},
        stylelint_lsp = {
          filetypes = {
            'css',
            'postcss',
            'sass',
            'scss',
            'vue',
          },
        },
        tailwindcss = {},
        taplo = {},
        theme_check = {
          root_dir = function(fname)
            local util = require 'lspconfig.util'

            return util.root_pattern('.theme-check.yml', '.theme-check.yaml')(fname)
              or util.find_package_json_ancestor(fname)
              or util.find_node_modules_ancestor(fname)
              or util.find_git_ancestor(fname)
          end,
        },
        tsserver = {},
        unocss = {},
        vuels = {},
        yamlls = {
          on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = true
            client.server_capabilities.documentRangeFormattingProvider = true
          end,
          on_new_config = function(new_config)
            new_config.settings.yaml.schemas = new_config.settings.yaml.schemas or {}
            vim.list_extend(new_config.settings.yaml.schemas, require('schemastore').yaml.schemas())
          end,
          filetypes = {
            'yaml',
            'yaml.docker-compose',
            'yaml.ansible',
          },
          settings = {
            yaml = {
              format = {
                enable = true,
              },
              validate = true,
              completion = true,
              hover = true,
            },
          },
        },
      },
    },
    config = function(_, opts)
      local lsp_zero = require 'lsp-zero'
      lsp_zero.extend_lspconfig()

      lsp_zero.set_server_config {
        autostart = false,
      }

      lsp_zero.on_attach(function(client, bufnr)
        local bind = require('util').bind { buffer = bufnr }

        bind('n', 'K', vim.lsp.buf.hover, 'Displays hover information about the symbol')
        bind('n', '<Leader>r', vim.lsp.buf.rename, 'Renames all references to the symbol')
        bind('n', '<Leader>ca', vim.lsp.buf.code_action, 'Code action')
        bind('n', 'gs', vim.lsp.buf.signature_help, 'LSP signature help')
        bind('n', 'gd', '<Cmd>Telescope lsp_definitions<Cr>', 'LSP definitions')
        bind('n', 'gD', '<Cmd>Telescope lsp_type_definitions<Cr>', 'LSP type definitions')
        bind('n', 'gI', '<Cmd>Telescope lsp_implementations<Cr>', 'LSP implementations')
        bind('n', 'gr', '<Cmd>Telescope lsp_references<Cr>', 'LSP references')
        bind('n', '<Leader>gl', '<Cmd>Telescope diagnostics<Cr>', 'LSP diagnostics')

        bind({ 'n', 'v' }, '<Leader>f', function()
          require('conform').format { async = true, lsp_fallback = true }
        end, 'Format document')

        if vim.lsp.buf.range_code_action then
          bind('x', '<Leader>ca', vim.lsp.buf.range_code_action, 'Code action')
        else
          bind('x', '<Leader>ca', vim.lsp.buf.code_action, 'Code action')
        end

        bind('n', 'gl', vim.diagnostic.open_float, 'Open float diagnostic')
        bind('n', '[d', vim.diagnostic.goto_prev, 'Go to previous diagnostic')
        bind('n', ']d', vim.diagnostic.goto_next, 'Go to next diagnostic')
      end)

      local handlers = { lsp_zero.default_setup }
      local ensure_installed = {}

      for server, server_opts in pairs(opts.servers) do
        server_opts = server_opts == true and {} or server_opts
        if server_opts then lsp_zero.configure(server, server_opts) end
        table.insert(ensure_installed, server)
      end

      require('mason-lspconfig').setup {
        ensure_installed = ensure_installed,
        handlers = handlers,
      }
    end,
  },

  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lua',
      'f3fora/cmp-spell',
      'saadparwaiz1/cmp_luasnip',
      'b0o/schemastore.nvim',
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
    },
    config = function()
      local lsp_zero = require 'lsp-zero'
      lsp_zero.extend_cmp()

      local cmp = require 'cmp'
      local cmp_action = lsp_zero.cmp_action()

      require('luasnip.loaders.from_vscode').lazy_load()

      cmp.setup {
        sources = {
          { name = 'luasnip' },
          { name = 'nvim_lsp' },
          { name = 'nvim_lua' },
          { name = 'buffer' },
          { name = 'path' },
          { name = 'spell' },
        },
        formatting = lsp_zero.cmp_format(),
        mapping = cmp.mapping.preset.insert {
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-y>'] = cmp.mapping.confirm { select = true },
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          ['<C-f>'] = cmp_action.luasnip_jump_forward(),
          ['<C-b>'] = cmp_action.luasnip_jump_backward(),
        },
      }
    end,
  },

  {
    'stevearc/conform.nvim',
    cmd = 'ConformInfo',
    opts = {
      formatters_by_ft = {
        css = { { 'prettierd_css', 'stylelint' } },
        scss = { { 'prettierd_css', 'stylelint' } },
        javascript = { { 'prettierd_js', 'eslint_d' } },
        javascriptreact = { { 'prettierd_js', 'eslint_d' } },
        typescript = { { 'prettierd_js', 'eslint_d' } },
        typescriptreact = { { 'prettierd_js', 'eslint_d' } },
        liquid = { 'prettierd' },
        lua = { 'stylua' },
        sh = { 'shfmt' },
        bash = { 'shfmt' },
        zsh = { 'shfmt' },
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

      opts.formatters.eslint_d = {
        cwd = conform_util.root_file(lsp_util.insert_package_json({
          '.eslintrc.js',
          '.eslintrc.cjs',
          '.eslintrc.yaml',
          '.eslintrc.yml',
          '.eslintrc.json',
          'eslint.config.js',
          'eslint.config.ts',
        }, 'eslintConfig')),
        require_cwd = true,
      }

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

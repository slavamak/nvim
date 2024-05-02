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
    event = 'VeryLazy',
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
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    init = function()
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },

  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'folke/neodev.nvim',
      'VonHeikemen/lsp-zero.nvim',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'b0o/schemastore.nvim',
      'stevearc/conform.nvim',
      'j-hui/fidget.nvim',
    },
    opts = {
      servers = {
        ansiblels = {},
        astro = {},
        bashls = {
          filetypes = { 'sh', 'bash', 'zsh' },
        },
        cssls = {
          on_attach = function(client)
            client.server_capabilities.documentFormattingProvider = true
            client.server_capabilities.documentRangeFormattingProvider = true
          end,
        },
        denols = {
          root_dir = function(fname)
            local util = require 'lspconfig.util'
            return util.root_pattern('deno.json', 'deno.jsonc')(fname)
          end,
        },
        emmet_language_server = {},
        eslint = {},
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
        tsserver = {
          on_new_config = function(new_config, root_dir)
            local util = require 'lspconfig.util'
            local deno_config_exists = util.root_pattern('deno.json', 'deno.jsonc')
            if deno_config_exists(root_dir) then new_config.enabled = false end
          end,
        },
        yamlls = {
          on_attach = function(client)
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

      lsp_zero.on_attach(function(client, bufnr)
        vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, { desc = 'LSP code action', buffer = bufnr })
        if vim.lsp.buf.range_code_action then
          vim.keymap.set('x', '<Leader>ca', vim.lsp.buf.range_code_action, { desc = 'LSP code action', buffer = bufnr })
        else
          vim.keymap.set('x', '<Leader>ca', vim.lsp.buf.code_action, { desc = 'LSP code action', buffer = bufnr })
        end

        vim.keymap.set({ 'n', 'x' }, '<Leader>f', function()
          require('conform').format { async = true, lsp_fallback = true }
        end, { desc = 'LSP format document', buffer = bufnr })

        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'LSP display hover information', buffer = bufnr })
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = 'LSP display signature information', buffer = bufnr })
        vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, { desc = 'LSP rename all references', buffer = bufnr })
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'LSP jump to the definition', buffer = bufnr })
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'LSP jump to the declaration', buffer = bufnr })
        vim.keymap.set('n', '<Leader>D', vim.lsp.buf.type_definition, { desc = 'LSP jump to the definition of the type', buffer = bufnr })
        vim.keymap.set('n', 'gi', '<Cmd>Telescope lsp_implementations<Cr>', { desc = 'LSP lists all the implementations', buffer = bufnr })
        vim.keymap.set('n', 'gr', '<Cmd>Telescope lsp_references<Cr>', { desc = 'LSP lists all the references', buffer = bufnr })
      end)

      vim.keymap.set('n', '<Leader>q', vim.diagnostic.setqflist, { desc = 'Open diagnostic quickfix list' })
      vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, { desc = 'Open float diagnostic' })
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })

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

      require('lspconfig.ui.windows').default_options = {
        border = vim.g.border_chars,
      }

      vim.api.nvim_set_hl(0, 'LspInfoBorder', { link = 'FloatBorder' })
    end,
  },
}

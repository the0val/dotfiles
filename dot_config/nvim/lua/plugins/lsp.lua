return {
  {
    'neovim/nvim-lspconfig',
    lazy = false,
    dependencies = {
      'mason-org/mason.nvim',
    },
    config = function()
      vim.lsp.enable {
        'svelte',
        'cssls', --Mason css-lsp
        'elp',
        'gopls',
        'html',
        'jedi_language_server',
        'prettierd', --Mason prettired
        'lua_ls', --Mason lua-language-server
        'ts_ls', --Mason typescript-language-server
        'yamlls', --Mason yaml-language-server
      }
      vim.lsp.config('yamlls', {
        settings = {
          yaml = {
            validate = true,
            hover = true,
            completion = true,
          },
        },
      })
    end,
  },

  {
    'saghen/blink.cmp',
    version = '*',
    event = 'VimEnter',
    opts = {
      keymap = { preset = 'default' },
      completion = {
        list = {
          selection = { preselect = true, auto_insert = false },
        },
        ghost_text = { enabled = true },
      },
    },
  },

  {
    'L3MON4D3/LuaSnip',
    event = 'VeryLazy',
    version = 'v2.*',
    dependencies = { 'rafamadriz/friendly-snippets' },
  },

  {
    'mason-org/mason.nvim',
    cmd = 'Mason',
    opts = {},
  },

  {
    'folke/lazydev.nvim',
    opts = {
      library = { 'nvim-dap-ui' },
    },
    ft = 'lua',
  },

  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'black' },
        html = { 'prettier' },
        typescript = { 'prettierd' },
        javascript = { 'prettierd' },
      },
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        end
        return {
          timeout_ms = 500,
          lsp_format = 'fallback',
        }
      end,
    },
  },

  {
    'dgagn/diagflow.nvim',
    event = 'LspAttach',
    opts = {
      show_borders = true,
    },
  },

  {
    'folke/trouble.nvim',
    opts = {},
    cmd = 'Trouble',
    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>cs',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Symbols (Trouble)',
      },
      {
        '<leader>cl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
      },
      {
        '<leader>xL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xQ',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
    },
  },

  {
    'immanuwell/droast.nvim',
    cmd = { 'DroastLint', 'DroastQuickfix' },
  },
}

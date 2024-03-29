-- autoformat.lua
--
-- Use your language server to automatically format your code on save.
-- Adds additional commands as well to manage the behavior

return {
  'neovim/nvim-lspconfig',
  config = function()
    -- Switch for controlling whether you want autoformatting.
    --  Use :KickstartFormatToggle to toggle autoformatting on or off
    local format_is_enabled = true
    vim.api.nvim_create_user_command('KickstartFormatToggle', function()
      format_is_enabled = not format_is_enabled
      print('Setting autoformatting to: ' .. tostring(format_is_enabled))
    end, {})

    -- Create an augroup that is used for managing our formatting autocmds.
    --      We need one augroup per client to make sure that multiple clients
    --      can attach to the same buffer without interfering with each other.
    local _augroups = {}
    local get_augroup = function(client)
      if not _augroups[client.id] then
        local group_name = 'kickstart-lsp-format-' .. client.name
        local id = vim.api.nvim_create_augroup(group_name, { clear = true })
        _augroups[client.id] = id
      end

      return _augroups[client.id]
    end

    local function useFormatter(client, bufnr)
      vim.api.nvim_create_autocmd('BufWritePost', {
        group = get_augroup(client),
        buffer = bufnr,
        callback = function()
          if not format_is_enabled then
            return
          end

          require('formatter.format').format('', '', 1, vim.api.nvim_buf_line_count(bufnr), { write = true })
        end,
      })
    end

    -- Whenever an LSP attaches to a buffer, we will run this function.
    --
    -- See `:help LspAttach` for more information about this autocmd event.
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach-format', { clear = true }),
      -- This is where we attach the autoformatting for reasonable clients
      callback = function(args)
        local client_id = args.data.client_id
        local client = vim.lsp.get_client_by_id(client_id)
        local bufnr = args.buf

        -- Only attach to clients that support document formatting
        if not client.server_capabilities.documentFormattingProvider then
          return
        end

        -- List of lsp clients for which mhartington/formatter.nvim should be used instead of the lsp included one.
        local formatterClients = { 'tsserver', 'html', 'lua_ls' }
        for _, v in ipairs(formatterClients) do
          if client.name == v then
            useFormatter(client, bufnr)
            return
          end
        end

        print(client.name)

        -- Create an autocmd that will run *before* we save the buffer.
        --  Run the formatting command for the LSP that has just attached.
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = get_augroup(client),
          buffer = bufnr,
          callback = function()
            if not format_is_enabled then
              return
            end

            vim.lsp.buf.format {
              async = false,
              filter = function(c)
                return c.id == client.id
              end,
            }
          end,
        })
      end,
    })
  end,
  dependencies = {
    'mhartington/formatter.nvim',
    config = function()
      local format_is_enabled = true
      vim.api.nvim_create_user_command('AutoFormatterToggle', function()
        format_is_enabled = not format_is_enabled
        print('Setting autoformatting to: ' .. tostring(format_is_enabled))
      end, {})

      require('formatter').setup {
        filetype = {
          lua = require('formatter.filetypes.lua').stylua,
          go = require('formatter.filetypes.go').goimports,
          java = function()
            return {
              exe = os.getenv 'HOME' .. '/.local/share/nvim/mason/packages/google-java-format/google-java-format',
              args = {
                '-',
              },
              stdin = true,
            }
          end,
          typescript = require('formatter.filetypes.typescript').prettier,
          html = require('formatter.filetypes.html').prettier,
        },
      }
    end,
  },
}

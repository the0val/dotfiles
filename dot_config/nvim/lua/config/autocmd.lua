-- Remove the empty neo-tree buffer that gets restored with the session.
vim.api.nvim_create_autocmd('SessionLoadPost', {
  group = vim.api.nvim_create_augroup('clear-neo-tree', { clear = true }),
  callback = function()
    -- Defer because otherwise highlighting breaks for current file
    vim.defer_fn(function()
      local buffers = vim.api.nvim_list_bufs()
      for _, b in pairs(buffers) do
        local name = vim.api.nvim_buf_get_name(b)
        if string.find(name, 'neo') then
          vim.api.nvim_buf_delete(b, {})
          return
        end
      end
    end, 0)
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'norg', 'markdown' },
  callback = function()
    vim.opt_local.wrap = true
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'norg',
  callback = function()
    vim.opt_local.conceallevel = 2
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'svelte', 'typescript', 'javascript', 'lua' },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 2
  end,
})

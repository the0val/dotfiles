vim.api.nvim_create_autocmd('BufEnter', {
  pattern = 'copilot-*',
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
    vim.opt_local.conceallevel = 0
  end,
})

-- imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
-- let g:copilot_no_tab_map = v:true

return {
  {
    'github/copilot.vim',
    cmd = 'Copilot',
    lazy = false,
    keys = {
      {
        '<leader>gt',
        function()
          -- Write logic to check if Copilot is active and toggle it accordingly
          local is_active = vim.g.copilot_enabled ~= 0
          if is_active then
            vim.g.copilot_enabled = 0
            print 'Copilot disabled'
          else
            vim.g.copilot_enabled = 1
            print 'Copilot enabled'
          end
        end,
        desc = 'Toggle Copilot',
      },
    },
  },

  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'zbirenbaum/copilot.lua',
    },
    build = 'make tiktoken',
    opts = {
      window = {
        title = '🤖 AI Assistant',
      },
    },
    cmd = {
      'CopilotChat',
      'CopilotChatExplain',
      'CopilotChatReview',
    },
    keys = {
      { '<leader>gcc', '<cmd>CopilotChat<cr>', desc = 'Open Copilot Chat' },
      { '<leader>gce', '<cmd>CopilotChatExplain<cr>', desc = 'Copilot Explain' },
      { '<leader>gcr', '<cmd>CopilotChatReview<cr>', desc = 'Copilot Review' },
    },
  },
}

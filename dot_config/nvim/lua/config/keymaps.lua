local function map(lhs, rhs, desc, mode)
  desc = desc or ''
  mode = mode or 'n'
  vim.keymap.set(mode, lhs, rhs, { desc = desc })
end

--vim.keymap.del('n', '<backspace>')
map('<esc>', '<cmd>nohlsearch<CR>')
map('+', '"+', '', { 'n', 'x' })
map('<leader>a', '<C-^>', 'Alternate File')
map('<esc><esc>', '<C-\\><C-n>', 'Escpe terminal', 't')

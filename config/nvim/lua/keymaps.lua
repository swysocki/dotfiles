-- my keymaps

vim.g.mapleader = ','

-- stolen from https://github.com/brainfucksec/neovim-lua/blob/main/nvim/lua/core/keymaps.lua
local function map(mode, lhs, rhs)
  local options = {noremap = true, silent = true}
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('', '<F6>', ':NvimTreeToggle<CR>', {})

map('n', '<leader>ff', ':Telescope find_files<CR>')
map('n', '<leader>fg', ':Telescope live_grep<CR>')
map('n', '<leader>fb', ':Telescope buffers<CR>')
map('n', '<leader>fh', ':Telescope help_tags<CR>')

map('n', '<leader>bn', ':bn<CR>')
map('n', '<leader>bp', ':bp<CR>')
map('n', '<leader>bd', ':bd<CR>')
map('n', '<leader>c', ':noh<CR>')

map('t', '<Esc>', '<C-\\><C-n>')

map('n', '<leader>s', ':w<CR>')

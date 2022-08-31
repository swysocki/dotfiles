-- my keymaps

vim.g.mapleader = ','

-- stolen from https://github.com/brainfucksec/neovim-lua/blob/main/nvim/lua/core/keymaps.lua
km_opts = {noremap = true, silent = true}
local function map(mode, lhs, rhs, opts)
  if opts then
    options = vim.tbl_extend('force', km_opts, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, km_opts)
end

map('', '<F6>', ':NvimTreeToggle<CR>', {})

-- telescope
map('n', '<leader>ff', ':Telescope find_files<CR>')
map('n', '<leader>fg', ':Telescope live_grep<CR>')
map('n', '<leader>fb', ':Telescope buffers<CR>')
map('n', '<leader>fh', ':Telescope help_tags<CR>')

-- buffers
map('n', '<leader>bn', ':bn<CR>')
map('n', '<leader>bp', ':bp<CR>')
map('n', '<leader>bd', ':bd<CR>')
map('n', '<leader>c', ':noh<CR>')

map('t', '<Esc>', '<C-\\><C-n>')

map('n', '<leader>s', ':w<CR>')

-- Neovim configuration in Lua

-- Setup lazy.nvim package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set leader key
vim.g.mapleader = ","

-- Basic settings
vim.opt.exrc = true
vim.opt.secure = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.swapfile = false
vim.opt.updatetime = 300
vim.opt.list = true
vim.opt.listchars = { tab = '▸ ', trail = '·', precedes = '←', extends = '→' }
vim.opt.wildoptions = 'pum'
vim.opt.fillchars = { vert = '▏' }
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.termguicolors = true
vim.opt.completeopt = 'menu,menuone,noselect,noinsert'

-- Netrw settings
vim.g.netrw_winsize = 25
vim.g.netrw_banner = 0
vim.g.netrw_keepdir = 0

-- Keymaps
vim.keymap.set('n', '<F6>', ':Lexplore<CR>', { silent = true })
vim.keymap.set('n', '<leader>c', ':noh<CR>', { silent = true })

-- Plugin configuration
require("lazy").setup({
  'tpope/vim-fugitive',
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    end,
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      -- LSP configuration will go here
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('nvim-treesitter.config').setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
        highlight = { enable = true },
      })
    end
  },

})

vim.cmd.colorscheme "habamax"

-- Autocmd for filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"json", "jsonnet", "shell", "python"},
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.expandtab = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        vim.opt_local.foldmethod = "indent"
        vim.opt_local.foldnestmax = 1
    end,
})

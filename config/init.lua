vim.opt.number = true
vim.opt.cursorline = true
vim.opt.list = true
vim.opt.listchars = {
    tab = '▸ ',
    trail = '·',
    precedes = '←',
    extends = '→',
    eol = '↵'
}
vim.opt.updatetime = 300
vim.g.mapleader = ','

local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.local/share/nvim/plugged')
Plug 'ellisonleao/gruvbox.nvim'
Plug 'tpope/vim-fugitive'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug('nvim-treesitter/nvim-treesitter', {['do'] = 'TSUpdate'})
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'lewis6991/gitsigns.nvim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'jose-elias-alvarez/null-ls.nvim'
vim.call('plug#end')

vim.cmd [[
autocmd FileType yaml,yml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType sh setlocal ts=4 sts=4 sw=4 expandtab
autocmd BufNewFile,BufRead "dev-ac*" set ft=sh

colorscheme gruvbox

set completeopt=menu,menuone,noselect

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldminlines=5
]]
require("null-ls").setup({
    sources = {
        require("null-ls").builtins.formatting.black,
        require("null-ls").builtins.formatting.shfmt,
        require("null-ls").builtins.formatting.lua_format,
	require("null-ls").builtins.formatting.isort, 
	require("null-ls").builtins.diagnostics.yamllint,
        require("null-ls").builtins.diagnostics.shellcheck,
        require("null-ls").builtins.diagnostics.flake8.with({
            extra_args = {"--max-line-length", "88", "--extend-ignore", "E203"}
        })
    }
})
require('nvim-tree').setup()
require('gitsigns').setup()
local cmp = require 'cmp'
cmp.setup({
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered()
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        -- Accept currently selected item. Set `select` to `false`
        -- to only confirm explicitly selected items.
        ['<CR>'] = cmp.mapping.confirm({select = true})
    }),
    sources = cmp.config.sources({{name = 'nvim_lsp'}}, {{name = 'buffer'}})
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {'documentation', 'detail', 'additionalTextEdits'}
}

require('lspconfig').terraformls.setup {capabilities = capabilities}

require('gitsigns').setup()

require('nvim-treesitter.configs').setup {
    highlight = {enable = true, additional_vim_regex_highlighting = false},
    indent = {enable = true}
}

require('lspconfig').pyright.setup {}

local opts = {noremap = true, silent = true}
-- lsp keybindings
vim.api.nvim_set_keymap('n', '<space>e',
                        '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>r', '<cmd>lua vim.lsp.buf.rename()<CR>',
                        opts)

-- nvim tree keybindings
vim.api.nvim_set_keymap('', '<F6>', ':NvimTreeToggle <CR>', {})

-- telescope keybindings
vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files <CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>fg', ':Telescope live_grep <CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>fb', ':Telescope buffers<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>fh', ':Telescope help_tags<CR>', opts)

-- buffer keybindings
vim.api.nvim_set_keymap('n', '<leader>bn', ':bn<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>bp', ':bp<cr>', opts)

-- null-ls keybindings
vim.api.nvim_set_keymap('n', '<space>fo',
                        '<cmd>lua vim.lsp.buf.formatting_sync(nil, 10000)<cr>',
                        opts)

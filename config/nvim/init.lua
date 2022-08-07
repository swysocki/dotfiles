local o = vim.opt
o.number = true
o.cursorline = true
o.list = true
o.listchars = {
    tab = '▸ ',
    trail = '·',
    precedes = '←',
    extends = '→',
    eol = '↵'
}
o.updatetime = 300
vim.g.mapleader = ','

vim.filetype.add({
  extension = {
    jsonnet = "jsonnet",
    libsonnet = "jsonnet",
  },
  pattern = {
    ["*.jsonnet.TEMPLATE"] = "jsonnet"
  }
})

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
Plug 'google/vim-jsonnet'
vim.call('plug#end')

vim.cmd [[
autocmd BufNewFile,BufRead "dev-ac*" set ft=sh

colorscheme gruvbox

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


require('nvim-treesitter.configs').setup {
    ensure_installed = { "python", "yaml", "bash", "lua" },
    sync_install = false,
    auto_install = true,
    highlight = {enable = true, additional_vim_regex_highlighting = false},
    indent = {enable = true}
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {'documentation', 'detail', 'additionalTextEdits'}
}
local opts = {noremap = true, silent = true}
vim.api.nvim_set_keymap('', '<F6>', ':NvimTreeToggle <CR>', {})
vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files <CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>fg', ':Telescope live_grep <CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>fb', ':Telescope buffers<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>fh', ':Telescope help_tags<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>bn', ':bn<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>bp', ':bp<cr>', opts)

local on_attach = function(client, bufnr)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.api.nvim_set_keymap('n', '<space>e',
                            '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    vim.api.nvim_set_keymap('n', '<space>rn',
                            '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_set_keymap('n', '<space>f',
                            '<cmd>lua vim.lsp.buf.formatting_sync(nil, 10000)<cr>',
                            opts)
end

require('lspconfig').pyright.setup {
    on_attach = on_attach,
    capabilities = capabilities
}
require('lspconfig').jsonnet_ls.setup {
    capabilities = capabilities,
    on_attach = on_attach
}

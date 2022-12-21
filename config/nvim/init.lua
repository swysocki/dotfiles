require('keymaps')
require('options')

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
Plug 'shaunsingh/nord.nvim'
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
Plug 'feline-nvim/feline.nvim'
vim.call('plug#end')

vim.cmd [[
autocmd BufNewFile,BufRead "dev-ac*" set ft=sh

colorscheme nord
]]

require('feline').setup()

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

vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, km_opts)

local on_attach = require('keymaps')

require('lspconfig').pyright.setup {
    on_attach = on_attach,
    capabilities = capabilities
}
require('lspconfig').jsonnet_ls.setup {
    capabilities = on_attach,
    on_attach = on_attach
}

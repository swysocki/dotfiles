set number
set list listchars=tab:▸\ ,trail:·,precedes:←,extends:→
set cursorline

set updatetime=300
let mapleader=","
autocmd FileType yaml,yml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType sh setlocal ts=4 sts=4 sw=4 expandtab
autocmd BufNewFile,BufRead "dev-ac*" set ft=sh
call plug#begin('~/.local/share/nvim/plugged')
  Plug 'ellisonleao/gruvbox.nvim'
  Plug 'tpope/vim-fugitive'
  Plug 'dense-analysis/ale'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate' }
  Plug 'google/vim-jsonnet'
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'kyazdani42/nvim-tree.lua' " requires a patched font from nerdfonts
call plug#end()

colorscheme gruvbox

let g:ale_fixers = {
\  'python' :['isort', 'black'],
\  'sh' :['shfmt']
\}
let g:ale_linters = {
\  'python' :['flake8']
\}
let g:ale_fix_on_save = 1
let g:ale_python_flake8_options = '--max-line-length=88'
let g:ale_sh_shfmt_options = '-ci -i 4'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1

set completeopt=menu,menuone,noselect

" set folds
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldminlines=5

lua <<EOF
require('nvim-tree').setup()
require('gitsigns').setup()
local cmp = require'cmp'
cmp.setup({
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      -- Accept currently selected item. Set `select` to `false`
      -- to only confirm explicitly selected items.
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
    }, {
      { name = 'buffer' },
    })
  })

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}

require('lspconfig').terraformls.setup {
  capabilities = capabilities
}

require('gitsigns').setup()

require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
}

require('lspconfig').pyright.setup{}
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
EOF

map <F6> :NvimTreeToggle <CR>

" Find files using Telescope command-line
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
" Buffer shortcuts
nnoremap <silent> <leader>bn :bn<cr>
nnoremap <silent> <leader>bp :bp<cr>

set number
set list listchars=tab:▸\ ,trail:·,precedes:←,extends:→
set cursorline
" decrease the time it takes for hover events in Ale
" default is 4000
set updatetime=300
let mapleader=","
autocmd FileType yaml,yml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType sh setlocal ts=4 sts=4 sw=4 expandtab
autocmd BufNewFile,BufRead "dev-ac*" set ft=sh
call plug#begin('~/.local/share/nvim/plugged')
  Plug 'kaicataldo/material.vim', { 'branch': 'main' }
  Plug 'tpope/vim-fugitive'
  Plug 'dense-analysis/ale'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate' }
call plug#end()

colorscheme material

" set folds
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldminlines=5

" npm install -g pyright
" pipx install isort, black, flake8
let g:ale_completion_enabled = 1
let g:ale_fixers = {
\  'python' :['isort', 'black'],
\  'sh' :['shfmt']
\}
let g:ale_fix_on_save = 1
let g:ale_linters = {
\  'python' :['flake8', 'pyright'],
\  'html' :['prettier']
\}
let g:ale_python_auto_poetry = 1
let g:ale_python_pyls_executable = "pyright"
let g:ale_python_flake8_options = '--max-line-length=88'
let g:ale_sh_shfmt_options = '-ci -i 4'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1

" trendy error symbols
let g:ale_sign_error = "◉"
let g:ale_sign_warning = "▲"
highlight ALEErrorSign ctermfg=131 ctermbg=none

" make the error background less jarring
highlight ALEError ctermbg=131


lua <<EOF
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
}
EOF

" Setup the file explorer (netrw)
let g:netrw_banner = 0
let g:netrw_winsize = 20
let g:netrw_browse_split = 4
let g:netrw_liststyle = 3

" Toggle netrw
function! ToggleExplorer()
  Lexplore
endfunction
map <silent> <F6> :call ToggleExplorer() <CR>

" Find files using Telescope command-line
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
" Ale shortcuts for code navigation
nnoremap <leader>fr <cmd>ALEFindReferences<cr>
nnoremap <leader>gd <cmd>ALEGoToDefinition<cr>
nnoremap <leader>mv <cmd>ALERename<cr>
" Buffer shortcuts
nnoremap <silent> <leader>bn :bn<cr>
nnoremap <silent> <leader>bp :bp<cr>

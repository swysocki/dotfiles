set nofoldenable
set number
set list listchars=tab:▸\ ,trail:·,precedes:←,extends:→
set cursorline
" decrease the time it takes for hover events in Ale
" default is 4000
set updatetime=300
let mapleader=","
autocmd FileType yaml,yml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType sh setlocal ts=4 sts=4 sw=4 expandtab
call plug#begin('~/.local/share/nvim/plugged')
  Plug 'kaicataldo/material.vim', { 'branch': 'main' }
  Plug 'tpope/vim-fugitive'
  Plug 'dense-analysis/ale'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
call plug#end()

colorscheme material

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

" trendy error symbol
let g:ale_sign_error = "◉"
highlight ALEErrorSign ctermfg=131 ctermbg=none

" make the error background less jarring
highlight ALEError ctermbg=131

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

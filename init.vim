set nofoldenable
set number
set list listchars=tab:▸\ ,trail:·,precedes:←,extends:→
set cursorline
autocmd FileType yaml,yml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType sh setlocal ts=4 sts=4 sw=4 expandtab
call plug#begin('~/.local/share/nvim/plugged')
  Plug 'kaicataldo/material.vim', { 'branch': 'main' }
  Plug 'tpope/vim-fugitive'
  Plug 'dense-analysis/ale'
call plug#end()
colorscheme material
" pipx install isort, black, flake8
let g:ale_completion_enabled = 1
let g:ale_fixers = {'python' :['isort', 'black']}
let g:ale_fix_on_save = 1
let g:ale_linters = {'python' :['flake8', 'pyls']}
let g:ale_python_flake8_options = '--max-line-length=88'
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

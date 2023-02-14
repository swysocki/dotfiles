" setup plugins using vim-plug
"
call plug#begin()
Plug 'dense-analysis/ale'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'arcticicestudio/nord-vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'google/vim-jsonnet'
Plug 'sheerun/vim-polyglot'
call plug#end()

" disable Vi mode
setglobal nocompatible

" set numbers to be shown and relative to the cursor
set number relativenumber

" disable swap files, live dangerously
set noswapfile

" decrease the time it takes for hover events
set updatetime=300

" make whitespace characters appear
set list listchars=tab:▸\ ,trail:·,precedes:←,extends:→

" the nord colorscheme requires termguicolors to be compiled in Vim
if exists('+termguicolors')
    set termguicolors
    colorscheme dracula " nord
endif


" custom function keymaps
nnoremap <F1> :ALEFix<CR>
nnoremap <F2> :ALERename<CR>
nnoremap <F3> :ALEGoToDefinition<CR>
nnoremap <F6> :Lexplore<CR>

" custom leader keymaps
let g:mapleader = ","
map <leader>c :noh<CR>
map <leader>fb :Buffers<CR>
map <leader>ff :Files<CR>
map <leader>fg :Rg<CR>

" extra filetypes not handled by default
autocmd FileType json,jsonnet setlocal shiftwidth=4 softtabstop=4 expandtab
autocmd FileType shell setlocal shiftwidth=4 softtabstop=4 expandtab
autocmd FileType python setlocal colorcolumn=89

" Ale configuration
let g:ale_completion_enabled = 1
" this puts the ALEHover info in a preview popup instead of the preview windows
let g:ale_hover_to_floating_preview = 1
set completeopt=menu,menuone,popup,noselect,noinsert
set omnifunc=ale#completion#OmniFunc

augroup ale_hover_cursor
  autocmd!
  autocmd CursorHold * ALEHover
augroup END

let g:ale_fixers = {
\  'python' :['isort', 'black'],
\  'sh' :['shfmt'],
\  'json' :['jq']
\}

let g:ale_linters = {
\  'python' :['flake8', 'pyright']
\}

let g:ale_python_flake8_options = '--max-line-length=88'
let g:ale_sh_shfmt_options = '-ci -i 4'

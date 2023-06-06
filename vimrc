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

" vertical 'wildmenu' options
set wildoptions=pum

" change the split window divider to a single, thin line
set fillchars+=vert:\▏

" the nord colorscheme requires termguicolors to be compiled in Vim
if exists('+termguicolors')
    set termguicolors
    colorscheme nord
    if $TERM_PROGRAM == "Apple_Terminal"
      set notermguicolors
    endif
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
map <leader>fh :History:<CR>

" extra filetypes not handled by default
autocmd FileType json,jsonnet setlocal shiftwidth=4 softtabstop=4 expandtab
autocmd FileType shell setlocal shiftwidth=4 softtabstop=4 expandtab
autocmd FileType python setlocal colorcolumn=89 foldmethod=indent foldnestmax=1

" ALE configuration

" enabled built in completion
let g:ale_completion_enabled = 1
" increase the completion suggestions in hopes that we are given the symbol
" we are looking for. It would be great to get some type of suggestion
" ordering so that 'text' suggestions don't take up all of the completions
let g:ale_completion_max_suggestions = 150
" remove the + - + preview borders
let g:ale_floating_window_border = []
" this puts the ALEHover info in a preview popup instead of the preview windows
let g:ale_hover_to_floating_preview = 1
"set completeopt=menu,menuone,popup,noselect,noinsert
set completeopt=menu,menuone,noselect,noinsert
set omnifunc=ale#completion#OmniFunc

" augroup ale_hover_cursor
"   autocmd!
"   autocmd CursorHold * ALEHover
" augroup END

" fancy symbols for autocomplete
let g:ale_completion_symbols = {
  \ 'text': '',
  \ 'method': '',
  \ 'function': '',
  \ 'constructor': '',
  \ 'field': '',
  \ 'variable': '',
  \ 'class': '',
  \ 'interface': '',
  \ 'module': '',
  \ 'property': '',
  \ 'unit': 'unit',
  \ 'value': 'val',
  \ 'enum': '',
  \ 'keyword': 'keyword',
  \ 'snippet': '',
  \ 'color': 'color',
  \ 'file': '',
  \ 'reference': 'ref',
  \ 'folder': '',
  \ 'enum member': '',
  \ 'constant': '',
  \ 'struct': '',
  \ 'event': 'event',
  \ 'operator': '',
  \ 'type_parameter': 'type param',
  \ '<default>': 'v'
  \ }

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

function! OpenMarkdownFirefox()
  silent !clear
  execute "silent !open -a firefox %"
  redraw!
endfunction

nnoremap <buffer> <leader>md :call OpenMarkdownFirefox()<cr>

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
	colorscheme nord
endif

" fzf setup
if has('macunix')
    set rtp+=/usr/local/opt/fzf
elseif has('win32') || has('unix')
    set rtp+=~/.fzf
endif

" extra filetypes not handled by default
autocmd FileType json,jsonnet setlocal shiftwidth=4 softtabstop=4 expandtab
autocmd FileType shell setlocal shiftwidth=4 softtabstop=4 expandtab

" Ale configuration
let g:ale_completion_enabled = 1
let g:ale_hover_to_floating_preview = 1
set completeopt=menu,menuone,popup,noselect,noinsert
set omnifunc=ale#completion#OmniFunc

let g:ale_fixers = {
\  'python' :['isort', 'black'],
\  'sh' :['shfmt']
\}

let g:ale_linters = {
\  'python' :['flake8', 'pyright']
\}

let g:ale_python_flake8_options = '--max-line-length=88'
let g:ale_sh_shfmt_options = '-ci -i 4'

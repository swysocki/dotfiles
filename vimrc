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

"set completeopt=menu,menuone,popup,noselect,noinsert
set completeopt=menu,menuone,noselect,noinsert

" ALE configuration

" disable completion and LSP 
let g:ale_completion_enabled = 0
let g:ale_disable_lsp = 1

let g:ale_fixers = {
\  'python' :['isort', 'black'],
\  'sh' :['shfmt'],
\  'json' :['jq']
\}

let g:ale_linters = {
\  'python' :['flake8']
\}

let g:ale_python_flake8_options = '--max-line-length=88'
let g:ale_sh_shfmt_options = '-ci -i 4'

function! OpenMarkdownFirefox()
  silent !clear
  execute "silent !open -a firefox %"
  redraw!
endfunction

nnoremap <buffer> <leader>md :call OpenMarkdownFirefox()<cr>

" yegappan/lsp
"
" has to be installed manually for `packadd` to work
packadd lsp

call LspAddServer([#{
\ name: 'pyright',
\ filetype: 'python',
\ path: '/usr/local/bin/pyright-langserver',
\ args: ['--stdio'],
\ workspaceConfig: #{
\  python: #{
\    pythonPath: 'python'
\  }}
\ }])

" fancy symbols for autocomplete
call LspOptionsSet(#{
\ customCompletionKinds: v:true,
\ completionKinds: {
\ 'Text': '',
\ 'Method': '',
\ 'Function': '',
\ 'Constructor': '',
\ 'Field': '',
\ 'Variable': '',
\ 'Class': '',
\ 'Interface': '',
\ 'Module': '',
\ 'Property': '',
\ 'Unit': 'unit',
\ 'Value': 'val',
\ 'Enum': '',
\ 'Keyword': 'keyword',
\ 'Snippet': '',
\ 'Color': 'color',
\ 'File': '',
\ 'Reference': 'ref',
\ 'Folder': '',
\ 'Enum member': '',
\ 'Constant': '',
\ 'Struct': '',
\ 'Event': 'event',
\ 'Operator': '',
\ }
\})

" need to add the logic to only add this mapping when
" the LSP is active
nnoremap <silent> K :LspHover<CR>

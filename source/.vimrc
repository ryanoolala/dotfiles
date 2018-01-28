set number! relativenumber! 
set backspace=indent,eol,start
set ruler
syntax on
set hlsearch
if has('nvim') || has('termguicolors')
  set termguicolors
endif

let g:lightline = { 'colorscheme': 'flatcolor' }


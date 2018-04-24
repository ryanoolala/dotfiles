set number! relativenumber! 
set backspace=indent,eol,start
set ruler
syntax on
set hlsearch
noremap ; l
noremap l k
noremap k j
noremap j h

if has('nvim') || has('termguicolors')
  set termguicolors
endif

let g:lightline = { 'colorscheme': 'flatcolor' }


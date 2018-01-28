
"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

if has('nvim') || has('termguicolors')
  set termguicolors
endif

" Required:
set runtimepath+=/Users/gohjiaquan/.local/share/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/Users/gohjiaquan/.local/share/dein')
  call dein#begin('/Users/gohjiaquan/.local/share/dein')

  " Let dein manage dein
  " Required:
  call dein#add('/Users/gohjiaquan/.local/share/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')

  " You can specify revision/branch/tag.
  call dein#add('Shougo/vimshell', { 'rev': '3787e5' })
  call dein#add('MaxSt/FlatColor')
  call dein#add('itchyny/lightline.vim')
  call dein#add('cocopon/iceberg.vim')
  call dein#add('vifm/vifm')
  call dein#add('ctrlpvim/ctrlp.vim')

  " Required:
  call dein#end()
  call dein#save_state()
endif

"Ctrl + ] to change tabs
nmap <C-]> :tabn<cr>
nmap <C-[> :tabp<cr>
nmap n :m +1<CR>
nmap m :m -2<CR>
set tabstop=4 softtabstop=0 expandtab shiftwidth=2 smarttab

" Required:
filetype plugin indent on
syntax enable
colorscheme Flatcolor
"colorscheme Iceberg
let g:lightline = { 'colorscheme': 'flatcolor' }

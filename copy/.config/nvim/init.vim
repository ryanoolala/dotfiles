noremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
set noswapfile
set tabstop=2 shiftwidth=2 expandtab
noremap ; l
noremap l k
noremap k j
noremap j h
nnoremap <A-j> <C-w>h
nnoremap <A-k> <C-w>j
nnoremap <A-l> <C-w>k
nnoremap <A-;> <C-w>l

call plug#begin("~/.config/nvim/plugged")
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'ryanoasis/vim-devicons'
Plug 'mileszs/ack.vim'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'w0rp/ale'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'flazz/vim-colorschemes'
Plug 'hashivim/vim-terraform'
Plug 'juliosueiras/vim-terraform-completion'
Plug 'leafgarland/typescript-vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
call plug#end()

" neosnippet
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
" imap <C-k>     <Plug>(neosnippet_expand_or_jump)
" smap <C-k>     <Plug>(neosnippet_expand_or_jump)
" xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
" \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" inoremap <silent><expr><CR> pumvisible() ? deoplete#mappings#close_popup()."\<Plug>(neosnippet_expand_or_jump)" : "\<CR>"
let g:neosnippet#enable_completed_snippet = 1
imap <expr><TAB>
 \ pumvisible() ? "\<C-n>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
 \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" Expands or completes the selected snippet/item in the popup menu
imap <expr><silent><CR> pumvisible() ? deoplete#mappings#close_popup() .
      \ "\<Plug>(neosnippet_jump_or_expand)" : "\<CR>"
smap <silent><CR> <Plug>(neosnippet_jump_or_expand)


" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

if &t_Co > 2 || has("gui_running")
  set number! relativenumber!
  set wildmenu
  set wildmode=longest,list,full
  syntax on
  set hlsearch
endif



" colorscheme Tomorrow-Night-Eighties
let g:seoul256_background = 233
colorscheme seoul256

" ale linter
let g:ale_fixers = {
      \  'javascript': ['eslint'],
      \  'terraform': ['tflint'],
      \}
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:airline#extensions#ale#enabled = 1
let g:ale_lint_delay = 600

" ctrlp
set runtimepath^=~/.config/nvim/bundle/ctrlp.vim
let g:ctrlp_show_hidden = 1

" Close nvim if nerdtree is the only open window
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let NERDTreeMapActivateNode='<space>'
let NERDTreeShowHidden=1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
" Open NerdTree when nvim opens a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" Auto exit if NerdTree is the only window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" Terraform stuff
source ~/.config/nvim/src/terraform.vim

let g:deoplete#omni_patterns = {}
let g:deoplete#omni_patterns.terraform = '[^ *\t"{=$]\w*'
let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"


" Remove whitespace trails
function! StripTrailingWhitespace()
  normal mZ
  let l:chars = col("$")
  %s/\s\+$//e
  if (line("'Z") != line(".")) || (l:chars != col("$"))
    echo "Trailing whitespace stripped\n"
  endif
  normal `Z
endfunction
" Remap for destroying trailing whitespace cleanly
:nnoremap <Leader>w :let _save_pos=getpos(".") <Bar>
    \ :let _s=@/ <Bar>
    \ :%s/\s\+$//e <Bar>
    \ :let @/=_s <Bar>
    \ :nohl <Bar>
    \ :unlet _s<Bar>
    \ :call setpos('.', _save_pos)<Bar>
    \ :unlet _save_pos<CR><CR>
autocmd BufWritePre * call StripTrailingWhitespace()

" yank across files
vmap <silent> ,y y:new<CR>:call setline(1,getregtype())<CR>o<Esc>P:wq! ~/reg.txt<CR>
nmap <silent> ,y :new<CR>:call setline(1,getregtype())<CR>o<Esc>P:wq! ~/reg.txt<CR>
map <silent> ,p :sview ~/reg.txt<CR>"zdddG:q!<CR>:call setreg('"', @", @z)<CR>p
map <silent> ,P :sview ~/reg.txt<CR>"zdddG:q!<CR>:call setreg('"', @", @z)<CR>P

" tab for different file types
" shell (tab width 2 chr)
autocmd FileType sh set sw=2
autocmd FileType sh set ts=2
autocmd FileType sh set sts=2
autocmd FileType sh set textwidth=0 expandtab
autocmd FileType sh map <buffer> <C-S-e> :w<CR>:!/bin/sh % <CR>
" ruby (tab width 2 chr)
autocmd FileType ruby set sw=2
autocmd FileType ruby set ts=2
autocmd FileType ruby set sts=2
autocmd FileType ruby map <buffer> <C-S-e> :w<CR>:!/usr/bin/env ruby % <CR>
" HTML (tab width 2 chr, no wrapping)
autocmd FileType html,htmldjango set sw=2
autocmd FileType html,htmldjango set ts=2
autocmd FileType html,htmldjango set sts=2
autocmd FileType html,htmldjango set textwidth=0 expandtab
" YAML (tab width 2 chr, no wrapping)
autocmd FileType yaml set sw=2
autocmd FileType yaml set ts=2
autocmd FileType yaml set sts=2
autocmd FileType yaml set textwidth=0 expandtab
" terraform (tab width 2 chr, no wrapping)
autocmd FileType tf set sw=2
autocmd FileType tf set ts=2
autocmd FileType tf set sts=2
autocmd FileType tf set textwidth=0 expandtab
" Python (tab width 4 chr)
autocmd FileType python set sw=4
autocmd FileType python set ts=4
autocmd FileType python set sts=4
autocmd FileType python map <buffer> <C-S-e> :w<CR>:!/usr/bin/env python % <CR>
" CSS (tab width 2 chr)
autocmd FileType css set sw=2
autocmd FileType css set ts=2
autocmd FileType css set sts=2
" JavaScript (tab width 2 chr)
autocmd FileType javascript set sw=2
autocmd FileType javascript set ts=2
autocmd FileType javascript set sts=2
autocmd FileType javascript set textwidth=0 expandtab
autocmd FileType javascript map <buffer> <C-S-e> :w<CR>:!/usr/bin/env node % <CR>

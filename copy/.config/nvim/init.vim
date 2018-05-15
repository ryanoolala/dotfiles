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
let g:deoplete#enable_at_startup = 1

" Plug 'francoiscabrol/ranger.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'mileszs/ack.vim'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'w0rp/ale'
Plug 'flazz/vim-colorschemes'
call plug#end()

if &t_Co > 2 || has("gui_running")
  set number! relativenumber! 
  set wildmenu
  set wildmode=longest,list,full
  syntax on
  set hlsearch
endif

colorscheme Tomorrow-Night-Eighties

" let g:ale_fixers = {
"   'javascript': ['eslint'],
" }

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

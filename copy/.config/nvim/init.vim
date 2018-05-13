noremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
set noswapfile
set tabstop=2 shiftwidth=2 expandtab
noremap ; l
noremap l k
noremap k j
noremap j h
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

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
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
let NERDTreeMapActivateNode='<space>'

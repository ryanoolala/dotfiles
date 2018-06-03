" Minimal Configuration
set nocompatible
syntax on
filetype plugin indent on

" call plug#begin('~/.vim/plugged')

" (Optinal) for Tag Sidebar
" Plug 'majutsushi/tagbar'

"Plug 'hashivim/vim-terraform'
"Plug 'vim-syntastic/syntastic'
"Plug 'juliosueiras/vim-terraform-completion'
" call plug#end()

" Syntastic Config
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

" (Optional)Remove Info(Preview) window
set completeopt-=preview

" (Optional)Hide Info(Preview) window after completions
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
let g:terraform_fmt_on_save=1

" (Optional) Enable terraform plan to be include in filter
" let g:syntastic_terraform_tffilter_plan = 1

" (Optional) Default: 0, enable(1)/disable(0) plugin's keymapping
let g:terraform_completion_keys = 1

" (Optional) Default: 1, enable(1)/disable(0) terraform module registry completion
let g:terraform_registry_module_completion = 1

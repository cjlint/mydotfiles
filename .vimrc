" Configuration file for vim
set modelines=0		" CVE-2007-2438

" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible	" Use Vim defaults instead of 100% vi compatibility
set backspace=2		" more powerful backspacing

" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup nobackup
" Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw.* set nowritebackup nobackup

let skip_defaults_vim=1

set number
syntax on
set background=dark
colorscheme everforest

set expandtab
set shiftwidth=4
set tabstop=4
filetype plugin indent on
set hlsearch

" autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
" autocmd BufNewFile,BufRead *.xtemp set syntax=html
" autocmd BufNewFile,BufRead *.less set syntax=css


" let g:ale_linters = {
" \  'javascript': ['eslint'],
" \  'python': ['pylint']
" \}


function PythonMain()
    let a = "if __name__ == '__main__':"
    let b = "    pass"
    put =a
    put =b
endfunction

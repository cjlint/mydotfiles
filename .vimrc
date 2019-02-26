" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
set number
set hls
color desert
set backspace=indent,eol,start

filetype plugin indent on
syntax on

" autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd BufNewFile,BufRead *.xtemp set syntax=html
autocmd BufNewFile,BufRead *.less set syntax=css

" let g:ale_linters = {
" \  'javascript': ['eslint'],
" \  'python': ['pylint']
" \}

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
set autoindent
" this setting clashed with ale omnifunc
" filetype plugin indent on
set hlsearch
set autowrite

" Use local project vim settings, securely
set exrc
set secure

function PyMain()
    .put='#!/usr/bin/env python3'
    .put=''
    .put='def main():'
    .put='    pass'
    .put=''
    .put='if __name__ == \"__main__\":'
    .put='    main()'
endfunction

let g:ale_python_ruff_auto_pipenv = 1

" Go syntax highlighting
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
" let g:go_fmt_fail_silently = 1
" Status line types/signatures
let g:go_auto_type_info = 1
" ALE use $PATH's gopls, not the one built in
let g:ale_go_gopls_executable = "/Users/cjlinton/go/bin/gopls"
let g:ale_go_gopls_options = "-remote=auto -vv -logfile=/tmp/alegopls.log"
let g:go_gopls_options = ["-remote=auto", "-vv", "-logfile=/tmp/gopls.log"]

" Use C-n and C-p to cycle through autocomplete options
let g:ale_completion_enabled = 1
let g:ale_completion_delay = 0
set omnifunc=ale#completion#OmniFunc
set updatetime=1000
" Use C-j/k to jump to next/previous errors
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
" Use Enter in normal mode to auto import symbol
nmap <silent> <Return> <Plug>(ale_import)
" Use tab to autocomplete first omnifunc result
inoremap <expr> <Tab> pumvisible() ? "\<Down>\<Return>" : "\<Tab>"

let g:ale_fixers = {
\   '*': ['trim_whitespace'],
\   'python': ['ruff', 'black'],
\   'javascript': ['eslint']
\}
let g:ale_linters = {
\   'sql': ['sqlfluff', 'sql-language-server']
\}
let g:ale_fix_on_save = 1

" let g:LanguageClient_serverCommands = {
" \   'sql': ['sql-language-server', 'up', '--method', 'stdio'],
" \}

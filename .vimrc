" Configuration file for vim

" https://github.com/junegunn/vim-plug
call plug#begin()
" general
Plug 'dense-analysis/ale'
Plug 'editorconfig/editorconfig-vim'
Plug 'https://tpope.io/vim/commentary.git'

" color scheme
Plug 'sainnhe/everforest'

" language-specific
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'ap/vim-css-color'
Plug 'jparise/vim-graphql'
Plug 'fatih/vim-go'
" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting
filetype plugin off
syntax on

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
set background=dark
colorscheme everforest

set expandtab
set shiftwidth=4
set tabstop=4
set autoindent
" filetype plugin clashed with ale omnifunc.
" It may still be useful for files where I don't have ale set up
filetype indent on
set hlsearch
set autowrite
set foldmethod=syntax
set nofoldenable

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
" Files for which I don't have an ale language server set up,
" turn on default autocompletion
autocmd FileType css,scss setlocal omnifunc=csscomplete#CompleteCSS noci
autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType css,scss,html filetype plugin on

set updatetime=1000
" Use C-j/k to jump to next/previous errors
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
" Use Enter in normal mode to auto import symbol
nmap <silent> <Return> <Plug>(ale_import)
" Use g-Enter to open definition
nmap <silent> g<Return> <Plug>(ale_go_to_definition_in_tab)
" Use f-Enter to find references
nmap <silent> f<Return> <Plug>(ale_find_references)
" Open file under cursor in new tab by default
nnoremap gf <c-w>gf
nnoremap gF <c-w>gF
" Use space to fold/unfold
nnoremap <space> za

" Use tab to autocomplete first omnifunc result
" TODO this doesn't work well if an option is already selected from the list
" (it picks the next option instead of the one that's selected)
inoremap <expr> <Tab> pumvisible() ? "\<Down>\<Return>" : "\<Tab>"

let g:ale_fixers = {
\   '*': ['trim_whitespace'],
\   'python': ['ruff', 'black'],
\   'javascript': ['prettier'],
\   'typescript': ['prettier'],
\   'typescriptreact': ['prettier'],
\   'css': ['prettier'],
\   'scss': ['prettier'],
\   'html': ['prettier'],
\   'elixir': ['mix_format'],
\}
let g:ale_linters = {
\   'sql': ['sqlfluff', 'sql-language-server'],
\   'elixir': ['credo', 'mix']
\}
let g:ale_fix_on_save = 1
let g:ale_elixir_elixir_ls_release = $HOME . '/bin/elixir-ls'

" let g:LanguageClient_serverCommands = {
" \   'sql': ['sql-language-server', 'up', '--method', 'stdio'],
" \}

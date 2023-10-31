" Configuration file for nvim

" https://github.com/junegunn/vim-plug
call plug#begin()
" general
Plug 'neovim/nvim-lspconfig'
Plug 'sbdchd/neoformat'
Plug 'editorconfig/editorconfig-vim'
Plug 'https://tpope.io/vim/commentary.git'
Plug 'github/copilot.vim'

" nvim-cmp
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" color scheme
Plug 'sainnhe/everforest'

" language-specific
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'ap/vim-css-color'
Plug 'jparise/vim-graphql'
Plug 'mustache/vim-mustache-handlebars'
" Plug 'fatih/vim-go'
" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
filetype plugin indent off
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
set shiftwidth=2
set tabstop=2
set softtabstop=2
set autoindent
set hlsearch
set autowrite
set foldmethod=syntax
set nofoldenable

" Neoformat
let g:neoformat_try_node_exe = 1
let g:neoformat_handlebars_prettierglimmer = {
            \ 'exe': 'prettier',
            \ 'args': ['--parser', 'glimmer'],
            \ 'replace': 1,
            \ 'stdin': 1,
            \ 'env': ["DEBUG=1"],
            \ 'valid_exit_codes': [0, 23],
            \ 'no_append': 1,
            \ }

let g:neoformat_enabled_handlebars = ['prettierglimmer']
autocmd BufWritePre * Neoformat

source ~/.config/nvim/lsp.lua

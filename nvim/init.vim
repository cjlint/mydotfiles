" Configuration file for nvim

" https://github.com/junegunn/vim-plug
call plug#begin()
" general
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'editorconfig/editorconfig-vim'
Plug 'mfussenegger/nvim-lint'
Plug 'mhartington/formatter.nvim'
Plug 'sheerun/vim-polyglot'
Plug 'nvim-tree/nvim-tree.lua'

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
" Plug 'ap/vim-css-color'
Plug 'jparise/vim-graphql'
Plug 'mustache/vim-mustache-handlebars'
Plug 'nvim-lua/plenary.nvim'
" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
filetype plugin indent off
syntax off

set modelines=0		" CVE-2007-2438

" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible	" Use Vim defaults instead of 100% vi compatibility
set backspace=2		" more powerful backspacing

" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup nobackup
" Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw.* set nowritebackup nobackup

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
set mouse=

source ~/.config/nvim/lsp.lua
source ~/.config/nvim/formatter.lua
source ~/.config/nvim/lint.lua
source ~/.config/nvim/tree.lua

au BufWritePost * FormatWrite
au BufReadPost,InsertLeave,TextChanged * lua require('lint').try_lint()

nnoremap <silent> <space>f :Format<CR>

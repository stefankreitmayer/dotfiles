set nocompatible

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off "req vundle
set rtp+=~/.vim/bundle/Vundle.vim "req vundle

call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'flazz/vim-colorschemes'
Plugin 'kien/ctrlp.vim'

Plugin 'tpope/vim-surround'
Plugin 'flazz/vim-colorschemes'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-unimpaired'

call vundle#end()
filetype plugin indent on    " req vim

colorscheme jellybeans
let g:jellybeans_overrides = {
			\  'Cursor': { 'guibg': 'ff00ee', 'guifg': '000000' },
			\  'Search': { 'guifg': '00ffff', 'attr': 'underline' },
\}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM OPTIONS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""" HIGHLIGHTING
syntax on

set cursorline                     " highlight line at cursor set hlsearch set ignorecase set incsearch
set hlsearch                       " highlight all search results

""" EXTRA INFO
set number                         " show absolute line numbers
set colorcolumn=81                 " line width delimiter
set showtabline=2                  " always have tab line
set statusline=%f\ %m%r%y%=%3l,%2c
" set list                           " show symbols for <eol> and <tab>
" set listchars=tab:▸\ ,eol:¬        " set symbols for <eol> and <tab>
set visualbell                     " no beeping
set wildmenu                       " show menu of complete option

""" INDENTATION / BLANKS
set autoindent
set backspace=indent,eol,start     " allow backspace over eol etc.
set expandtab                      " use n times <space> instead of <tab>
set shiftwidth=4
set softtabstop=4
set tabstop=4                      " spaces per tab

""" LOAD / SAVE / UNDO
set autoread                       " auto reload when file changes
set autowrite                      " Automatically :write before running commands

set nobackup                       " no backups, no swapfiles
set noswapfile                     " no backups, no swapfiles
set nowritebackup                  " no backups, no swapfiles

set undodir=~/.vim/undo//
set undofile
set undolevels=1000
set undoreload=10000

""" SEARCH / TAGS
set ignorecase                     " ignore case when searching
set incsearch                      " highlight while typing search
set smartcase                      " search is case sensitive when word starts with uppercase
set tags+=.git/tags,./.tags


""" WINDOWS
set splitbelow                     " split opens new window below
set splitright                     " vsplit opens new window to the right


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" KEY MAPPINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader = ","

inoremap jj <esc>
inoremap kk <esc>
inoremap UU <esc>u

nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>ev :tabe $MYVIMRC<cr>

set nocompatible

""""""""""""""""""""""""""""""""""""""""""""""""""""""""" VUNDLE
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""" VIM OPTIONS
colorscheme jellybeans

""""""""""""""""""""""""""""""""""""""""""""""""""""""""" HIGHLIGHTING
colorscheme jellybeans
let g:jellybeans_overrides = {
			\  'Cursor': { 'guibg': 'ff00ee', 'guifg': '000000' },
			\  'Search': { 'guifg': '00ffff', 'attr': 'underline' },
\}

syntax on

set number


""""""""""""""""""""""""""""""""""""""""""""""""""""""""" KEY MAPPINGS
let mapleader = ","

inoremap jj <esc>
inoremap kk <esc>
inoremap UU <esc>u

nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>ev :tabe $MYVIMRC<cr>

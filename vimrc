set nocompatible

""""""""""""""""""""""""""""""""""""""""""""""""""""""""" VUNDLE
filetype off "req vundle
set rtp+=~/.vim/bundle/Vundle.vim "req vundle

call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'tpope/vim-surround'

call vundle#end()
filetype plugin indent on    " required

""""""""""""""""""""""""""""""""""""""""""""""""""""""""" KEY MAPPINGS
let mapleader = ","

inoremap jj <esc>
inoremap kk <esc>
inoremap UU <esc>u

nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>ev :tabe $MYVIMRC<cr>

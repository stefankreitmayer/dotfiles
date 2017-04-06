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
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'mileszs/ack.vim'

Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-rails'
Plugin 'kchmck/vim-coffee-script'


Plugin 'lambdatoast/elm.vim'

Plugin 'elixir-lang/vim-elixir'

Plugin 'janko-m/vim-test'
Plugin 'bodymindarts/vim-twitch'
Plugin 'skalnik/vim-vroom'

Plugin 'vimwiki/vimwiki'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

call vundle#end()
filetype plugin indent on    " req vim


colorscheme jellybeans
let g:jellybeans_overrides = {
      \  'Cursor': { 'guibg': 'ff00ee', 'guifg': '000000' },
      \  'Search': { 'guifg': '00ffff', 'attr': 'underline' },
      \}

" use ag if available, instead of ack
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ackprg = 'ag --vimgrep --depth 100'
  " let g:ctrlp_user_command = 'ag %s -l --no-color -g ""'
  let g:ctrlp_user_command = 'ag %s -l -g ""'
  " let g:ctrlp_working_path_mode = ''
  let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](\.git|tmp|public|coverage|vendor)$',
    \ 'file': '\v\.(exe|so|dll)$',
    \ 'link': 'some_bad_symbolic_links',
    \ }
  set wildignore+=*node_modules*
  set wildignore+=*elm-stuff*
endif

:let g:airline_theme='mygit'

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
set laststatus=2                   " always have status line
set statusline=%f\ %m%r%y%=%3l,%2c
" set list                           " show symbols for <eol> and <tab>
" set listchars=tab:▸\ ,eol:¬        " set symbols for <eol> and <tab>
set visualbell                     " no beeping
set wildmenu                       " show menu of complete option

""" INDENTATION / BLANKS
set autoindent
set backspace=indent,eol,start     " allow backspace over eol etc.
set expandtab                      " use n times <space> instead of <tab>
set shiftwidth=2
set softtabstop=2
set tabstop=2                      " spaces per tab

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


set clipboard=unnamed

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" KEY MAPPINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","

inoremap jj <esc>
inoremap UU <esc>u

nnoremap <cr> :nohlsearch<cr>

noremap <C-p> :CtrlPMixed<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CONFIG FILES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>ev :tabe $MYVIMRC<cr>
nnoremap <leader>ez :tabe ~/.zshrc<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CREATE DIRECTORY
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>m :!mkdir -p %:p:h<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RUN RSPEC
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>s :w<cr>:!bundle exec rspec -c<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <leader>N :call RenameFile()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MANAGE WHITESPACE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd BufRead,InsertLeave * match ExtraWhitespace /\s\+$/
highlight ExtraWhitespace ctermbg=red guibg=red
highlight ExtraLines ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

augroup vimrc
  autocmd!
  autocmd FileType ruby,haml,eruby,yaml,sass,scss,css,javascript,cucumber,nginx
        \ setlocal shiftwidth=2 |
        \ setlocal softtabstop=2 |
        \ setlocal tabstop=2

  autocmd BufNewFile, BufRead *.json set ft=javascript
  autocmd BufNewFile, BufRead *.md set ft=text
  autocmd BufReadPost nginx.conf set ft=nginx
  autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
  autocmd CmdwinEnter * nnoremap <buffer> <CR> <CR>

  autocmd FileType ruby,haml,html,eruby,yaml,sass,scss,css,javascript,cucumber,vim
        \ autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \ exe "normal g`\"" |
        \ endif
augroup end

function! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfunction


function! IndentBuffer()
  normal! my
  normal! gg=G
  normal! `y
  normal! zz
endfunction

nnoremap <leader>= :call IndentBuffer()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NAVIGATE WINDOWS AND BUFFERS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" split window and reset to last
" nnoremap vv <c-w>v<c-w>h<c-^>

nnoremap <leader>t :Twitch<CR>
" nnoremap <leader>vv <c-w>o :VTwitch<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configure Plugin 'janko-m/vim-test'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let test#ruby#rspec#options = {
      \ 'nearest': '-c --backtrace',
      \ 'file':    '-c --format documentation',
      \ 'suite':   '-c --tag ~slow',
      \}
nnoremap <Leader>c :TestFile<CR>
nnoremap <Leader>n :TestNearest<CR>
nnoremap <Leader>a :TestSuite<CR>
nnoremap <leader>l :TestLast<CR>

nnoremap <leader>b :w\|!sh build.sh<cr>
nnoremap <leader>r :w\|!sh run-elm-tests.sh<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Convert from => to new hash syntax (Ruby)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>h :%s/:\([^ ]*\)\(\s*\)=>/\1:/gc<cr>


:nohl




let g:ctrlp_max_files = 3000000
let g:ctrlp_max_depth = 3000000
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:100'

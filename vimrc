set nocompatible

filetype off                " req Vundle
set rtp+=~/.vim/bundle/Vundle.vim    " req Vundle
call vundle#begin()
" vundle handles vundle
Plugin 'gmarik/Vundle.vim'

" plugins:
Plugin 'flazz/vim-colorschemes'
" Plugin 'altercation/vim-colors-solarized'
Plugin 'kien/ctrlp.vim'
Plugin 'mileszs/ack.vim'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-bundler'
Plugin 'godlygeek/tabular'
Plugin 'drmingdrmer/xptemplate'

call vundle#end()

colorscheme jellybeans

" set background=dark
" let g:solarized_termcolors=256
" colorscheme solarized

let g:jellybeans_overrides = {
\  'Special': { 'guifg': 'de5577' },
\}

autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd BufRead,InsertLeave * match ExtraWhitespace /\s\+$/
highlight ExtraWhitespace ctermbg=red guibg=red
highlight ExtraLines ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

filetype plugin indent on          " req Vundle

" The following beast is something i didn't write... it will return the
" syntax highlighting group that the current "thing" under the cursor
" belongs to -- very useful for figuring out what to change as far as
" syntax highlighting goes.
nmap <silent> <leader>ps :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

runtime macros/matchit.vim
syntax on
set autoindent
set autoread                       " auto reload when file changes
set autowrite                      " Automatically :write before running commands
set backspace=indent,eol,start     " allow backspace over eol etc.
set colorcolumn=81                 " line width delimiter
set cursorline                     " highlight line at cursor set hlsearch set ignorecase set incsearch
set expandtab                      " use n times <space> instead of <tab>
set hlsearch                       " highlight all search results
set ignorecase                     " ignore case when searching
set incsearch                      " highlight while typing search
set laststatus=2                   " line for status of window
set list                           " show symbols for <eol> and <tab>
set listchars=tab:▸\ ,eol:¬        " set symbols for <eol> and <tab>
set nobackup                       " no backups, no swapfiles
set noswapfile                     " no backups, no swapfiles
set nowritebackup                  " no backups, no swapfiles
set number                         " line number
set runtimepath+=~/.vim/xpt-personal
set shiftwidth=4
set showtabline=2                  " always have tab line
set smartcase                      " search is case sensitive when word starts with uppercase
set softtabstop=4
set splitbelow                     " split opens new window below
set splitright                     " vsplit opens new window to the right
set statusline=%f\ %m%r%y%=%3l,%2c
set tabstop=4                      " spaces per tab
set tags+=.git/tags,./.tags
set undodir=~/.vim/undo//
set undofile
set undolevels=1000
set undoreload=10000
set visualbell                     " no beeping
set wildmenu                       " show menu of complete option

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

let mapleader=","

nnoremap <cr> :nohlsearch<cr>
nnoremap <leader>ev :tabe $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>ez :tabe ~/.zshrc<cr>
nnoremap <leader>x :w<cr>:!chmod +x %<cr>:edit!<cr>
nnoremap <leader>m :!mkdir -p %:p:h<cr>
inoremap UU <esc>u
inoremap jj <esc>

nnoremap <leader>et :tabe ~/todo.txt<cr>
nnoremap <leader>er :tabe ~/recap.txt<cr>
nnoremap <leader>eh :tabe ~/hirncrap.txt<cr>
nnoremap <leader>ez :tabe ~/.zshrc<cr>
nnoremap <leader>sc :tabe db/schema.rb<cr>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Close all other windows, open a vertical split, and open this file's test
" alternate in it.
nnoremap <leader>f :call FocusOnFile()<cr>
function! FocusOnFile()
  tabnew %
  normal! v
  normal! l
  call OpenTestAlternate()
  normal! h
endfunction

" split window and reset to last
nnoremap vv <c-w>v<c-w>h<c-^>

nnoremap tt :call SplitWithTest()<cr>
function! SplitWithTest()
  let current_file = expand("%")
  let in_spec = match(current_file, '^spec/') != -1
  normal! v
  if in_spec
    normal! h
    call OpenTestAlternate()
    normal! l
  else
    call OpenTestAlternate()
  endif
endfunction

" use ag for ack
let g:ackprg = 'ag --nogroup --nocolor --column'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CtrlP SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_show_hidden = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_use_caching = 0
let g:ctrlp_switch_buffer = 'e'
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_root_markers = ['tags', '.tags']
let g:ctrlp_abbrev = {
  \ 'abbrevs': [
    \ {
      \ 'pattern': 'vim',
      \ 'expanded': '@cd ~/.vim/'
    \ },
    \ {
      \ 'pattern': 'dot',
      \ 'expanded': '@cd ~/.dotfiles/'
    \ }
  \ ]
\}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Quickfix list management
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! QuickfixFilenames()
    let buffer_numbers = {}
    for quickfix_item in getqflist()
        let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
    endfor
    return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction
command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()

function! GetBufferList()
    redir =>buflist
    silent! ls
    redir END
    return buflist
endfunction

function! BufferIsOpen(bufname)
    let buflist = GetBufferList()
    for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
        if bufwinnr(bufnum) != -1
            return 1
        endif
    endfor
    return 0
endfunction

function! ToggleQuickfix()
    if BufferIsOpen("Quickfix List")
        cclose
    else
        call OpenQuickfix()
    endif
endfunction

function! OpenQuickfix()
    botright cwindow
    if &ft == "qf"
        cc
    endif
endfunction

nnoremap <leader>aq :Qargs<cr>
nnoremap <leader>q :call ToggleQuickfix()<cr>
nnoremap <leader>rq :cgetfile .git/rspec.quickfix<cr>:call OpenQuickfix()<cr>
nnoremap <leader>sq :cgetfile targe/quickfix/sbt.quickfix<cr>:call OpenQuickfix()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PROMOTE VARIABLE TO RSPEC LET
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! PromoteToLet()
  :normal! dd
  :normal! P
  :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  :normal ==
endfunction
:command! PromoteToLet :call PromoteToLet()
:map <leader>p :PromoteToLet<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BREAK UP METHOD CALL (1 arg per line)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! <SID>ArgPerLine()
    if search('(', 'cb', line('.')) == 0
        call search('(', '', line('.'))
    endif
    exec "normal! a\<cr>\<esc>"
    while search(',', '', line('.')) != 0
        exec "normal! a\<cr>\<esc>"
    endwhile
    if search(')', '', line('.')) != 0
        exec "normal! i\<cr>\<esc>"
    endif
endfunction
nnoremap <leader>ba :call <SID>ArgPerLine()<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SWITCH BETWEEN TEST AND PRODUCTION CODE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenTestAlternate()
  let new_file = AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction
function! AlternateForCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_spec = match(current_file, '^spec/') != -1
  let going_to_spec = !in_spec
  let in_app = match(current_file, '\<controllers\>') != -1 || match(current_file, '\<models\>') != -1 || match(current_file, '\<views\>') != -1 || match(current_file, '\<helpers\>') != -1 || match(current_file, '\<services\>') != -1
  if going_to_spec
    let new_file = substitute(new_file, '\v^(app|lib)/', '', '')    " use very magic option \v => don't have to escape \( \) \|
    let new_file = substitute(new_file, '\.e\?rb$', '_spec.rb', '')
    let new_file = 'spec/' . new_file
  else
    let new_file = substitute(new_file, '_spec\.rb$', '.rb', '')
    let new_file = substitute(new_file, '^spec/', '', '')
    if in_app
        let new_file = 'app/' . new_file
    else
        let new_file = 'lib/' . new_file
    endif
  endif
  return new_file
endfunction
nnoremap <leader>. :call OpenTestAlternate()<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RUN TEST FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\)$') != -1
    if in_test_file
        call SetTestFile()
    elseif !exists("t:grb_test_file")
        return
    end
    call RunTests(t:grb_test_file .  command_suffix)
endfunction

function! RunNearestTest()
    let spec_line_number = line('.')
    call RunTestFile(":" . spec_line_number)
endfunction

function! SetTestFile()
    "     Set the spec file that tests will be run for.
    let t:grb_test_file=@%
endfunction

function! RunTests(filename)
    " Write the file and run tests for the given filename
    if expand("%") != ""
        :w
    end

    let cmd = "rake"

    if match(a:filename, '\.feature$') != -1
        let cmd = "cucumber -r ./features/ " . a:filename
    elseif match(a:filename, '_spec\.rb') != -1
        let cmd = "rspec --color " .  a:filename
    end

    if filereadable("Gemfile")
        let cmd = "bundle exec " . cmd
    end
    let t:grb_last_test_command = cmd
    execute "!clear && echo " . cmd " && " . cmd
endfunction

function! RunLastTestCommand()
    if expand("%") != ""
        :w
    end
    if exists("t:grb_last_test_command") == 1
        execute "!clear && echo " . t:grb_last_test_command . " && " . t:grb_last_test_command
    endif
endfunction
nnoremap <Leader>c :call RunTestFile()<CR>
nnoremap <Leader>n :call RunNearestTest()<CR>
nnoremap <Leader>a :call RunTests('')<CR>
nnoremap <leader>l :call RunLastTestCommand()<CR>
:nohl

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
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-rails'

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

nnoremap <cr> :nohlsearch<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CONFIG FILES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>ev :tabe $MYVIMRC<cr>
nnoremap <leader>ez :tabe ~/.zshrc<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MY PERSONAL NOTES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>et :tabe ~/.todo<cr>
nnoremap <leader>er :tabe ~/.recap<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CREATE DIRECTORY
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>m :!mkdir -p %:p:h<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
nnoremap vv <c-w>v<c-w>h<c-^>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" JUXTAPOSE TEST AND PRODUCTION CODE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap tt :call SplitWithTest()<cr>
function! SplitWithTest()
    let filename = expand("%")
    let in_rspec_spec = match(filename, '^spec/') != -1
    let in_cucumber_feature = match(filename, '\.feature$') != -1
    let in_cucumber_step_definition = match(filename, '^features/step_definitions/.*\.rb') != -1
    let in_ruby = match(filename, '\.e\?rb$') != -1
    if in_rspec_spec
        call OpenInLeftSplit(PathToImplementation(filename))
    elseif in_cucumber_feature
        call OpenInLeftSplit(PathToCucumberStepDefinition(filename))
    elseif in_cucumber_step_definition
        call OpenInRightSplit(PathToCucumberFeature(filename))
    elseif in_ruby
        call OpenInRightSplit(PathToRspec(filename))
    endif
endfunction

function! PathToImplementation(test_path)
    let new_path = a:test_path
    let in_app = match(new_path, '/controllers/\|/models/\|/helpers/\|/mailers/\|/views/')
    let new_path = substitute(new_path, '_spec\.rb$', '.rb', '')
    let new_path = substitute(new_path, '^spec/', '', '')
    if in_app
        let new_path = 'app/' . new_path
    else
        let new_path = 'lib/' . new_path
    endif
    return new_path
endfunction

function! PathToRspec(implementation_path)
    let new_path = a:implementation_path
    let new_path = substitute(new_path, '\v^(app|lib)/', '', '')
    let new_path = substitute(new_path, '\.e\?rb$', '_spec.rb', '')
    let new_path = 'spec/' . new_path
    return new_path
endfunction

function! PathToCucumberFeature(stepdefs_path)
    let new_path = a:stepdefs_path
    let new_path = substitute(new_path, '.*/', '', 'g')
    let new_path = substitute(new_path, '\.rb$', '.feature', '')
    let new_path = 'features/' . new_path
    return new_path
endfunction

function! PathToCucumberStepDefinition(feature_path)
    let new_path = a:feature_path
    let new_path = substitute(new_path, '.*/', '', 'g')
    let new_path = substitute(new_path, '\.feature$', '.rb', '')
    let new_path = 'features/step_definitions/' . new_path
    return new_path
endfunction

function! OpenInLeftSplit(filename)
    normal! v
    normal! h
    exec ':e ' . a:filename
endfunction

function! OpenInRightSplit(filename)
    normal! v
    normal! l
    exec ':e ' . a:filename
endfunction

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

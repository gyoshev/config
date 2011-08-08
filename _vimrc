set nocompatible

" General {
    set clipboard+=unnamed
    set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
    set encoding=utf-8

    " searching
    set ignorecase
    set smartcase
    set incsearch
    set showmatch
    set hlsearch

    " avoid swap, temp and backup files
    set nobackup
    set nowritebackup
    set noswapfile

    " setup window
    winpos 0 0
    set lines=999
    set columns=999

    " show the cursor position all the time
    set ruler

    " display incomplete commands
    set showcmd
    set wildmenu
" }

" Keyboard {
    noremap <C-S> :w<CR>
    inoremap <C-S> <C-O>:w<CR>

    noremap <S-CR> <Esc>

    set backspace=indent,eol,start " make backspace behave consistently with other apps

    " delete trailing whitespace with F5
    nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

    " remove search highlight when esc is pressed
    nnoremap <esc> :noh<return><esc>

    " use tab to switch between buffers
    noremap <C-S-tab> :bp<CR>
    noremap <C-tab> :bn<CR>

    " refresh syntax highlighting on F12
    noremap <F12> <Esc>:syntax sync fromstart<CR>
    inoremap <F12> <C-o>:syntax sync fromstart<CR>

    " map bclose
    nmap <C-W>! <Plug>Kwbd

    " toggle NerdTree
    noremap <F3> :NERDTreeToggle<CR>
" }

" Coding {
    set iskeyword+=_,$,@,%,# 
    set guifont=Consolas:h10
    set number
    syntax on

    set runtimepath=~/.vim,$VIMRUNTIME
    source ~/.vim/bundle/pathogen/autoload/pathogen.vim
    call pathogen#infect()

    colorscheme railscasts
    autocmd BufEnter * :syntax sync fromstart

    " show trailing whitespace
    set list listchars=tab:>-,trail:.

    set completeopt=menuone

    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
    set expandtab

    set autoindent
    set smartindent
    set smarttab

    filetype plugin on
" }


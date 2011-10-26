set nocompatible
filetype off
set rtp=~/.vim/bundle/vundle/,~/.vim,$VIMRUNTIME
let g:snippets_dir='~/.vim/snippets/'
call vundle#rc()

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

    " show the cursor position all the time
    set ruler

    " display incomplete commands
    set showcmd
    set wildmenu

    " terminal settings
    set t_Co=256
    set mouse=a
    set ttymouse=xterm2
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

    " toggle NerdTree
    noremap <F3> :NERDTreeToggle<CR>

    " close buffer
    nmap <C-W>! <Plug>Kwbd
" }

" Coding {
    set iskeyword+=_,$,@,%,# 
    set guifont=Consolas:h10
    set number
    syntax on

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

"   Plugins {
        Bundle 'gmarik/vundle'

        Bundle 'tpope/vim-fugitive'
        Bundle 'skammer/vim-css-color'
        Bundle 'cespare/vim-bclose.git'
        Bundle 'scrooloose/nerdtree.git'
        Bundle 'scrooloose/nerdcommenter'
        Bundle 'msanders/snipmate.vim.git'
        Bundle 'gregsexton/gitv'
"   }

    filetype plugin indent on

    au FileType gitcommit           setlocal spell
    au BufRead,BufNewFile *.html    setlocal filetype=html.javascript
" }


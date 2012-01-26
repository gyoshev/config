set nocompatible
filetype off
set rtp=~/.vim/bundle/vundle/,~/.vim,$VIMRUNTIME
let g:snippets_dir='~/.vim/snippets/'
call vundle#rc()

" Plugins {
    Bundle 'gmarik/vundle'

    Bundle 'tpope/vim-fugitive'
    Bundle 'cespare/vim-bclose'
    Bundle 'scrooloose/nerdtree'
    Bundle 'scrooloose/nerdcommenter'
    Bundle 'msanders/snipmate.vim'
    Bundle 'gregsexton/gitv'
    Bundle 'vim-scripts/JavaScript-Indent'
    Bundle 'vim-scripts/Obvious-Mode'
    Bundle 'ervandew/supertab'
    Bundle 'wincent/Command-T'
" }

" General {
    set hidden

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
    nnoremap <silent> <leader>q :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

    " use tab to switch between buffers (windows-like)
    noremap <C-S-tab> :bp<CR>
    noremap <C-tab> :bn<CR>
    noremap <leader><tab> :bp<CR>
    noremap <leader><S-tab> :bn<CR>

    " toggle NerdTree
    noremap <leader>] :NERDTreeToggle<CR>

    " quick-paste last yanked text
    noremap <C-p> "0p
    noremap <C-P> "0P

    " indent!
    nnoremap <Tab> >>
    nnoremap <S-Tab> <<
    vnoremap <Tab> >gv
    vnoremap <S-Tab> <gv

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

    filetype plugin indent on

    au FileType gitcommit           setlocal spell
    au BufRead,BufNewFile *.html    setlocal filetype=html.javascript
    autocmd BufWritePost ~/github/kendo/src/*.js silent !cd ~/github/kendo && jake merge-scripts > /dev/null 2>&1
" }


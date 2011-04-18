set nocompatible

" General {
    set clipboard+=unnamed
    set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]

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

    " always change to the current directory
    set autochdir


    " setup window
    winpos 0 0
    set lines=999
    set columns=999

    " show the cursor position all the time
    set ruler

    " display incomplete commands
    set showcmd
" }

" Keyboard {
    noremap <C-S> :w<CR>
    inoremap <C-S> <C-O>:w<CR>

    noremap <S-CR> <Esc>

    set backspace=indent,eol,start " make backspace behave consistently with other apps

    " show trailing whitespace and delete it with F5
    nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

    " remove search highlight when esc is pressed
    nnoremap <esc> :noh<return><esc>
    
    " use tab to switch between buffers
    noremap <C-S-tab> :bp<CR>
    noremap <C-tab> :bn<CR>

    " fix syntax highlighting
    noremap <F12> <Esc>:syntax sync fromstart<CR>
    inoremap <F12> <C-o>:syntax sync fromstart<CR>

    " map bclose
    nmap <C-W>! <Plug>Kwbd
" }

" Coding {
    set iskeyword+=_,$,@,%,# 
    set guifont=Consolas:h10
    set number
    syntax on

    call pathogen#runtime_append_all_bundles() 

    set background=dark
    colorscheme solarized

    set completeopt=menuone

    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
    set expandtab

    set autoindent
    set smartindent
    set smarttab
" }


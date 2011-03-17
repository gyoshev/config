set nocompatible

"completion
set completeopt=menuone

"line numbers
set number

"syntax highlighting
syntax on

"using http://www.vim.org/scripts/script.php?script_id=2175
colorscheme railscasts

"set the font
set guifont=Consolas:h12

"tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

"indentation
set autoindent
set smartindent
set smarttab

"avoid swap, temp and backup files
set nobackup
set nowritebackup
set noswapfile

"make backspace work like most other apps
set backspace=indent,eol,start

"setup window
winpos 0 0
set lines=999
set columns=999

"show the cursor position all the time
set ruler

"display incomplete commands
set showcmd

"use C-s for saving
noremap <C-S> :w<CR>
inoremap <C-S> <C-O>:w<CR>

"searching
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch

set nocompatible

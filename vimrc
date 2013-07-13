set nocompatible

" Vundle Install {
  if !isdirectory(expand('$HOME/.vim/bundle/vundle/.git', 1))
    silent ! git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
    if v:shell_error
      finish
    else
      silent ! vim +BundleInstall +qall
    endif
  endif
" }

" Tern Install {
  let tern_dir = expand('$HOME/.vim/bundle/tern_for_vim', 1)
  let cwd = getcwd()
  if !isdirectory(tern_dir . '/node_modules')
    execute "cd " . tern_dir
    silent ! npm install
    execute "cd " . cwd
  endif
" }

filetype off
set rtp=~/.vim/bundle/vundle/,~/.vim,$VIMRUNTIME
let g:snippets_dir='~/.snippets/'
call vundle#rc()

" Plugins {
    Bundle 'gmarik/vundle'

    Bundle 'Railscasts-Theme-GUIand256color'
    Bundle 'cespare/vim-bclose'
    Bundle 'groenewege/vim-less'
    Bundle 'msanders/snipmate.vim'
    Bundle 'scrooloose/nerdcommenter'
    Bundle 'scrooloose/nerdtree'
    Bundle 'jelera/vim-javascript-syntax'
    Bundle 'pangloss/vim-javascript'
    Bundle 'marijnh/tern_for_vim'
    Bundle 'rosenfeld/conque-term'

    Bundle 'mileszs/ack.vim'

    Bundle 'tpope/vim-fugitive'
    Bundle 'tpope/vim-unimpaired'
    Bundle 'tpope/vim-surround'
    Bundle 'tpope/vim-ragtag'
    let g:ragtag_global_maps = 1

    Bundle 'kien/ctrlp.vim'
    let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/]\dist$',
      \ }

    let g:ctrlp_cmd = 'call CallCtrlP()'

    func! CallCtrlP()
        if exists('s:called_ctrlp')
            CtrlPLastMode
        else
            let s:called_ctrlp = 1
            CtrlPMRU
        endif
    endfunc

    set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
    set laststatus=2
    Bundle 'Lokaltog/vim-powerline'
    let g:Powerline_symbols = 'fancy'
    Bundle 'Lokaltog/vim-easymotion'
" }

" General {
    set hidden

    set clipboard+=unnamed
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

    " toggle NerdTree
    noremap <leader>] :NERDTreeToggle<CR>

    " quick-paste last yanked text
    noremap <C-p> "0p
    noremap <C-P> "0P

    " center screen
    noremap <Space> zz

    " open file from same dir
    map <leader>ew :e <C-R>=expand("%:h") . "/" <CR>

    " indent!
    nnoremap <Tab> >>
    nnoremap <S-Tab> <<
    vnoremap <Tab> >gv
    vnoremap <S-Tab> <gv

    " easier omni-complete
    imap <C-Space> <C-X><C-O>

    " close buffer
    nmap <C-W>! <Plug>Kwbd
" }

" Coding {
    set iskeyword+=_,$,@,%,# 
    set guifont=Consolas:h10
    set number
    syntax on

    silent! colorscheme railscasts
    autocmd BufEnter * :syntax sync fromstart

    " show trailing whitespace
    set list listchars=tab:>-,trail:.

    " ignore binaries and artifacts
    set wildignore=*.o,*.obj,*.bin,*.dll,*.zip
    " exclude version control directories
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
    set wildignore+=*\\.git\\*,*\\.hg\\*,*\\.svn\\*

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
    autocmd BufReadPost *cshtml set filetype=html
    autocmd BufReadPost Jakefile set filetype=javascript
" }


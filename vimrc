set nocompatible

" Vundle Install {
  let home_dir = expand('$HOME')
  if !isdirectory(expand(home_dir . '/.vim/bundle/vundle/.git', 1))
    execute "! git clone https://github.com/gmarik/vundle.git " . home_dir . "/.vim/bundle/vundle"
    if v:shell_error
      finish
    else
      silent ! vim +BundleInstall +qall
    endif
  endif
" }

" Tern Install {
  let tern_dir = expand(home_dir . '/.vim/bundle/tern_for_vim', 1)
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
    Bundle 'pangloss/vim-javascript'
    Bundle 'marijnh/tern_for_vim'
    Bundle 'rosenfeld/conque-term'
    Bundle 'vim-scripts/YankRing.vim'

    Bundle 'mileszs/ack.vim'
    let g:ackprg = 'ag --nogroup --nocolor --column --smart-case'

    Bundle 'editorconfig/editorconfig-vim'

    " tpope is an icon!
    Bundle 'tpope/vim-fugitive'
    Bundle 'tpope/vim-git'
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

    " center screen
    noremap <Space> zz

    " open file from same dir
    map <leader>ew :e <C-R>=expand("%:h") . "/" <CR>
    map <leader>vsw :vs <C-R>=expand("%:h") . "/" <CR>

    " run tests via jasmine
    map <leader>t :wa \|! jasmine-node *.spec.js --noColor <CR>

    " search in yank ring
    nnoremap <leader><Space> :YRShow<CR>
    inoremap <leader><Space> :YRShow<CR>

    " indent!
    nnoremap <Tab> >>
    nnoremap <S-Tab> <<
    vnoremap <Tab> >gv
    vnoremap <S-Tab> <gv

    " toggle spell
    nnoremap <F8> :setlocal spell! spell?<CR>

    " when you forget to open with sudo...
    cmap w!! w !sudo tee > /dev/null %

    " easier omni-complete
    imap <C-Space> <C-X><C-O>

    " close buffer
    nmap <C-W>! <Plug>Kwbd

    " focus mode
    function! ToggleFocusMode()
      if (&foldcolumn != 12)
        set laststatus=0
        set numberwidth=10
        set foldcolumn=12
        set noruler
        set nonumber
        set guifont=Helvetica:h16
        hi FoldColumn ctermbg=none
        hi LineNr ctermfg=0 ctermbg=none
        hi NonText ctermfg=0
      else
        set laststatus=2
        set numberwidth=4
        set foldcolumn=0
        set ruler
        set number
        set guifont=Consolas:h10
        execute 'colorscheme ' . g:colors_name
      endif
    endfunc
    nnoremap <F1> :call ToggleFocusMode()<cr>

python << EOL
import vim
def EvaluateCurrentRange():
    eval(compile('\n'.join(vim.current.range),'','exec'),globals())
EOL

    map <C-h> :py EvaluateCurrentRange()<CR>
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


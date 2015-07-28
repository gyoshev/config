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
    Plugin 'gmarik/vundle'

    Plugin 'Railscasts-Theme-GUIand256color'
    Plugin 'moll/vim-bbye'
    Plugin 'groenewege/vim-less'
    Plugin 'msanders/snipmate.vim'
    Plugin 'scrooloose/nerdcommenter'
    Plugin 'scrooloose/nerdtree'
    Plugin 'pangloss/vim-javascript'
    Plugin 'marijnh/tern_for_vim'
    Plugin 'rosenfeld/conque-term'

    Plugin 'mileszs/ack.vim'

    Plugin 'editorconfig/editorconfig-vim'
    let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

    Plugin 'mattn/emmet-vim'

    " tpope is an icon!
    Plugin 'tpope/vim-fugitive'
    Plugin 'tpope/vim-git'
    Plugin 'tpope/vim-unimpaired'
    Plugin 'tpope/vim-surround'
    Plugin 'tpope/vim-ragtag'
    Plugin 'tpope/vim-sexp-mappings-for-regular-people'
    Plugin 'tpope/vim-leiningen'
    Plugin 'tpope/vim-projectionist'
    Plugin 'tpope/vim-dispatch'
    Plugin 'tpope/vim-fireplace'
    let g:ragtag_global_maps = 1

    Plugin 'kien/ctrlp.vim'

    " show last mode
    let g:ctrlp_cmd = 'CtrlPLastMode'

    " use ag if available
    if executable('ag')
       let g:ackprg = 'ag --nogroup --nocolor --column --smart-case'
       set grepprg=ag\ --nogroup\ --nocolor
       let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    endif

    set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
    set laststatus=2
    Plugin 'Lokaltog/vim-powerline'
    Plugin 'Lokaltog/vim-easymotion'

    Plugin 'guns/vim-sexp'
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
    let mapleader=","

    noremap <C-S> :w<CR>
    inoremap <C-S> <C-O>:w<CR>

    noremap <S-CR> <Esc>

    set backspace=indent,eol,start " make backspace behave consistently with other apps

    " delete trailing whitespace
    nnoremap <silent> <leader>w :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

    " toggle NerdTree
    noremap <leader>n :NERDTreeToggle<CR>

    " open file from same dir
    map <leader>ew :e <C-R>=expand("%:h") . "/" <CR>
    map <leader>vsw :vs <C-R>=expand("%:h") . "/" <CR>

    " run tests via jasmine
    map <leader>t :wa \|! jasmine-node *.spec.js --noColor <CR>

    " indent!
    nnoremap <Tab> >>
    nnoremap <S-Tab> <<
    vnoremap <Tab> >gv
    vnoremap <S-Tab> <gv

    " toggle spell
    nnoremap <F8> :setlocal spell! spell?<CR>

    " toggle paste
    nnoremap <F9> :set invpaste paste?<CR>
    set pastetoggle=<F9>

    " sudo write
    cmap w!! w !sudo tee > /dev/null %

    " easier omni-complete
    imap <C-Space> <C-X><C-O>

    " close buffer
    nmap <leader>q :Bdelete<CR>

    " eval buffer
    nmap <leader>eb :%Eval<CR>

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

    " REPL evaluation
    map <Leader>s :SlimuxREPLSendLine<CR>
    vmap <Leader>s :SlimuxREPLSendSelection<CR>
    map <Leader>a :SlimuxShellLast<CR>
    map <Leader>k :SlimuxSendKeysLast<CR>
    map <Leader>S :%SlimuxREPLSendSelection<CR>

if has("python")
python << EOL
import vim
def EvaluateCurrentRange():
    eval(compile('\n'.join(vim.current.range),'','exec'),globals())
EOL

    map <C-h> :py EvaluateCurrentRange()<CR>
endif
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


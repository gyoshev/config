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
    Plugin 'scrooloose/syntastic'
    let g:syntastic_javascript_checkers = ['eslint']
    let g:syntastic_javascript_eslint_exec = 'eslint_d'
    let g:syntastic_json_checkers = ['jsonlint']
    let g:syntastic_scss_checkers = ['scss_lint']
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 1
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_error_symbol = "✗"
    let g:syntastic_warning_symbol = "⚠"

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
    Plugin 'tpope/vim-eunuch'
    let g:ragtag_global_maps = 1

    Plugin 'kien/ctrlp.vim'

    " show last mode
    let g:ctrlp_cmd = 'call CallCtrlP()'

    func! CallCtrlP()
        " use mru as first ctrlp mode
        if exists('s:called_ctrlp')
            CtrlPLastMode
        else
            let s:called_ctrlp = 1
            CtrlPMRU
        endif
    endfunc

    Plugin 'junegunn/goyo.vim'

    " use ag if available
    if executable('ag')
       let g:ackprg = 'ag --nogroup --nocolor --column --smart-case'
       set grepprg=ag\ --nogroup\ --nocolor
    endif

    set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*
    set laststatus=2
    Plugin 'Lokaltog/vim-powerline'
    Plugin 'Lokaltog/vim-easymotion'

    Plugin 'guns/vim-sexp'

    Plugin 'nelstrom/vim-markdown-folding'
    let g:markdown_fold_style = 'nested'
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
    set wrapscan

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

    " easier omni-complete
    imap <C-Space> <C-X><C-O>

    " close buffer
    nmap <leader>q :Bdelete<CR>

    " eval buffer
    nmap <leader>eb :%Eval<CR>

    " focus mode
    nnoremap <silent> <leader>z :Goyo<cr>

    " cyrillic langmap
    set langmap =Ч~,ЯQ,ВW,ЕE,РR,ТT,ЪY,УU,ИI,ОO,ПP,Ш{,Щ},АA,СS,ДD,ФF,ГG,ХH,ЙJ,КK,ЛL,ЗZ,ЬZ,ЦC,ЖV,БB,НN,МM,ч`,яq,вw,еe,рr,тt,ъy,уu,иi,оo,пp,ш[,щ],аa,сs,дd,фf,гg,хh,йj,кk,лl,зz,ьz,цc,жv,бb,нn,мm

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
    autocmd BufReadPost *.md set filetype=markdown
    autocmd BufReadPost *.md set foldlevel=2
    autocmd BufRead,BufEnter,BufNew *.jsx let b:syntastic_checkers = ["eslint"]
" }


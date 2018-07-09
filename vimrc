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

filetype off
set rtp=~/.vim/bundle/vundle/,~/.vim,$VIMRUNTIME
let g:snippets_dir='~/.snippets/'
call vundle#rc()

" Plugins {
    Plugin 'gmarik/vundle'

    Plugin 'Railscasts-Theme-GUIand256color'
    Plugin 'moll/vim-bbye'
    Plugin 'groenewege/vim-less'

    let g:snipMate = get(g:, 'snipMate', {})
    let g:snipMate.scope_aliases = {}
    let g:snipMate.scope_aliases['typescript'] = 'typescript,javascript'
    Plugin 'MarcWeber/vim-addon-mw-utils'
    Plugin 'tomtom/tlib_vim'
    Plugin 'garbas/vim-snipmate'
    Plugin 'honza/vim-snippets'

    Plugin 'scrooloose/nerdcommenter'
    Plugin 'scrooloose/nerdtree'
    Plugin 'scrooloose/syntastic'
    let g:syntastic_javascript_checkers = ['eslint']
    let g:syntastic_javascript_eslint_exec = 'eslint_d'
    let g:syntastic_json_checkers = ['jsonlint']
    let g:syntastic_scss_checkers = ['scss_lint']
    let g:syntastic_python_checkers = ['pylint']
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 1
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_error_symbol = "✗"
    let g:syntastic_warning_symbol = "⚠"
    let g:syntastic_typescript_checkers = [] " ['tslint', 'tsc']
    let g:syntastic_typescript_tsc_args = '--experimentalDecorators'

    Plugin 'vale1410/vim-minizinc'

    Plugin 'pangloss/vim-javascript'
    Plugin 'mileszs/ack.vim'
    Plugin 'dyng/ctrlsf.vim'
    Plugin 'terryma/vim-multiple-cursors'

    Plugin 'editorconfig/editorconfig-vim'
    let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

    Plugin 'mattn/emmet-vim'

    " tpope is an icon!
    Plugin 'tpope/vim-fugitive'
    Plugin 'tpope/vim-git'
    Plugin 'tpope/vim-unimpaired'
    Plugin 'tpope/vim-surround'
    Plugin 'tpope/vim-ragtag'
    Plugin 'tpope/vim-projectionist'
    Plugin 'tpope/vim-dispatch'
    Plugin 'tpope/vim-eunuch'
    let g:ragtag_global_maps = 1

    Plugin 'ctrlpvim/ctrlp.vim'
    let g:ctrlp_cmd = 'CtrlPMRU'

    Plugin 'junegunn/goyo.vim'

    " use ag if available
    if executable('ag')
       let g:ackprg = 'ag --nogroup --nocolor --column --smart-case'
       set grepprg=ag\ --nogroup\ --nocolor
    endif

    if executable('prettier')
        autocmd FileType javascript set formatprg=prettier\ --stdin
    endif

    Plugin 'mbbill/undotree'
    if has("persistent_undo")
        set undodir=~/.undodir/
        set undofile
    endif

    set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*
    set laststatus=2
    Plugin 'Lokaltog/vim-powerline'
    Plugin 'Lokaltog/vim-easymotion'

    Plugin 'guns/vim-sexp'
    Plugin 'tmhedberg/matchit'

    Plugin 'ervandew/supertab.git'

    " TypeScript
    Plugin 'leafgarland/typescript-vim'
    Plugin 'Shougo/vimproc.vim'
    "Plugin 'Quramy/tsuquyomi'

    Plugin 'nelstrom/vim-markdown-folding'
    let g:markdown_fold_style = 'nested'

    if executable('stack')
        " Haskell
        Plugin 'eagletmt/ghcmod-vim.git'
        Plugin 'eagletmt/neco-ghc'
        Plugin 'godlygeek/tabular.git'
        Plugin 'Shougo/neocomplete.vim.git'

        Plugin 'haskell.vim'
        Plugin 'cabal.vim'

        if !executable('hlint')
            execute "! stack install hlint ghc-mod"
        endif

        map <silent> <leader>ht :GhcModType<CR>
        map <silent> <leader>hi :GhcModTypeInsert<CR>
        map <silent> <leader>hc :GhcModTypeClear<CR>
        map <silent> <leader>hs :GhcModSplitFunCase<CR>
        map <silent> <leader>hc :GhcModCheck<CR>
    endif
" }

" General {
    set hidden

    set clipboard^=unnamed,unnamedplus

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

    " toggle UndoTree
    nnoremap <leader>u :UndotreeToggle<CR>

    " ctrlsf map
    nmap     <leader>f <Plug>CtrlSFPrompt
    vmap     <leader>f <Plug>CtrlSFVwordPath
    vmap     <leader>F <Plug>CtrlSFVwordExec

    " open file from same dir
    map <leader>ew :e <C-R>=expand("%:h") . "/" <CR>
    map <leader>vsw :vs <C-R>=expand("%:h") . "/" <CR>

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

    " local replace
    vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

    " easier omni-complete
    imap <C-Space> <C-X><C-O>

    " close buffer
    nmap <leader>q :Bdelete<CR>

    " eval buffer
    nmap <leader>eb :%Eval<CR>

    " focus mode
    nnoremap <silent> <leader>z :Goyo<cr>:set linebreak<cr>

    " cyrillic langmap
    set langmap =Ч~,ЯQ,ВW,ЕE,РR,ТT,ЪY,УU,ИI,ОO,ПP,Ш{,Щ},АA,СS,ДD,ФF,ГG,ХH,ЙJ,КK,ЛL,ЗZ,ЬZ,ЦC,ЖV,БB,НN,МM,ч`,яq,вw,еe,рr,тt,ъy,уu,иi,оo,пp,ш[,щ],аa,сs,дd,фf,гg,хh,йj,кk,лl,зz,ьz,цc,жv,бb,нn,мm

if has("python")
python << EOL
import vim
def EvaluateCurrentRange():
    eval(compile('\n'.join(vim.current.range).strip(),'','exec'),globals())
EOL

    map <C-h> :py EvaluateCurrentRange()<CR>
endif

    " supertab
    let g:SuperTabDefaultCompletionType = '<c-x><c-o>'

    if has("gui_running")
      imap <c-space> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
    else " no gui
      if has("unix")
        inoremap <Nul> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
      endif
    endif
" }

" Coding {
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

    autocmd BufRead,BufNewFile *.cshtml set filetype=html
    autocmd BufRead,BufNewFile *.md     set filetype=markdown
    autocmd BufRead,BufNewFile *.md     set foldlevel=2
    autocmd BufRead,BufNewFile *.json   set filetype=json

    autocmd FileType gitcommit          setlocal spell
    autocmd FileType jsx                let b:syntastic_checkers = ["eslint"]
    autocmd FileType typescript         nmap <buffer> <Leader>t : <C-u>echo tsuquyomi#hint()<CR>
    autocmd FileType markdown           setlocal linebreak
    autocmd FileType markdown           nmap j gj
    autocmd FileType markdown           nmap k gk

    let g:haskellmode_completion_ghc = 1
    autocmd FileType haskell            setlocal omnifunc=necoghc#omnifunc
" }


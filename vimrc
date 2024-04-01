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

" Plugins {
    call vundle#begin()
    Plugin 'gmarik/vundle'

    " use rg/ag if available
    if executable('rg')
       let g:ctrlsf_ackprg = 'rg'
       let g:ackprg = 'rg --color=never --column --smart-case'
       let g:ctrlp_user_command = 'rg %s -l --color=never -g ""'
    elseif executable('ag')
       let g:ackprg = 'ag --nogroup --nocolor --column --smart-case'
       set grepprg=ag\ --nogroup\ --nocolor
       let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    endif

    Plugin 'morhetz/gruvbox'
    Plugin 'moll/vim-bbye'
    Plugin 'groenewege/vim-less'

    Plugin 'MarcWeber/vim-addon-mw-utils'
    Plugin 'tomtom/tlib_vim'
    Plugin 'honza/vim-snippets'

    Plugin 'scrooloose/nerdcommenter'
    Plugin 'scrooloose/nerdtree'

    Plugin 'pangloss/vim-javascript'
    Plugin 'mileszs/ack.vim'
    let g:ctrlsf_auto_focus = { "at": "start" }
    let g:ctrlsf_mapping = {
      \ "quit": "q",
      \ "next": "n",
      \ "prev": "N",
      \ "vsplit": "s",
    \ }
    Plugin 'dyng/ctrlsf.vim'

    Plugin 'editorconfig/editorconfig-vim'
    let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

    Plugin 'mattn/emmet-vim'

    Plugin 'posva/vim-vue'

    Plugin 'tpope/vim-fugitive'
    Plugin 'tpope/vim-git'
    Plugin 'tpope/vim-unimpaired'
    Plugin 'tpope/vim-surround'
    Plugin 'tpope/vim-ragtag'
    Plugin 'tpope/vim-projectionist'
    Plugin 'tpope/vim-dispatch'
    Plugin 'tpope/vim-eunuch'
    Plugin 'tpope/vim-rhubarb'
    let g:ragtag_global_maps = 1

    Plugin 'ctrlpvim/ctrlp.vim'
    let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
    let g:ctrlp_cmd = 'CtrlPMRU'

    Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plugin 'junegunn/fzf.vim'
    Plugin 'junegunn/goyo.vim'

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

    " TypeScript
    Plugin 'leafgarland/typescript-vim'
    Plugin 'Shougo/vimproc.vim'

    Plugin 'neoclide/coc.nvim', {'branch': 'release'}
    let g:coc_global_extensions = [ 'coc-tsserver', 'coc-java', 'coc-snippets' ]

    if executable('rustc')
        " Rust
        Plugin 'rust-lang/rust.vim'
    endif

    " Markdown
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
    call vundle#end()
" }

" General {
    set hidden

    set clipboard=unnamedplus,unnamed

    set encoding=utf-8

    let g:gruvbox_contrast_dark = 'hard'
    colorscheme gruvbox

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
    set updatetime=300
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
    noremap <leader>n<Space> :NERDTreeToggle<CR>
    noremap <leader>nf :NERDTreeFind<CR>
    noremap <leader>nr :NERDTreeRefreshRoot<CR>

    " toggle UndoTree
    nnoremap <leader>u :UndotreeToggle<CR>

    " fzf
    nnoremap <C-f> :FZF<CR>

    " ctrlsf map
    nmap     <leader>f <Plug>CtrlSFPrompt
    vmap     <leader>f <Plug>CtrlSFVwordPath
    vmap     <leader>F <Plug>CtrlSFVwordExec
    nnoremap R :CtrlSF <C-R><C-W> -R -W<CR>

    " open file from same dir
    map <leader>ew :e <C-R>=expand("%:h") . "/" <CR>
    map <leader>vsw :vs <C-R>=expand("%:h") . "/" <CR>

    " indent!
    nnoremap <Tab> >>
    nnoremap <S-Tab> <<
    vnoremap <Tab> >gv
    vnoremap <S-Tab> <gv

    " forward-back in history
    noremap ( <C-o>
    noremap ) <C-i>

    " toggle spell
    nnoremap <F8> :setlocal spell! spell?<CR>

    " toggle paste
    nnoremap <F9> :set invpaste paste?<CR>
    set pastetoggle=<F9>

    " local replace
    vnoremap <C-r> "hy:%s/\<<C-r>h\>//gc<left><left><left>

    nmap <leader>rn  <Plug>(coc-rename)
    nmap <leader>cx  <Plug>(coc-codeaction)
    nmap <leader>cf  <Plug>(coc-fix-current)
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)
    nmap <silent> <c-k> <Plug>(coc-diagnostic-prev)
    nmap <silent> <c-j> <Plug>(coc-diagnostic-next)

    nmap <leader>b   :Git blame<CR>

    inoremap <silent><expr> <TAB>
          \ coc#pum#visible() ? coc#pum#confirm() :
          \ CheckBackspace() ? "\<Tab>" :
          \ coc#refresh()
    inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm(): "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
    inoremap <silent><expr> <c-@> coc#refresh()

    let g:coc_snippet_next = '<tab>'

    " close buffer
    nmap <leader>q :Bdelete<CR>

    " eval buffer
    nmap <leader>eb :%Eval<CR>

    " focus mode
    nnoremap <silent> <leader>z :Goyo<cr>:set linebreak<cr>

    " cyrillic langmap
    set langmap =Ч~,ЯQ,ВW,ЕE,РR,ТT,ЪY,УU,ИI,ОO,ПP,Ш{,Щ},АA,СS,ДD,ФF,ГG,ХH,ЙJ,КK,ЛL,ЗZ,ЬZ,ЦC,ЖV,БB,НN,МM,ч`,яq,вw,еe,рr,тt,ъy,уu,иi,оo,пp,ш[,щ],аa,сs,дd,фf,гg,хh,йj,кk,лl,зz,ьx,цc,жv,бb,нn,мm

    " λ
    inoremap ¬ <C-K>*l

if has("python")
python << EOL
import vim
def EvaluateCurrentRange():
    eval(compile('\n'.join(vim.current.range).strip(),'','exec'),globals())
EOL

    map <leader>py :py EvaluateCurrentRange()<CR>
endif
" }

" Coding {
    set guifont=Consolas:h10
    set number
    syntax on

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
    autocmd FileType markdown           setlocal linebreak
    autocmd FileType markdown           nmap j gj
    autocmd FileType markdown           nmap k gk

    let g:haskellmode_completion_ghc = 1
    autocmd FileType haskell            setlocal omnifunc=necoghc#omnifunc
" }


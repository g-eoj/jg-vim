set nocompatible

"WINDOWS COMPATIBLE {
  "On Windows use '.vim' instead of 'vimfiles';
  if has('win32') || has('win64')
    set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
  endif

"END WINDOWS COMPATIBLE }

"VUNDLE {
  filetype off
  set rtp+=~/.vim/bundle/vundle/
  call vundle#rc()

  Bundle 'gmarik/vundle'

  Bundle 'airblade/vim-gitgutter'
  Bundle 'godlygeek/csapprox'
  Bundle 'mbbill/undotree'
  Bundle 'nathanaelkane/vim-indent-guides'
  Bundle 'scrooloose/nerdtree'
  " Bundle 'scrooloose/syntastic' " Removed -> install issue. Does it conflict with Python Mode? Needs tidy for html.
  Bundle 'tpope/vim-commentary'
  Bundle 'tpope/vim-fugitive'
  Bundle 'tpope/vim-markdown'
  Bundle 'Wombat'

  "Python
  Bundle 'klen/python-mode'

  "HTML & CSS
  Bundle 'amirh/HTML-AutoCloseTag'
  Bundle 'groenewege/vim-less' 
  Bundle 'hail2u/vim-css3-syntax'

  "JavaScript
  Bundle 'pangloss/vim-javascript'

  "ctrlp
  "surround
  "tabularize

  "from spf13 {
    " Bundle 'MarcWeber/vim-addon-mw-utils'
    " Bundle 'tomtom/tlib_vim'
    " if executable('ack-grep')
    "   let g:ackprg="ack-grep -H --nocolor --nogroup --column"
    "   Bundle 'mileszs/ack.vim'
    " elseif executable('ack')
    "   Bundle 'mileszs/ack.vim'
    " endif

    " General {
    " Bundle 'tpope/vim-surround'
    " Bundle 'AutoClose'
    " Bundle 'kien/ctrlp.vim'
    " Bundle 'vim-scripts/sessionman.vim'
    " Bundle 'matchit.zip'
    " Bundle 'Lokaltog/vim-powerline'
    " Bundle 'Lokaltog/vim-easymotion'
    " Bundle 'jistr/vim-nerdtree-tabs'
    " Bundle 'corntrace/bufexplorer'
    " Bundle 'myusuf3/numbers.vim'
    " }

    " General Programming {
    " Pick one of the checksyntax, jslint, or syntastic
    " Bundle 'mattn/webapi-vim'
    " Bundle 'mattn/gist-vim'
    " Bundle 'godlygeek/tabular'
    " if executable('ctags')
    "   Bundle 'majutsushi/tagbar'
    " endif
    " }

    " Snippets & AutoComplete {
    " if count(g:spf13_bundle_groups, 'snipmate')
    "   Bundle 'garbas/vim-snipmate'
    "   Bundle 'honza/snipmate-snippets'
    "   " Source support_function.vim to support snipmate-snippets.
    "   if filereadable(expand("~/.vim/bundle/snipmate-snippets/snippets/support_functions.vim"))
    "     source ~/.vim/bundle/snipmate-snippets/snippets/support_functions.vim
    "   endif
    " elseif count(g:spf13_bundle_groups, 'neocomplcache')
    "   Bundle 'Shougo/neocomplcache'
    "   Bundle 'Shougo/neosnippet'
    "   Bundle 'honza/snipmate-snippets'
    " endif
    " }

    " Python {
    " Bundle 'python.vim'
    " Bundle 'python_match.vim'
    " Bundle 'pythoncomplete'
    " }

    " Javascript {
    " Bundle 'leshill/vim-json'
    " Bundle 'briancollins/vim-jst'
    " }

  " }

  filetype plugin indent on

"END VUNDLE }

"GENERAL {
  " Misc. Behavior
    set backspace=indent,eol,start

    if has ("unix") && "Darwin" != system("echo -n \"$(uname)\"")
      "On Linux use + register for copy-paste.
      set clipboard=unnamedplus
    else
      "One Mac and Windows, use * register for copy-paste.
      set clipboard=unnamed
    end

    set history=1000
    set ignorecase
    set incsearch
    set mouse=a
    set pastetoggle=<F12>
    set smartcase
    set spelllang=en_us
    set ttimeout
    set ttimeoutlen=50
    " set viewoptions=folds,options,cursor,unix,slash

    if has('persistent_undo')
      set undofile
      set undolevels=1000
      set undoreload=10000
    endif

  " Indentation
    set autoindent
    set expandtab
    set shiftround
    set shiftwidth=2
    set softtabstop=2
    " set tabstop=4

  " Buffers
    set autoread
    " set autowrite "Automatically save before commands like :next and :make
    set hidden

    if has("autocmd")
      "Always switch to current file directory.
      autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://"| lcd %:p:h | endif
      "Always save and load view.
      autocmd BufWinLeave * if expand("%") != "" | mkview | endif
      autocmd BufWinEnter * if expand("%") != "" | loadview | endif
      "Source the vimrc file after saving it.
      autocmd BufWritePost .vimrc source $MYVIMRC
    endif

  " Encoding
    if has("multi_byte")
      if &termencoding == ""
        let &termencoding = &encoding
      endif
      set encoding=utf-8
      setglobal fileencoding=utf-8
      "setglobal bomb
      set fileencodings=ucs-bom,utf-8,latin1
    endif

"END GENERAL }

"UI {
  set background=dark
  if filereadable(expand("~/.vim/bundle/Wombat/colors/wombat.vim"))
    colorscheme wombat
  endif
  if has('gui_running')
    set guifont=Consolas:h10:cDEFAULT
    set guioptions-=r
    set guioptions-=T
  else
    if &term == 'xterm' || &term == 'screen'
      "Enable 256 colors to stop the CSApprox warning.
      set t_Co=256
    endif
  endif

  syntax on
  set display+=lastline
  set number
  set showbreak=...
  set showmatch
  set showmode
  " set textwidth=78
  set wildmenu
  " set wildmode=list:longest,full
  if has('cmdline_info')
    " set ruler
    " set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
    set showcmd
  endif
  if has('statusline')
    set laststatus=2
    "Broken down into easily includeable segments.
    set statusline=%<%f\    "Filename
    set statusline+=%w%h%m%r "Options
    set statusline+=%{fugitive#statusline()} "Git
    set statusline+=\ [%{&ff}/%Y]            "Filetype
    set statusline+=\ [%{getcwd()}]          "Current dir
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%  "Right aligned file nav info
  endif

  if &listchars ==# 'eol:$'
    set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
  endif

  if !&scrolloff
    set scrolloff=1
  endif
  if !&sidescrolloff
    set sidescrolloff=5
  endif

"END UI }

"MAPPINGS {
  let mapleader = ','

  "Easier moving in tabs and windows.
  map <C-H> <C-W>h
  map <C-J> <C-W>j
  map <C-K> <C-W>k
  map <C-L> <C-W>l

  "Wrapped lines goes down/up to next row, rather than next line in file.
  nnoremap j gj
  nnoremap k gk

  "Toggle highlight search.
  nnoremap <silent> <leader>hl :set hlsearch! hlsearch?<CR>

  "Toggle spell check.
  nnoremap <silent> <leader>s :set spell! spell?<CR>

  "Make Y consistent with C and D. See :help Y.
  nnoremap Y y$

  "Reset folds.
  nnoremap <leader>z zMzzza

  "Toggle fold.
  nnoremap <MiddleMouse> za
  nnoremap <space> za

  "Visual shifting (does not exit Visual mode).
  vnoremap < <gv
  vnoremap > >gv

"END MAPPINGS }

"PLUGINS {
  "Fugitive
    nnoremap <silent> <leader>gs :Gstatus<CR>
    nnoremap <silent> <leader>gd :Gdiff<CR>
    nnoremap <silent> <leader>gc :Gcommit<CR>
    nnoremap <silent> <leader>gb :Gblame<CR>
    nnoremap <silent> <leader>gl :Glog<CR>
    nnoremap <silent> <leader>gp :Git push<CR>

  "GitGutter
    let g:gitgutter_enabled = 0
    nnoremap <silent> <leader>g] :GitGutterNextHunk<CR>
    nnoremap <silent> <leader>g[ :GitGutterPrevHunk<CR>
    nnoremap <silent> <leader>gg :GitGutterToggle<CR>

  "Indent Guides
    let g:indent_guides_start_level = 2
    let g:indent_guides_guide_size = 1
    let g:indent_guides_color_change_percent = 5
    " let g:indent_guides_enable_on_vim_startup = 1

  "NerdTree
    " let NERDTreeShowBookmarks=1
    let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
    " let NERDTreeChDirMode=0
    let NERDTreeQuitOnOpen=1
    " let NERDTreeMouseMode=2
    " let NERDTreeShowHidden=1
    " let NERDTreeKeepTreeInNewTab=1
    " let g:nerdtree_tabs_open_on_gui_startup=0
    map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
    map <leader>e :NERDTreeFind<CR>
    nmap <leader>nt :NERDTreeFind<CR>
    nmap <leader>nb :NERDTreeFromBookmark

  "Python Mode
    let g:pymode_lint_cwindow = 0
    "Disable if python support not present
    if !has('python')
      let g:pymode = 1
    endif
    nnoremap <leader>lw :PyLintWindowToggle<CR>

  "UndoTree
    let g:undotree_SetFocusWhenToggle = 1
    nnoremap <Leader>u :UndotreeToggle<CR>

"END PLUGINS }

"FUNCTIONS {
  function! InitializeDirectories()
    let separator = "."
    let parent = $HOME
    let prefix = '.vim'
    let dir_list = {
                \ 'backup': 'backupdir',
                \ 'views': 'viewdir',
                \ 'swap': 'directory' }

    if has('persistent_undo')
      let dir_list['undo'] = 'undodir'
    endif

    for [dirname, settingname] in items(dir_list)
      let directory = parent . '/' . prefix . dirname . "/"
      if exists("*mkdir")
        if !isdirectory(directory)
          call mkdir(directory)
        endif
      endif
      if !isdirectory(directory)
        echo "Warning: Unable to create backup directory: " . directory
        echo "Try: mkdir -p " . directory
      else
        let directory = substitute(directory, " ", "\\\\ ", "g")
        exec "set " . settingname . "=" . directory
      endif
    endfor
  endfunction
  call InitializeDirectories()

"END FUNCTIONS }

"EXPERIMENTAL {

  " highlight link SignColumn LineNr

  " Always show line numbers, but only in current window.
  set number
  :au WinEnter * :setlocal number
  :au WinLeave * :setlocal nonumber

  " Automatically resize vertical splits.
  " :au WinEnter * :set winfixheight
  " :au WinEnter * :wincmd =

  " set cursorline
  set lazyredraw

  " scriptencoding utf-8
  " set shortmess+=filmnrxoOtT      " abbrev. of messages (avoids 'hit enter')
  " set virtualedit=onemore         " allow for cursor beyond last character

  " set complete-=i
  set smarttab

  " set nrformats-=octal

  " set fileformats+=mac

  set viminfo^=!

  set backup " Backups are nice ...

  " let s:dir = has('win32') ? '$APPDATA/Vim' : match(system('uname'), "Darwin") > -1 ? '~/Library/Vim' : empty($XDG_DATA_HOME) ? '~/.local/share/vim' : '$XDG_DATA_HOME/vim'
  " if isdirectory(expand(s:dir))
  "   if &directory =~# '^\.,'
  "     let &directory = expand(s:dir) . '/swap//,' . &directory
  "   endif
  "   if &backupdir =~# '^\.,'
  "     let &backupdir = expand(s:dir) . '/backup//,' . &backupdir
  "   endif
  "   if exists('+undodir') && &undodir =~# '^\.\%(,\|$\)'
  "     let &undodir = expand(s:dir) . '/undo//,' . &undodir
  "   endif
  " endif
  " if exists('+undofile')
  "   set undofile
  " endif

  "Allow color schemes to do bright colors without forcing bold.
  " if &t_Co == 8 && $TERM !~# '^linux'
  "   set t_Co=16
  " endif

  " if !exists('g:netrw_list_hide')
  "   let g:netrw_list_hide = '^\.,\~$,^tags$'
  " endif

  "Load matchit.vim, but only if the user hasn't installed a newer version.
  if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
    runtime! macros/matchit.vim
  endif

"END EXPERIMENTAL }

" vim: set foldmarker={,} foldmethod=marker tw=0:

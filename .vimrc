set nocompatible               

"WINDOWS COMPATIBLE
  "On Windows use '.vim' instead of 'vimfiles';
  if has('win32') || has('win64')
    set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
  endif

"END WINDOWS COMPATIBLE 

"VUNDLE
  filetype off

  set rtp+=~/.vim/bundle/vundle/
  call vundle#rc()

  Bundle 'gmarik/vundle'
  Bundle 'tpope/vim-fugitive'
  Bundle 'scrooloose/nerdtree'

  filetype plugin indent on

"END VUNDLE

"always switch to current file directory
autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://"| lcd %:p:h | endif

"UI
  syntax on
  set number
  set showcmd		"Show (partial) command in status line.
  set showmatch		"Show matching brackets.
  "set textwidth=78       "Wrap at this column

  if has('statusline')
    set laststatus=2
    "Broken down into easily includeable segments
    set statusline=%<%f\    "Filename
    set statusline+=%w%h%m%r "Options
    set statusline+=%{fugitive#statusline()} "Git Hotness
    set statusline+=\ [%{&ff}/%Y]            "filetype
    set statusline+=\ [%{getcwd()}]          "current dir
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%  "Right aligned file nav info
  endif

"END UI

set ignorecase		"Do case insensitive matching
set smartcase		"Do smart case matching
set incsearch		"Incremental search
"set hlsearch           "Highlight all matching search phrases
"set hidden             "Hide buffers when they are abandoned
"set mouse=a		"Enable mouse usage (all modes)
set pastetoggle=<F12>   "Sane indentation on pastes
set backspace=indent,eol,start    "Make backspaces delete sensibly

set autoindent                    "Preserve current indent on new lines
"set tabstop=4                    "Indentation levels every x columns
set expandtab                     "Convert all tabs typed to spaces
set shiftwidth=2                  "Indent/outdent by x columns
set softtabstop=2
set shiftround                    "Indent/outdent to nearest tabstop

"Python
"autocmd FileType python set softtabstop=4|set shiftwidth=4 
"Perl
"autocmd FileType perl set softtabstop=4|set shiftwidth=4
"let perl_include_pod = 1
"let perl_extended_vars = 1

"set noswapfile
"set autowrite		"Automatically save before commands like :next and :make

if has("multi_byte")    "if not, we need to recompile
  if &enc !~? '^u'      "if the locale 'encoding' starts with u or U then Unicode is already set
    if &tenc == ''
      let &tenc = &enc  "save the keyboard charset
    endif
    set enc=utf-8       "to support Unicode fully, we need to be able to represent all Unicode codepoints in memory
  endif
  set fencs=ucs-bom,utf-8,latin1
  "setg bomb             "default for new Unicode files
  setg fenc=utf-8      "default for files created from scratch
else
  echomsg 'Warning: Multibyte support is not compiled-in.'
endif

"MAPPINGS
  let mapleader = ',' 

  "wrapped lines goes down/up to next row, rather than next line in file
  nnoremap j gj
  nnoremap k gk

  "visual shifting (does not exit Visual mode)
  vnoremap < <gv
  vnoremap > >gv

"END MAPPINGS

"PLUGINS
  "Fugitive
    nnoremap <silent> <leader>gs :Gstatus<CR>
    nnoremap <silent> <leader>gd :Gdiff<CR>
    nnoremap <silent> <leader>gc :Gcommit<CR>
    nnoremap <silent> <leader>gb :Gblame<CR>
    nnoremap <silent> <leader>gl :Glog<CR>
    nnoremap <silent> <leader>gp :Git push<CR>
  
  "NerdTree
    map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
    map <leader>e :NERDTreeFind<CR>
    nmap <leader>nt :NERDTreeFind<CR>

    "let NERDTreeShowBookmarks=1
    "let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
    "let NERDTreeChDirMode=0
    "let NERDTreeQuitOnOpen=1
    "let NERDTreeMouseMode=2
    "let NERDTreeShowHidden=1
    "let NERDTreeKeepTreeInNewTab=1
    "let g:nerdtree_tabs_open_on_gui_startup=0

"END PLUGINS

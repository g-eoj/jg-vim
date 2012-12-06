set nocompatible               

"vundle
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/nerdtree'

filetype plugin indent on
"end vundle

syntax on
set number
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
"set textwidth=78       "Wrap at this column

set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
"set hlsearch            " Highlight all matching search phrases
"set hidden             " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)
set pastetoggle=<F12>
set backspace=indent,eol,start    "Make backspaces delete sensibly

set autoindent                    "Preserve current indent on new lines
"set tabstop=4                     "Indentation levels every four columns
set expandtab                     "Convert all tabs typed to spaces
set shiftwidth=2                  "Indent/outdent by four columns
set softtabstop=2
set shiftround                    "Indent/outdent to nearest tabstop

"Python
"autocmd FileType python set softtabstop=4|set shiftwidth=4 
"Perl
"autocmd FileType perl set softtabstop=4|set shiftwidth=4
"let perl_include_pod = 1
"let perl_extended_vars = 1

"set noswapfile
"set autowrite		" Automatically save before commands like :next and :make

if has("multi_byte")    " if not, we need to recompile
  if &enc !~? '^u'      " if the locale 'encoding' starts with u or U
                        " then Unicode is already set
    if &tenc == ''
      let &tenc = &enc  " save the keyboard charset
    endif
    set enc=utf-8       " to support Unicode fully, we need to be able
                        " to represent all Unicode codepoints in memory
  endif
  set fencs=ucs-bom,utf-8,latin1
  "setg bomb             " default for new Unicode files
  setg fenc=utf-8      " default for files created from scratch
else
  echomsg 'Warning: Multibyte support is not compiled-in.'
endif

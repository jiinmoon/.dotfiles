" Reset options for re-sourcing
set nocompatible

" Use plugin based on filetype
filetype indent plugin on

" Enable syntax highlighting
syntax on

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches
set hlsearch

" Case insensitive search; except when using captial letters
set ignorecase
set smartcase

" Allow backspace over autoindent, line breaks, and start of insert
set backspace=indent,eol,start

" Keep same indent.
set autoindent

" Stop movements from going to first char of a line
set nostartofline

" Always display the status line
set laststatus=2

" Use visual bell instead of annoying beeping noise
set visualbell

" And reset the terminal code for the visual bell
set t_vb=

" Enable mouse
set mouse=a

" Set the comand window height
set cmdheight=2

" Quickly time out of keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Set F11 to toggle between paste and nopaste
set pastetoggle=<F11>

" Indent Options
set shiftwidth=4
set softtabstop=4
set expandtab
set wrap
set textwidth=79
set formatoptions=tcqrn1

" Show file stats
set ruler

" Display line num and use relative numbering
set number
set relativenumber

" Color scheme (term)
set t_Co=256
set background=dark

" sudo save trick
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!

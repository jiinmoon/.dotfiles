" Reset options for re-sourcing
set nocompatible
filetype off

" Vundle related configs
"
" <-- start -->

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" additional plugins
Plugin 'ycm-core/YouCompleteMe'
let g:ycm_global_ycm_extra_conf = '/home/jmoon/.vim/bundle/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'

Plugin 'tpope/vim-fugitive'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'preservim/nerdtree'
Plugin 'itchyny/lightline.vim'
Plugin 'vim-scripts/taglist.vim'
Plugin 'fatih/vim-go'
Plugin 'morhetz/gruvbox'
"let g:gruvbox_italic=1
let g:gruvbox_italicize_strings=0
let g:gruvbox_improved_strings=1
Plugin 'frazrepo/vim-rainbow'
let g:rainbow_active = 1
Plugin 'Yggdroot/indentline'
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
Plugin 'airblade/vim-gitgutter'
Plugin 'easymotion/vim-easymotion' 


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
" <-- End -->


" Enable syntax highlighting
syntax on

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

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
set pastetoggle=<F10>

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

" Change colorscheme to gruvebox
autocmd VimEnter * colorscheme gruvbox

" Enable Rainbow Parentheses
autocmd VimEnter * RainbowLoad

set runtimepath+=~/.vim_runtime

source ~/.vim_runtime/vimrcs/basic.vim
source ~/.vim_runtime/vimrcs/filetypes.vim
source ~/.vim_runtime/vimrcs/plugins_config.vim
source ~/.vim_runtime/vimrcs/extended.vim

" relative line number
:set number relativenumber
:set nu rnu

" text wrapping
:set tw=80

try
source ~/.vim_runtime/my_configs.vim
catch
endtry

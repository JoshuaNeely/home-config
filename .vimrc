" plugins via Vundle!
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" plugins here
Plugin 'VundleVim/Vundle.vim'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'airblade/vim-gitgutter'
Plugin 'derekwyatt/vim-scala'
Plugin 'leafgarland/typescript-vim'

" end of plugins here
call vundle#end()
filetype plugin indent on
" :PluginList
" :PluginInstall
" :PluginSearch
" :PluginClean


" numbered rows 
set number

" show filename in bottom left
set statusline+=%F

" show line number, column, page% in botton right 
set ruler

" tabs to spaces
set tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab

" newlines start at last indent
set autoindent

" faster pane switching
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" tmux wrecking tab settings per filetime...?
autocmd FileType python,c,cpp setlocal shiftwidth=2 softtabstop=4 expandtab

" refresh faster; good for gitgutter plugin
set updatetime=250

" persist history across file sessions
set undofile
set undodir=~/.vim/undo//
set backupdir=~/.vim/backups//
set directory=~/.vim/swaps//

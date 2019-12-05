" ~~~~~ PLUGIN STUFF ~~~~~

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
Plugin 'prettier/vim-prettier'

" end of plugins here
call vundle#end()
filetype plugin indent on
" :PluginList
" :PluginInstall
" :PluginSearch
" :PluginClean

" refresh faster; good for gitgutter plugin
set updatetime=250


" ~~~~~ UI ~~~~~

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


" ~~~~~ TMUX + VIM PANES ~~~~~

" faster pane switching
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" tmux wrecking tab settings per filetype...?
autocmd FileType python,c,cpp setlocal shiftwidth=2 softtabstop=4 expandtab


" ~~~~~ MISCELLANIA ~~~~~

" move up file hierarchy until find a tag file (for ctags)
set tags=tags;/

" allow viewing whitespace, tabs, etc with F5
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,space:*,nbsp:␣
noremap <F5> :set list!<CR>
noremap <F7> :setr paste!<CR>
noremap <S-Y> :'<,'> w! /tmp/vimcopy<CR>
noremap <S-P> :r /tmp/vimcopy<CR>


" persist history across file sessions
set undofile
set undodir=~/.vim/undo//
set backupdir=~/.vim/backups//
set directory=~/.vim/swaps//

" Disable Background Color Erase (BCE) so that color schemes
" work properly when Vim is used inside tmux and GNU screen.
" Fix scrolling through long files sometimes breaking colorscheme
if &term =~ '256color'
  set t_ut=
endif

" get rid of alarmbells
" needed for linux subsystem on windows
set visualbell

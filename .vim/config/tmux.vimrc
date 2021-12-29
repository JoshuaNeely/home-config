" faster pane switching
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" tmux wrecking tab settings per filetype...?
autocmd FileType python,c,cpp setlocal shiftwidth=2 softtabstop=4 expandtab

" Disable Background Color Erase (BCE) so that color schemes
" work properly when Vim is used inside tmux and GNU screen.
" Fix scrolling through long files sometimes breaking colorscheme
if &term =~ '256color'
  set t_ut=
endif

" fix tmux distorting colors
set background=dark
set t_Co=256

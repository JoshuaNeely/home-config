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





" ~~~~~ MISCELLANIA ~~~~~

" move up file hierarchy until find a tag file (for ctags)
set tags=tags;/

" allow viewing whitespace, tabs, etc with F5
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,space:*,nbsp:␣
noremap <F5> :set list!<CR>

" copy/cut/paste to file. useful when global buffer not available over ssh
noremap <S-Y> :'<,'> w! /tmp/vimcopy<CR>
noremap <S-D> :'<,'> w! /tmp/vimcopy <bar> :'<,'> d<CR>
noremap <S-P> :r /tmp/vimcopy<CR>

" alternative method of copy to global buffer... make sure $DISPLAY is set
noremap <S-U> :'<,'> w !copy_to_clipboard<CR><CR>


" persist history across file sessions
set undofile
set undodir=~/.vim/undo//
set backupdir=~/.vim/backups//
set directory=~/.vim/swaps//

" get rid of alarmbells
" needed for linux subsystem on windows
set visualbell

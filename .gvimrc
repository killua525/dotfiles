" MacVim/gVim GUI entry point.

let s:gui_vimrc = expand('~/.vim/gvimrc')
if filereadable(s:gui_vimrc)
  execute 'source' fnameescape(s:gui_vimrc)
endif

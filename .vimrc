" Vim/MacVim/gVim entry point.
" The shared configuration lives under ~/.vim so GUI and terminal variants use
" the same settings.

let s:vim_dir = expand('~/.vim')
let g:dotfiles_vim_dir = s:vim_dir

if isdirectory(s:vim_dir)
  execute 'set runtimepath^=' . fnameescape(s:vim_dir)
  execute 'set runtimepath+=' . fnameescape(s:vim_dir . '/after')
endif

let s:main_vimrc = s:vim_dir . '/vimrc'
if filereadable(s:main_vimrc)
  execute 'source' fnameescape(s:main_vimrc)
endif

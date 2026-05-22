" Neovim entry point.
" Reuse the shared Vim configuration from ~/.vim while keeping Neovim's own
" config and data directories available for Neovim-specific state.

let s:candidates = [expand('~/.vim'), expand('~/vimfiles')]
let s:vim_dir = ''

for s:candidate in s:candidates
  if isdirectory(s:candidate)
    let s:vim_dir = s:candidate
    break
  endif
endfor

if empty(s:vim_dir)
  let s:vim_dir = expand('~/.vim')
endif

let g:dotfiles_vim_dir = s:vim_dir

if isdirectory(s:vim_dir)
  execute 'set runtimepath^=' . fnameescape(s:vim_dir)
  execute 'set runtimepath+=' . fnameescape(s:vim_dir . '/after')
endif

let s:main_vimrc = s:vim_dir . '/vimrc'
if filereadable(s:main_vimrc)
  execute 'source' fnameescape(s:main_vimrc)
endif

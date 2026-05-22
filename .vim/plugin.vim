"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let s:has_python = has('python3') || has('python') || has('pythonx')
let s:has_leaderf_support = s:has_python && (v:version > 704 || v:version == 704 && has('patch330'))
let s:has_leaderf_popup = has('nvim-0.5.0') || has('patch-8.1.1615')
let s:has_vim_go_support = has('nvim-0.4.0') || has('patch-8.2.5072')
let s:has_echodoc_support = v:version > 704 || v:version == 704 && has('patch774')
let s:has_ackprg = executable('rg') || executable('ag') || executable('ack') || executable('ack-grep')

call plug#begin('~/.vim/plugged')
if s:has_python
  Plug 'SirVer/ultisnips', { 'for' : ['cpp','go','markdown'] } " snip engine
  Plug 'honza/vim-snippets', { 'for' : ['cpp','go','markdown'] } " snip
endif
if s:has_echodoc_support
  Plug 'Shougo/echodoc.vim', { 'for' : ['cpp','go'] }
endif
Plug 'preservim/nerdcommenter' "Comment
Plug 'preservim/nerdtree'
if s:has_leaderf_support
  Plug 'Yggdroot/LeaderF'
endif
" Go
if s:has_vim_go_support
  Plug 'fatih/vim-go',{ 'for' : ['go'],'do': ':GoUpdateBinaries' }
endif
" for file type
if s:has_ackprg
  Plug 'mileszs/ack.vim', { 'for' : ['cpp','go'] }
endif
if executable('clang-format')
  Plug 'rhysd/vim-clang-format', { 'for' : ['cpp'] }
endif
Plug 'editorconfig/editorconfig-vim'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ack.vim settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if s:has_ackprg && executable('rg')
  let g:ackprg = 'rg --vimgrep --smart-case'
elseif s:has_ackprg && executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case'
elseif s:has_ackprg && executable('ack')
  let g:ackprg = 'ack --nogroup --nocolor --column'
elseif s:has_ackprg && executable('ack-grep')
  let g:ackprg = 'ack-grep --nogroup --nocolor --column'
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => leaderf settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" leaderf
if s:has_leaderf_support
  let g:Lf_UseCache=0
  let g:Lf_UseVersionControlTool=0
  let g:Lf_ShowDevIcons = 0
  let g:Lf_ShortcutF = '<C-P>'
  let g:Lf_WorkingDirectoryMode = 'Ac'
  let g:Lf_WindowPosition = s:has_leaderf_popup ? 'popup' : 'bottom'
  let g:Lf_WindowHeight=0.3
  nnoremap <leader>c :LeaderfCommand<CR>
  let g:Lf_WildIgnore = {
    \ 'dir': ['.svn','.git','.hg','.clangd','deps'],
    \ 'file': ['*.bak','*.o','.py[co]','.git*','.DS_Store']
    \}
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-go settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if s:has_vim_go_support
  augroup go
    au!
    let g:go_referrers_mode = 'gopls'
    let g:go_implements_mode = 'gopls'
    let g:go_rename_command = 'gopls'
    let g:go_metalinter_command = "gopls"
    let g:go_list_type = 'quickfix'
    let g:go_list_autoclose = 1
    let g:go_diagnostics_enabled = 1
    let g:go_gopls_matcher = 'fuzzy'
    let g:go_fmt_command = 'gopls'
    let g:go_highlight_diagnostic_errors = 1
    let g:go_highlight_diagnostic_warnings = 1
    let g:go_highlight_string_spellcheck = 1
    let g:go_imports_autosave = 1
    au InsertEnter * let mapleader = ""
    au FileType qf nmap <buffer> <cr> <cr>:ccl<cr>
    au FileType go nmap ge <Plug>(go-rename)
    au FileType go nmap gs <Plug>(go-def-stack)
    au FileType go nmap gr <Plug>(go-referrers)
  augroup END
endif

" last edit position
augroup last_edit_position
  au!
  au BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
augroup END


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => nerdcommenter settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTrimTrailingWhitespace = 1
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
nnoremap <C-t> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ultiSnips-triggers settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if s:has_python
  let g:UltiSnipsExpandTrigger='<tab>'
  let g:UltiSnipsListSnippets='<c-l>'
  let g:UltiSnipsSnippetDirectories=['mysnippets','UltiSnips']
  let g:UltiSnipsEditSplit='vertical'
  let g:UltiSnipsSnippetsDir=$HOME.'/.vim/mysnippets'
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => echodoc settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if s:has_echodoc_support
  let g:echodoc_enable_at_startup = 1
  let g:echodoc#type = exists('*popup_create') ? 'popup' : 'echo'
endif

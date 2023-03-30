"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
Plug 'SirVer/ultisnips', { 'for' : ['cpp','go','markdown'] } " snip engine
Plug 'honza/vim-snippets', { 'for' : ['cpp','go','markdown'] } " snip
Plug 'Shougo/echodoc.vim', { 'for' : ['cpp','go'] }
Plug 'preservim/nerdcommenter' "Comment
Plug 'preservim/nerdtree'
Plug 'Yggdroot/LeaderF'
" Go
Plug 'fatih/vim-go',{ 'for' : ['go'],'do': ':GoUpdateBinaries' }
" for file type
Plug 'mileszs/ack.vim', { 'for' : ['cpp','go'] }
Plug 'rhysd/vim-clang-format', { 'for' : ['cpp'] }
Plug 'editorconfig/editorconfig-vim'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'vim-scripts/peaksea'
call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => leaderf settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" leaderf
let g:Lf_UseCache=0
let g:Lf_UseVersionControlTool=0
let g:Lf_ShowDevIcons = 0
let g:Lf_ShortcutF = '<C-P>'
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowPosition = 'popup'
let g:Lf_WindowHeight=0.3
nnoremap <leader>c :LeaderfCommand<CR>
let g:Lf_WildIgnore = {
  \ 'dir': ['.svn','.git','.hg','.clangd','deps'],
  \ 'file': ['*.bak','*.o','.py[co]','.git*','.DS_Store']
  \}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-go settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
  " last edit position
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
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsListSnippets='<c-l>'
let g:UltiSnipsSnippetDirectories=['mysnippets','UltiSnips']
let g:UltiSnipsEditSplit='vertical'
let g:UltiSnipsSnippetsDir=$HOME.'/.vim/mysnippets'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => echodoc settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:echodoc_enable_at_startup = 1
let g:echodoc#type = 'popup'



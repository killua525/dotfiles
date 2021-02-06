let do_syntax_sel_menu = 1
let g:python3_host_prog= '~/.py3/bin/python3'
let do_no_lazyload_menus = 1
set laststatus=2
set sw=4 ts=4
set textwidth=78
set nocompatible   " Disable vi-compatibility
set backspace=2
set noswapfile
set noet
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936
scriptencoding utf-8
set path+=** " search subdir
set wildignore+=*.o,*~,*.pyc,*.class,*.swp
set wildmenu
set incsearch
set hlsearch
set showmatch
set splitright " for vs window in right
set cursorline
set showcmd
set autochdir
"set spell
set colorcolumn=101
" Better display for messages
set cmdheight=2
set tags=./.tags;,.tags
" for no plugin
set hidden
set t_ti= t_te= " reserve file content on screen
set completeopt-=preview
filetype indent on

call plug#begin(stdpath('data') . '/plugged')
Plug 'honza/vim-snippets', { 'for' : ['cpp','go','markdown'] } " snip
Plug 'scrooloose/nerdcommenter' "Comment
Plug 'Yggdroot/LeaderF'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Go
call plug#end()

let g:coc_global_extensions=[
			\'coc-json',
			\'coc-go',
			\'coc-clangd',
			\'coc-pyright',
			\'coc-rls',
			\]

let mapleader=','

if has('gui_macvim')
    winpos 0 0            " 指定窗口出现的位置，坐标原点在屏幕左上角
    " winpos 20 20            " 指定窗口出现的位置，坐标原点在屏幕左上角
    set lines=76 columns=239 " 指定窗口大小，lines为高度，columns为宽度
    " set lines=60 columns=160 " 指定窗口大小，lines为高度，columns为宽度
    set guioptions-=m       " 隐藏菜单栏
    set guioptions-=T       " 隐藏工具栏
"    set guioptions-=L       " 隐藏左侧滚动条
    set guioptions-=r       " 隐藏右侧滚动条
    set guioptions+=b        " 显示底部滚动条
    " set nowrap               " 设置不自动换行
    set guicursor=i-ci:block-Cursor/lCursor
    set shell=/bin/zsh
    set guifont=Monaco:h16
endif

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

" ale
" nmap <silent> ]c :ALENext<cr>
" nmap <silent> [c :ALEPrevious<cr>
" let g:ale_lint_on_text_changed='always'
" let g:ale_lint_delay=3
" let g:ale_lint_on_enter=0
" let g:ale_lint_on_save=1
" let g:ale_fix_on_save=1
" let g:ale_sign_error='E'
" let g:ale_sign_warning='W'
" let g:ale_fixers = {
"     \ 'go': ['goimports']
"     \}
" let g:ale_linters = {
"       \   'go': ['gopls'],
"       \   'csh': ['shell'],
"       \   'zsh': ['shell'],
"       \   'python': ['flake8', 'mypy', 'pylint'],
"       \   'rust': ['cargo','rustc'],
"       \   'c': [],
"       \   'cc': [],
"       \   'cxx': [],
"       \   'cpp': [],
"       \   'text': [],
"       \}

" nerdcommenter settings
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'


let g:echodoc_enable_at_startup = 1
let g:echodoc#type = 'popup'

command! -nargs=1 SS let @/ = '\V'.escape(<q-args>, '\')

let g:c_space_errors = 1
let g:c_gnu = 1
let g:c_no_cformat = 1
let g:c_no_curly_error = 1
if exists('g:c_comment_strings')
  unlet g:c_comment_strings
endif

" 命令行模式增强，ctrl - a到行首， -e 到行尾
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
noremap H ^
noremap L $
nnoremap gu gU
nnoremap gl gu
" Quickly close the current window
nnoremap <leader>t :terminal<CR>

" Quickly save the current file
nnoremap <leader>w :w<CR>
nnoremap <space> za

nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> <Nop>
nnoremap <Down> <Nop>

nnoremap <F2> :set nu! rnu!<cr>
nnoremap <F3> :set list!<cr>
nnoremap <F5> :set paste!<cr>
nnoremap <F6> :if exists("g:syntax_on") <BAR> syntax off <BAR> else <BAR> syntax enable <BAR> endif<cr>


" 分Smart way to move between windows
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l
inoremap jk <Esc>


autocmd FileType python setlocal et sta sw=4 sts=4
set statusline=%1*\%<%.50F\             "显示文件名和文件路径 (%<应该可以去掉)
set statusline+=%=%2*\%y%m%r%h%w\ %*        "显示文件类型及文件状态
set statusline+=%3*\%{&ff}\[%{&fenc}]\ %*   "显示文件编码类型
set statusline+=%4*\ row:%l/%L,col:%c\ %*   "显示光标所在行和列
set statusline+=%5*\%3p%%\%*            "显示光标前文本所占总文本的比例
" hi User1 cterm=none ctermfg=25 ctermbg=0
" hi User2 cterm=none ctermfg=208 ctermbg=0
" hi User3 cterm=none ctermfg=169 ctermbg=0
" hi User4 cterm=none ctermfg=100 ctermbg=0
" hi User5 cterm=none ctermfg=green ctermbg=0

let g:rustfmt_autosave = 1
let g:racer_cmd = $HOME . '/.cargo/bin/racer'
let g:racer_experimental_completer = 1

"" for coc
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

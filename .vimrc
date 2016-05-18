" encoding setting {{{
set encoding=utf-8
set fileencodings=utf-8,cp932,sjis,euc-jp,iso-2022-jp
set fileformat=unix
set fileformats=unix,dos,mac
" }}}

" filetype setting {{{
augroup MyAutoCmd
  autocmd!
  autocmd BufNewFile,BufRead *.gradle set filetype=groovy
augroup END
" }}}

" backup setting (don't create) {{{
set nowritebackup
set nobackup
set noswapfile
set backupdir-=.
" }}}

" display setting {{{
set number
set ruler
set laststatus=2 
set cmdheight=2
nnoremap <F3> :<C-u>setlocal relativenumber!<CR>
set foldmethod=marker
set cursorline
set backspace=indent,eol,start
" }}}

" indent {{{
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

set smartindent
set autoindent

augroup MyAutoCmd
  autocmd BufEnter * setlocal formatoptions-=r
  autocmd BufEnter * setlocal formatoptions-=o
  
  autocmd FileType java setlocal shiftwidth=4 tabstop=4 softtabstop=4
  autocmd FileType groovy setlocal shiftwidth=4 tabstop=4 softtabstop=4
  autocmd FileType apexcode setlocal shiftwidth=4 tabstop=4 softtabstop=4
augroup END
" }}}

" paste toggle {{{
set pastetoggle=<F2>
autocmd InsertLeave * set nopaste
" }}}

" Windows setting {{{
let s:is_windows = has('win32') || has('win64')

if s:is_windows
  set shellslash
endif
" }}}

" functions {{{
" make directory
function! s:Mkdir(dir)
  if !isdirectory(a:dir)
    call mkdir(a:dir, 'p')
  endif
endfunction

" generate javascript method comment 
function! s:GenDocJs()
  let l:line = line('.')
  let l:indent = indent(l:line)
  let l:prefix = repeat(' ', l:indent)
  let l:text = getline(l:line)
  let l:params = matchstr(l:text, '([^)]*)')
  let l:paramPat = '\([$a-zA-Z_0-9]\+\)[, ]*\(.*\)'

  echomsg params
 
  let l:vars = []
  let l:matchlist = matchlist(l:params, l:paramPat)

  while l:matchlist != []
    let [_, l:var; l:rest] = l:matchlist
    let l:vars += [l:prefix . ' * @param ' . l:var]
    let l:matchlist = matchlist(l:rest, l:paramPat, 0)
  endwhile

  let l:comment = [l:prefix . '/**', l:prefix . ' * '] + l:vars + [l:prefix . ' */']
  call append(l:line - 1, l:comment)
  call cursor(l:line + 1, l:indent + 3)
  startinsert!
endfunction

" markdown new line
function! MarkdownIndent()
  let l:list_char = s:GetMarkdownListChar()
  let l:indent_str = repeat(' ', shiftwidth())
  return s:MarkdownNewLine(l:list_char, l:indent_str, l:indent_str)
endfunction

" markdown new list item
function! MarkdownNewList()
  let l:list_char = s:GetMarkdownListChar()
  return s:MarkdownNewLine(l:list_char, '', l:list_char . ' ')
endfunction

" markdown new line
function! s:MarkdownNewLine(list_char, suffix, prefix)
  let l:return_str = "\n"
  
  if a:list_char =~ '\v[+*-]'
    let return_str = a:suffix . l:return_str . a:prefix
  endif

  return l:return_str
endfunction

" get markdown list char
function! s:GetMarkdownListChar()
  let l:now_line = substitute(getline('.'), '^\s*\(.\{-}\)\s*$', '\1', '')
  return l:now_line[0]
endfunction

" load my colorscheme
function! LoadMyColorshcheme()
  syntax on
  set background=dark
  if neobundle#is_sourced('vim-hybrid')
    colorscheme hybrid
  endif
  highlight LineNr ctermfg=245

  if s:is_windows
    highlight LineNr guifg=gray50
  endif
endfunction
" }}}

" my commands and keymap {{{
command! GenDocJs :call s:GenDocJs()

augroup MyAutoCmd
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype visualforce inoremap <buffer> </ </<C-x><C-o>
augroup END
" }}}

" NeoBundle {{{
if 0 | endif
 
if &compatible
  set nocompatible
endif

set runtimepath^=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'Shougo/vimproc.vim', {
      \ 'build' : {
      \     'windows' : 'tools\\update-dll-mingw',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make',
      \     'linux' : 'make -f make_unix.mak',
      \     'unix' : 'gmake',
      \    },
      \ }
NeoBundle 'Shougo/vimshell.vim'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'cohama/agit.vim'
NeoBundle 'kana/vim-smartinput'
NeoBundle 'cohama/lexima.vim'
NeoBundleLazy 'marijnh/tern_for_vim', {
      \ 'build': {'others': 'npm install'},
      \ 'on_ft': [ 'javascript' ],
      \ }
NeoBundle 'scrooloose/syntastic', {
      \ 'build': {'others': 'npm install -g jshint'}
      \ }
NeoBundle 'tomtom/tcomment_vim'
NeoBundleLazy 'neowit/vim-force.com', {
      \ 'on_ft': [ 'apexcode', 'visualforce' ],
      \ 'on_cmd' : 'ApexInitProject'
      \}
NeoBundleLazy 'osyo-manga/vim-monster', {
      \ 'build': {'others': 'gem install rcodetools'},
      \ 'on_ft': [ 'ruby' ]
      \}
NeoBundleLazy 'othree/javascript-libraries-syntax.vim', {
      \ 'on_ft': [ 'javascript' ]
      \ }
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'Konfekt/FastFold'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'ervandew/eclim'
NeoBundleLazy 'davidhalter/jedi-vim', {
      \ 'build': {'others': 'git submodule update --init'},
      \ 'on_ft': [ 'python' ]
      \ }
NeoBundle 'hynek/vim-python-pep8-indent'

call neobundle#end()
filetype plugin indent on
NeoBundleCheck
" }}}

" color schema {{{
if !has('gui_running')
  call LoadMyColorshcheme()
endif
" }}}

" unite.vim setting {{{
call unite#custom#default_action("source/bookmark/directory", "cd")

nnoremap [unite] <Nop>
nmap <Space>u [unite]
nnoremap [unite]<Space>  :<C-u>Unite<Space>
nnoremap <silent> [unite]b   :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]f   :<C-u>Unite file<CR>
nnoremap <silent> [unite]m   :<C-u>Unite bookmark<CR>
" }}}

" VimFiler, VimShell {{{
nnoremap [vimfiler] <Nop>
nmap <Space>f [vimfiler]
nnoremap [vimfiler]<Space> :<C-u>VimFiler<CR>
nnoremap [vimfiler]e :<C-u>VimFilerExplorer<CR>

nnoremap [vimshell] <Nop>
nmap <Space>s [vimshell]
nnoremap [vimshell]<Space> :<C-u>VimShell<CR>
nnoremap [vimshell]s :<C-u>VimShellSendString<Space>
nnoremap [vimshell]n :<C-u>new<CR><ESC>:VimShell<CR><ESC><C-w>j
nnoremap [vimshell]v :<C-u>vnew<CR><ESC>:VimShell<CR><ESC><C-w>l
" }}}

" git setting {{{
nnoremap [git] <Nop>
nmap <Space>g [git]
nnoremap [git]s :<C-u>Gstatus<CR>7j
nnoremap [git]c :<C-u>Gcommit<CR>i
nnoremap [git]ps :<C-u>Gpush<Space>

nnoremap [git]v :<C-u>Agit<CR>
nnoremap [git]l :<C-u>!git log -20 --no-merges --date=short --pretty='format:\%C(yellow)\%h \%C(green)\%cd \%C(blue)\%an\%C(red)\%d \%C(reset)\%s'<CR>
" }}}

" tab {{{
nnoremap [tab] <Nop>
nmap t [tab]
nnoremap [tab]t :<C-u>tabnew<CR>
nnoremap [tab]e :<C-u>tabnew<Space>%<CR>
nnoremap [tab]n :<C-u>tabnext<CR>
nnoremap [tab]p :<C-u>tabprevious<CR>
nnoremap [tab]c :<C-u>tabclose<CR>
" }}}

" NeoComplete {{{
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3

let g:neocomplete#enable_auto_close_preview = 1

if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.java =
    \ '\%(\h\w*\|)\)\.\w*'
let g:neocomplete#force_omni_input_patterns.groovy =
    \ '\%(\h\w*\|)\)\.\w*'
let g:neocomplete#force_omni_input_patterns.apexcode =
    \ '\%(\h\w*\|)\)\.\w*'
let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'
" }}}

" Neo snippet {{{
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

let g:neosnippet#snippets_directory=[]
" }}}

" syntastic {{{
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_wq = 0
"}}}

" vim-force.com setting {{{
if neobundle#tap('vim-force.com')
  function! neobundle#tapped.hooks.on_source(bundle)
    let l:base_dir = expand('~/.vim-force/')
    let l:properties_dir = l:base_dir . 'properties'
    let l:temp_dir = l:base_dir . 'temp'
    let l:backup_dir = l:base_dir . 'backup'
  
    let l:jar_name = 'tooling-force.com-0.3.6.0.jar'
    let l:jar_url = 'https://github.com/neowit/tooling-force.com/releases/download/v0.3.6.0/' . l:jar_name
  
    call s:Mkdir(l:base_dir)
    call s:Mkdir(l:properties_dir)
    call s:Mkdir(l:temp_dir)
    call s:Mkdir(l:backup_dir)

    if !filereadable(l:base_dir . '/' . l:jar_name)
      echo 'getting ' . l:jar_name . '...'
      call system('wget ' . l:jar_url . ' && mv ' . l:jar_name . ' ' . l:base_dir . '/')
    endif
  
    let g:apex_backup_folder = l:properties_dir
    let g:apex_temp_folder = l:temp_dir
    let g:apex_properties_folder = l:backup_dir
    let g:apex_tooling_force_dot_com_path = l:base_dir . '/' . l:jar_name
  
    let g:apex_API_version="36.0"
    let g:apex_server=1
    let g:apex_server_timeoutSec=60*30
  
    if !empty($http_proxy)
      let s:proxy_info = split($http_proxy, ':')
      let g:apex_tooling_force_dot_com_extra_params="--http.proxyHost=" . s:proxy_info[1][2:-1] . " --http.proxyPort=" . s:proxy_info[2]
    endif
    call add(g:neosnippet#snippets_directory, neobundle#get('vim-force.com').installed_path . '/snippets')

    if s:is_windows
      let g:apex_binary_tee = "C:\\Program Files\\Git\\usr\\bin\\tee.exe"
      let g:apex_binary_touch = "C:\\Program Files\\Git\\usr\\bin\\touch.exe"
    endif
  endfunction

  call neobundle#untap()
endif
" filetypes related sfdc are owned in vim-force plugin
if neobundle#is_installed('vim-force.com')
  let s:vim_force_installed_path = neobundle#get('vim-force.com').installed_path . '/ftdetect/vim-force.com.vim'
  execute 'source ' . s:vim_force_installed_path
endif
" }}}

" vim-monster setting {{{
let g:monster#completion#rcodetools#backend = "async_rct_complete"
let g:neocomplete#sources#omni#input_patterns = {
      \ 'ruby': '[^. *\t]\.\w*\|\h\w*::'
      \}
" }}}

" javascript-libraries-syntax setting {{{
let g:used_javascript_libs = 'jasmine'
" }}}

" Markdown setting {{{
let g:vim_markdown_conceal = 0
let g:vim_markdown_new_list_item_indent = 0

augroup MyAutoCmd
  autocmd Filetype markdown inoremap <expr> <silent> <S-CR> MarkdownIndent()
  autocmd Filetype markdown inoremap <expr> <silent> <C-CR> MarkdownNewList()
augroup END
" その内、Ctrl-Enterとかで、新しいリスト、とかもやりたい > リスト内でインデン
" トしてる時が微妙
" }}}

" eclim setting {{{
let g:EclimCompletionMethod = "omnifunc"
" }}}

" jedi-vim setting {{{
augroup MyAutoCmd
  autocmd FileType python setlocal omnifunc=jedi#completions
  autocmd FileType python setlocal completeopt-=preview
augroup END

let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
" }}}


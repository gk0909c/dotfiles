

" filetype setting {{{
augroup MyAutoCmd
  autocmd!
  autocmd BufNewFile,BufRead *.gradle set filetype=groovy
  autocmd BufNewFile,BufRead *.js.erb set filetype=javascript
augroup END
" }}}

" backup setting (don't create) {{{
set nowritebackup
set nobackup
set noswapfile
set backupdir-=.
set noundofile
" }}}

" display setting {{{
set number
set ruler
set laststatus=2 
set cmdheight=2
nnoremap <F3> :<C-u>setlocal relativenumber!<CR>
vnoremap <F3> :<C-u>setlocal relativenumber!<CR>
set foldmethod=marker
set cursorline
set backspace=indent,eol,start
set hlsearch
nnoremap <ESC><ESC> :<C-u>nohlsearch<CR>

augroup MyAutoCmd
  autocmd FileType json setlocal conceallevel=0
augroup END
" }}}

" cursor {{{
set whichwrap=b,s,h,l
" }}}

" indent {{{
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

set smartindent
set autoindent

augroup MyAutoCmd
  autocmd FileType java setlocal shiftwidth=4 tabstop=4 softtabstop=4
  autocmd FileType groovy setlocal shiftwidth=4 tabstop=4 softtabstop=4
  autocmd FileType apexcode setlocal shiftwidth=4 tabstop=4 softtabstop=4
  autocmd FileType php setlocal shiftwidth=4 tabstop=4 softtabstop=4
augroup END
" }}}

" comment setting {{{
augroup MyAutoCmd
  autocmd BufEnter *
        \ setlocal formatoptions-=r |
        \ setlocal formatoptions-=o

  autocmd BufEnter *.java,*.groovy,*.gradle,*.js,*.ts,*.php
        \ setlocal formatoptions+=r |
        \ setlocal formatoptions+=o |
        \ setlocal comments=s1:/*,mb:*,ex:*/
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
" is windows
function! IsWindows()
  return s:is_windows
endfunction

" make directory
function! s:Mkdir(dir)
  if !isdirectory(a:dir)
    call mkdir(a:dir, 'p')
  endif
endfunction

" Disp PATH env list
function! s:DispPathList() abort
  let previewfile = tempname()
  let splitter = IsWindows() ? ';' : ':'
  let path_list = split($PATH, splitter)
  call writefile(path_list, previewfile)

  execute ":pedit " . previewfile
endfunction

" generate javascript method comment 
function! s:GenDocJs()
  let l:line = line('.')
  let l:indent = indent(l:line)
  let l:prefix = repeat(' ', l:indent)
  let l:text = getline(l:line)
  let l:params = matchstr(l:text, '([^)]*)')
  let l:paramPat = '\([$a-zA-Z_0-9]\+\)[, ]*\(.*\)'

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

" load my colorscheme
function! LoadMyColorshcheme()
  syntax on
  set background=dark
  if dein#is_sourced('vim-hybrid')
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
command! DispPathList :call s:DispPathList()

augroup MyAutoCmd
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype visualforce inoremap <buffer> </ </<C-x><C-o>
augroup END

" yank text objects
nnoremap yw viwy
nnoremap y" vi"y
nnoremap y' vi'y
nnoremap y( vi(y
nnoremap yt vity
" }}}

"dein settings {{{
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('~/.vim/dein')

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

call dein#load_toml("~/.vim/plugins.toml", {'lazy': 0}) 
call dein#load_toml("~/.vim/plugins_lazy.toml", {'lazy': 1}) 

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
" if dein#check_install()
"  call dein#install()
"endif
" }}}

" color schema {{{
if !has('gui_running')
  call LoadMyColorshcheme()
endif
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=darkgrey
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=lightgrey
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1
" }}}

" unite.vim setting {{{
let g:vimfiler_as_default_explorer = 1
call unite#custom#default_action("source/bookmark/directory", "cd")

nnoremap [unite] <Nop>
nmap <Space>u [unite]
nnoremap [unite]<Space>  :<C-u>Unite<Space>
nnoremap <silent> [unite]b   :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]f   :<C-u>Unite file<CR>
nnoremap <silent> [unite]r   :<C-u>Unite file_rec/git<CR>
nnoremap <silent> [unite]g   :<C-u>Unite grep/git<CR>
nnoremap <silent> [unite]a   :<C-u>Unite file_rec/async<CR>
nnoremap <silent> [unite]m   :<C-u>Unite bookmark<CR>
nnoremap <silent> [unite]o   :<C-u>Unite outline<CR>
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
nnoremap [git]r :<C-u>!git rebase -i 
" }}}

" tab {{{
nnoremap [tab] <Nop>
nmap t [tab]
nnoremap [tab]t :<C-u>tabnew<CR>
nnoremap [tab]e :<C-u>tabnew<Space>%<CR>
nnoremap [tab]n :<C-u>tabnext<CR>
nnoremap [tab]p :<C-u>tabprevious<CR>
nnoremap [tab]c :<C-u>tabclose<CR>
nnoremap [tab]f :<C-u>tabfirst<CR>
nnoremap [tab]l :<C-u>tablast<CR>

function! s:Tabonly()
  let choice = confirm('close all tab?(except selecting tab)', "y yes\nn no")
  if choice == 1
    execute ':tabonly'
  endif
endfunction
nnoremap [tab]o :<C-u>call <SID>Tabonly()<CR>
" }}}

" edit etc {{{
nnoremap [edit] <Nop>
nmap e [edit]
nnoremap <expr> [edit]e ':<C-u>e ' . expand("%:h") . '/'
nnoremap <expr> [edit]n ':<C-u>new ' . expand("%:h") . '/'
nnoremap <expr> [edit]vn ':<C-u>vnew ' . expand("%:h") . '/'

" }}}

" quick fix setting {{{
nnoremap [quickfix] <Nop>
nmap <Space>q [quickfix]
nnoremap <expr> [quickfix]p ':cprevious<CR>'
nnoremap <expr> [quickfix]n ':cnext<CR>'

" }}}

" npm setting {{{
  command! -nargs=1 NpmInstallSave :execute '!npm install --save ' . "<args>"
  command! -nargs=1 NpmInstallSaveDev :execute '!npm install --save-dev ' . "<args>"

" }}}

" Angular2 setting (via angular-cli) {{{
if executable('ng')
  function! CompletionNgGenerate(ArgLead, CmdLine, CursorPos)
    let cmd = split(a:CmdLine)
    let len_cmd = len(l:cmd)

    if (len_cmd == 1 && a:ArgLead == '') || (len_cmd == 2 && a:ArgLead != '')
      let filter_cmd = printf('v:val =~ "^%s"', a:ArgLead)
      return filter(['component', 'directive', 'pipe', 'service', 'class', 'interface', 'enum', 'module'], filter_cmd)
    else
      return []
    endif
  endfunction
  command! -nargs=+ -complete=customlist,CompletionNgGenerate NgGenerate :execute '!ng g ' . "<args>"
endif

function! s:GetFilePathForNg()
  return join(split(expand("%:r"), '\.')[0:1], '.')
endfunction

command! NgOpenController :execute 'new ' . s:GetFilePathForNg() . '.ts'
command! NgVOpenController :execute 'vnew ' . s:GetFilePathForNg() . '.ts'
command! NgOpenView :execute 'new ' . s:GetFilePathForNg() . '.html'
command! NgVOpenView :execute 'vnew ' . s:GetFilePathForNg() . '.html'
command! NgOpenStyle :execute 'new ' . s:etFilePathForNg() . '.scss'
command! NgVOpenStyle :execute 'vnew ' . s:GetFilePathForNg() . '.scss'
command! NgOpenTest :execute 'new ' . s:GetFilePathForNg() . '.spec.ts'
command! NgVOpenTest :execute 'vnew ' . s:GetFilePathForNg() . '.spec.ts'

nnoremap [angluar-cli] <Nop>
nmap <Space>a [angular-cli]

nnoremap [angular-cli]c :<C-u>NgVOpenController<CR>
nnoremap [angular-cli]v :<C-u>NgVOpenView<CR>
nnoremap [angular-cli]s :<C-u>NgVOpenStyle<CR>
nnoremap [angular-cli]t :<C-u>NgVOpenTest<CR>
" }}}

" NeoComplete {{{
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3

let g:neocomplete#enable_auto_close_preview = 1

" dictionary
let s:dict_dir = '~/.vim/dict/'
let s:typescript_dictionaries = [
      \ s:dict_dir . 'typescript.dict',
      \ s:dict_dir . 'typescript.angular.dict'
      \ ]
let g:neocomplete#sources#dictionary#dictionaries = {
      \ '_': s:dict_dir . 'common.dict',
      \ 'html': s:dict_dir . 'bootstrap.dict',
      \ 'java': s:dict_dir . 'java.dict',
      \ 'php': s:dict_dir . 'php.dict',
      \ 'typescript': join(s:typescript_dictionaries, ',')
      \ }

let s:keyword_patterns = {}
let s:keyword_patterns.typescript = '\h\w*\%(-\w*\)*'
let s:keyword_patterns.html = '\h\w*\%(-\w*\)*'
call neocomplete#custom#source('dictionary', 'keyword_patterns', s:keyword_patterns)

" omni func
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.java = '\%(\h\w*\|)\)\.\w*'
let g:neocomplete#force_omni_input_patterns.groovy = '\%(\h\w*\|)\)\.\w*'
let g:neocomplete#force_omni_input_patterns.apexcode = '\%(\h\w*\|)\)\.\w*'
let g:neocomplete#force_omni_input_patterns.typescript = '\%(\h\w*\|)\)\.\w*'
let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'
" let g:neocomplete#force_omni_input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
" let g:neocomplete#force_omni_input_patterns.r = '[[:alnum:].\\]\+'

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

let g:neosnippet#snippets_directory=['~/.vim/snippets']
" }}}

" syntastic {{{
let g:syntastic_javascript_checkers = ['eslint']
let g:tsuquyomi_disable_quickfix = 1
let g:syntastic_typescript_checkers = ['tslint', 'tsuquyomi']
let g:syntastic_scss_checkers = ['sass_lint']
let g:syntastic_php_checkers = ["php", "phpcs", "phpmd"]
let g:syntastic_ruby_checkers = ["rubocop"]

let g:syntastic_php_phpmd_post_args = 'cleancode,codesize,controversial,design,naming,unusedcode'
" let g:syntastic_html_tidy_quiet_messages = {
"       \ 'regex': 'my-app'
"       \ }
" let g:syntastic_html_tidy_ignore_errors = [
"      \ '<meta> proprietary attribute',
"      \ 'proprietary attribute "ng-',
"      \ ]
let g:syntastic_html_checkers = []
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_filetype_map = { "aura-javascript": "javascript" } 
"}}}

" easy-align setting {{{
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
" }}}

" vim-force.com setting {{{
if dein#tap('vim-force.com')
  function! s:init_vim_force()
    let l:base_dir = expand('~/.vim-force/')
    let l:properties_dir = l:base_dir . 'properties'
    let l:temp_dir = l:base_dir . 'temp'
    let l:backup_dir = l:base_dir . 'backup'
  
    let l:jar_name = 'tooling-force.com-0.3.6.6.jar'
    let l:jar_url = 'https://github.com/neowit/tooling-force.com/releases/download/v0.3.6.6/' . l:jar_name
  
    call s:Mkdir(l:base_dir)
    call s:Mkdir(l:properties_dir)
    call s:Mkdir(l:temp_dir)
    call s:Mkdir(l:backup_dir)

    if !filereadable(l:base_dir . '/' . l:jar_name)
      echo 'getting ' . l:jar_name . '...'
      call system('wget ' . l:jar_url . ' && mv ' . l:jar_name . ' ' . l:base_dir . '/')
    endif
  
    let g:apex_backup_folder = l:backup_dir
    let g:apex_temp_folder = l:temp_dir
    let g:apex_properties_folder = l:properties_dir
    let g:apex_tooling_force_dot_com_path = l:base_dir . '/' . l:jar_name
  
    let g:apex_API_version="38.0"
    let g:apex_server=1
    let g:apex_server_timeoutSec=60*30
  
    if !empty($http_proxy)
      let s:proxy_info = split($http_proxy, ':')
      let g:apex_tooling_force_dot_com_extra_params="--http.proxyHost=" . s:proxy_info[1][2:-1] . " --http.proxyPort=" . s:proxy_info[2]
    endif
    call add(g:neosnippet#snippets_directory, dein#get('vim-force.com').path . '/snippets')

    if s:is_windows
      let g:apex_binary_tee = "C:\\Program Files\\Git\\usr\\bin\\tee.exe"
      let g:apex_binary_touch = "C:\\Program Files\\Git\\usr\\bin\\touch.exe"
    endif
  endfunction

  call dein#set_hook('vim-force.com', 'hook_source', function('s:init_vim_force'))
endif
" filetypes related sfdc are owned in vim-force plugin
if dein#check_install(['vim-force.com']) == 0
  let s:vim_force_installed_path = dein#get('vim-force.com').path . '/ftdetect/vim-force.com.vim'
  execute 'source ' . s:vim_force_installed_path
endif
" }}}

" vim-monster setting {{{
" let g:monster#completion#rcodetools#backend = "async_rct_complete"
" let g:neocomplete#force_omni_input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
" let g:neocomplete#sources#omni#input_patterns = {
"       \ 'ruby': '[^. *\t]\.\w*\|\h\w*::'
"       \}
" }}}
" rubycomplete setting {{{
" let g:rubycomplete_buffer_loading = 1
" let g:rubycomplete_rails = 1
" let g:rubycomplete_classes_in_global = 1
" }}}

" javascript-libraries-syntax setting {{{
let g:used_javascript_libs = 'jasmine'
" }}}

" Markdown setting {{{
let g:vim_markdown_conceal = 0
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_folding_level = 3

augroup MyAutoCmd
  autocmd Filetype markdown imap <buffer> <C-o> <Plug>(mdnl_linebreak)
  autocmd Filetype markdown imap <buffer> <C-i> <Plug>(mdnl_split_as_paragraph)
  autocmd Filetype markdown nmap <buffer> <C-i> <Plug>(mdnl_split_as_paragraph)
  autocmd Filetype markdown imap <buffer> <C-l> <Plug>(mdnl_new_listitem)
  autocmd Filetype markdown imap <buffer> <C-j> <Plug>(mdnl_split_as_list)
  autocmd Filetype markdown nmap <buffer> <C-j> <Plug>(mdnl_split_as_list)
augroup END

call lexima#add_rule({
      \ 'filetype': ['markdown'],
      \ 'at': '^\s*\%(\%([+*-]\)\|\%([0-9]\+\.\)\)\s\%#',
      \ 'char': '[', 'input': '[<space>]<space>' })
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

" Nvim-R setting {{{
" use tmux2.0, need tmux.config(see Nvim-R doc)
" 1. exec tmax, 2. exec vim, 3. start R (\rf)
" if in nvim, tmux is no need.(use nvim term)
let g:R_in_buffer = 0
let g:R_applescript = 0
let g:R_tmux_split = 1
" let R_vsplit = 1
augroup MyAutoCmd
  " need to consider these mappings...
  " autocmd FileType r inoremap <C-z> <C-x><C-o>
  " autocmd FileType r inoremap <C-b> <C-x><C-a>
augroup END
" }}}

" tcomment {{{
if !exists('g:tcomment_types')
	let g:tcomment_types = {}
endif
let g:tcomment_types['apexcode'] = '// %s'
let g:tcomment_types['visualforce'] = '<!-- %s -->'
let g:tcomment_types['aura-xml'] = '<!-- %s -->'

" }}}

" others {{{
let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config._ = {
      \ 'runner' : 'vimproc',
      \ 'runner/vimproc/updatetime' : 60
      \ }
let g:quickrun_config.java = {
      \ 'exec' : ['javac -J-Dfile.encoding=UTF8 %o %s', '%c -Dfile.encoding=UTF8 %s:t:r %a']
      \ }

let g:zenspace#default_mode = 'on'

call lexima#add_rule({
      \ 'filetype': ['vimspec'],
      \ 'at': '^\s*\%([dD]escribe\|[cC]ontext\|[iI]t\).*\%#',
      \ 'char': '<CR>', 'input': '<CR>' ,'input_after': '<CR>End'})

call lexima#add_rule({
      \ 'filetype': ['php'],
      \ 'at': '^\s*<?php\%#',
      \ 'char': '<CR>', 'input': '<CR>' ,'input_after': '<CR>?>'})

augroup MyAutoCmd
  autocmd BufRead,BufNewFile /etc/nginx/* set ft=nginx
  autocmd BufWritePre *.ts,*.js,*.java,*.rb,*.py,*.php :%s/\s\+$//ge
augroup END

let g:previm_custom_css_path = expand('~/.vim/vimpreview.css')
" }}}

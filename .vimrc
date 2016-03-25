" basic
set number
set title
set backspace=indent,eol,start
set noswapfile
set nobackup
set noundofile
set ambiwidth=double

" cursor setting
set cursorline
hi clear CursorLine
hi CursorLineNr term=bold cterm=NONE ctermfg=228 ctermbg=NONE
autocmd ColorScheme * highlight LineNr ctermfg=170

" command menu
set wildmenu
set wildmode=longest:full,full

" basic tab setting
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" indent setting
set smartindent
set autoindent
augroup auto_comment_off
  autocmd!
  autocmd BufEnter * setlocal formatoptions-=r
  autocmd BufEnter * setlocal formatoptions-=o
augroup END

" encofing & fileformats
set encoding=utf-8
set fileencodings=utf-8,cp932,sjis,euc-jp,iso-2022-jp
set fileformat=unix
set fileformats=unix,dos,mac

" paste controll
augroup paste-setting
  autocmd!
  autocmd InsertLeave * set nopaste
augroup END
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" auto make directory
augroup vimrc-auto-mkdir
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
  function! s:auto_mkdir(dir, force)
    if !isdirectory(a:dir) && (a:force ||
    \    input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction
augroup END

" confirm fileformat to unix
function! s:set_fileformat()
  if &filetype != "dosbatch" && &fileformat != "unix" && input("setlocal fileformat=unix?[y/n]") == "y"
    try
      setlocal fileformat=unix
    catch
    endtry
  endif
endfunction
autocmd BufWritePre * :call <SID>set_fileformat()

" disp blank characters
set list
set listchars=tab:>.,trail:_,eol:↲,extends:>,precedes:<,nbsp:%

function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction
if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme       * call ZenkakuSpace()
        autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    augroup END
    call ZenkakuSpace()
endif

" tab setting
if filereadable(expand('~/.vimrc_tab'))
  source ~/.vimrc_tab
endif

" NeoBundle
if 0 | endif
 
if &compatible
  set nocompatible
endif

set runtimepath^=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'cohama/lexima.vim'
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'tpope/vim-fugitive'

call neobundle#end()
filetype plugin indent on
NeoBundleCheck

" color schema
syntax on
set background=dark
if isdirectory(expand('~/.vim/bundle/vim-hybrid'))
  colorscheme hybrid
endif

" NeoComplete
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
endfunction

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.javascript = '[^. \t]\.\%(\h\w*\)\?'

" NeoSnippet
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

let g:neosnippet#snippets_directory='~/.vim/my_snippet'

" NerdTree
noremap <C-N><C-T> :NERDTreeToggle<CR>

" Unite
noremap <C-U><C-B> :Unite buffer<CR>

" Markdown setting
let g:vim_markdown_folding_disabled=1

augroup Markdown
  autocmd!
  autocmd Filetype markdown inoremap <S-CR> <SPACE><SPACE><CR>
augroup END



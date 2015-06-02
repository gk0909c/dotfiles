" エディタ設定   ====================
set nocompatible
set columns=200
set lines=60

set encoding=utf-8
set fileencodings=utf-8,cp932,sjis,euc-jp,iso-2022-jp
set fileformat=unix
set fileformats=unix,dos,mac
set number
set title
set ambiwidth=double
set tabstop=2 " タブ幅
set shiftwidth=2 " タブの移動幅
set expandtab " タブの代わりに空白
set smartindent " 改行時に行の末尾に合わせて次の行をインデント
set nrformats-=octal " 0で始まる数値を、8進数として扱わないようにする
set hidden "ファイルの保存をしていなくても、べつのファイルを開けるようにする
"set whichwrap=b,s,[,],<,> "カーソルの回り込みができるようになる（行末で→を押すと、次の行へ）なんか効かないし止め。
set backspace=indent,eol,start "バックスペースを、空白、行末、行頭でも使えるようにする
set nowildmenu
set wildmode=longest
set noswapfile
set nobackup
set noundofile

" NeoBundle設定   ====================
" vim起動時のみruntimepathにneobundle.vimを追加
if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif

" neobundle.vimの初期化 
" NeoBundleを更新するための設定
call neobundle#begin(expand('~/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'

" 読み込むプラグインを記載
NeoBundle 'tomasr/molokai'								" カラースキーム
NeoBundle 'sjl/badwolf'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'chriskempson/vim-tomorrow-theme'
NeoBundle 'Shougo/unite.vim'							" ファイル等へのアクセス
NeoBundle 'scrooloose/nerdtree'							" ファイルのツリー表示
NeoBundle 'tpope/vim-surround'							" 囲われたテキストの処理（タグや引用符）
NeoBundle 'mattn/emmet-vim'								" HTMLのタグ構造を簡単に作れる
NeoBundle 'hail2u/vim-css3-syntax'						" html5のコードをシンタックス表示する
NeoBundle 'scrooloose/syntastic.git'					" ファイルの構文エラーをチェック（動作確認はとれていない。。。）
NeoBundle 'Shougo/neocomplete.vim'						" 補完
NeoBundle 'Shougo/neosnippet'							" スニペット
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'jiangmiao/simple-javascript-indenter'		" JavaScriptのインデント
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-endwise'

call neobundle#end()

" インストールのチェック
NeoBundleCheck

" タグ閉じの自動補完（今のところ効いてない。。。）
augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype eruby inoremap <buffer> </ </<C-x><C-o>
augroup END

" カラースキーム
syntax on
colorscheme badwolf

"emmetの設定
let g:user_emmet_settings = {'indentation' : '  '}

" カーソル行
set cursorline
hi clear CursorLine
hi CursorLineNr term=bold   cterm=NONE ctermfg=228 ctermbg=NONE

" キーバインド
noremap <C-U><C-B> :Unite buffer<CR>
"noremap <C-U><C-F> :Unite file<CR> "NERDTreeがあればいらない？
noremap <C-N><C-T> :NERDTreeToggle<CR>

" タブ(tc, tx, tn, tp, tn(n=1,2,3,,,,))
if filereadable(expand('~/.vimrc_tab'))
  source ~/.vimrc_tab
endif

" neocomplete
let g:neocomplete#enable_at_startup = 1
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags

" neosnippet
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

"let g:neosnippet#enable_snipmate_compatibility = 1
"let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

"my snippet
let g:neosnippet#snippets_directory='~/.snippet'

" confirm fileformat to unix
function! s:set_fileformat()
        if &fileformat != "unix" && input("setlocal fileformat=unix?[y/n]") == "y"
                try
                        setlocal fileformat=unix
                catch
                endtry
        endif
endfunction
autocmd BufWritePre * :call <SID>set_fileformat()

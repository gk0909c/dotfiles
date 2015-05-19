" エディタ設定   ====================
set nocompatible
set columns=200
set lines=60

"set encoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
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
call neobundle#end()

" 読み込むプラグインを記載
NeoBundle 'tomasr/molokai'				" カラースキーム
NeoBundle 'sjl/badwolf'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'chriskempson/vim-tomorrow-theme'
NeoBundle 'Shougo/unite.vim'			" ファイル等へのアクセス
NeoBundle 'scrooloose/nerdtree'			" ファイルのツリー表示
NeoBundle 'tpope/vim-surround'			" 囲われたテキストの処理（タグや引用符）
NeoBundle 'mattn/emmet-vim'				" HTMLのタグ構造を簡単に作れる
NeoBundle 'hail2u/vim-css3-syntax'		" html5のコードをシンタックス表示する
NeoBundle 'scrooloose/syntastic.git'	" ファイルの構文エラーをチェック（動作確認はとれていない。。。）
NeoBundle 'Shougo/neocomplete.vim'		" 補完


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
colorscheme Tomorrow-Night

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

" あとは
" スニペット系

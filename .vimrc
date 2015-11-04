" �G�f�B�^�ݒ�   ====================
set nocompatible
set columns=200
set lines=60

"set encoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set number
set title
set ambiwidth=double
set tabstop=2 " �^�u��
set shiftwidth=2 " �^�u�̈ړ���
set expandtab " �^�u�̑���ɋ�
set smartindent " ���s���ɍs�̖����ɍ��킹�Ď��̍s���C���f���g
set nrformats-=octal " 0�Ŏn�܂鐔�l���A8�i���Ƃ��Ĉ���Ȃ��悤�ɂ���
set hidden "�t�@�C���̕ۑ������Ă��Ȃ��Ă��A�ׂ̃t�@�C�����J����悤�ɂ���
"set whichwrap=b,s,[,],<,> "�J�[�\���̉�荞�݂��ł���悤�ɂȂ�i�s���Ł��������ƁA���̍s�ցj�Ȃ񂩌����Ȃ����~�߁B
set backspace=indent,eol,start "�o�b�N�X�y�[�X���A�󔒁A�s���A�s���ł��g����悤�ɂ���
set nowildmenu
set wildmode=longest

" NeoBundle�ݒ�   ====================
" vim�N�����̂�runtimepath��neobundle.vim��ǉ�
if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif

" neobundle.vim�̏����� 
" NeoBundle���X�V���邽�߂̐ݒ�
call neobundle#begin(expand('~/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'
call neobundle#end()

" �ǂݍ��ރv���O�C�����L��
NeoBundle 'tomasr/molokai'				" �J���[�X�L�[��
NeoBundle 'sjl/badwolf'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'chriskempson/vim-tomorrow-theme'
NeoBundle 'Shougo/unite.vim'			" �t�@�C�����ւ̃A�N�Z�X
NeoBundle 'scrooloose/nerdtree'			" �t�@�C���̃c���[�\��
NeoBundle 'tpope/vim-surround'			" �͂�ꂽ�e�L�X�g�̏����i�^�O����p���j
NeoBundle 'mattn/emmet-vim'				" HTML�̃^�O�\�����ȒP�ɍ���
NeoBundle 'hail2u/vim-css3-syntax'		" html5�̃R�[�h���V���^�b�N�X�\������
NeoBundle 'scrooloose/syntastic.git'	" �t�@�C���̍\���G���[���`�F�b�N�i����m�F�͂Ƃ�Ă��Ȃ��B�B�B�j
NeoBundle 'Shougo/neocomplete.vim'		" �⊮


" �C���X�g�[���̃`�F�b�N
NeoBundleCheck

" �^�O���̎����⊮�i���̂Ƃ�������ĂȂ��B�B�B�j
augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
  autocmd Filetype eruby inoremap <buffer> </ </<C-x><C-o>
augroup END

" �J���[�X�L�[��
syntax on
colorscheme Tomorrow-Night

"emmet�̐ݒ�
let g:user_emmet_settings = {'indentation' : '  '}

" �J�[�\���s
set cursorline
hi clear CursorLine
hi CursorLineNr term=bold   cterm=NONE ctermfg=228 ctermbg=NONE

" �L�[�o�C���h
noremap <C-U><C-B> :Unite buffer<CR>
"noremap <C-U><C-F> :Unite file<CR> "NERDTree������΂���Ȃ��H
noremap <C-N><C-T> :NERDTreeToggle<CR>

" �^�u(tc, tx, tn, tp, tn(n=1,2,3,,,,))
if filereadable(expand('~/.vimrc_tab'))
  source ~/.vimrc_tab
endif

" neocomplete
let g:neocomplete#enable_at_startup = 1

" ���Ƃ�
" �X�j�y�b�g�n

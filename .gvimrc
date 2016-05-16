set guifont=MigMix_1M:h9
set guifontwide=MigMix_1M:h9

set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L

augroup MyAutoCmd
  autocmd GUIEnter * simalt ~x
augroup END

call LoadMyColorshcheme()

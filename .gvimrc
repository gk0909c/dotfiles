set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L

if IsWindows()
  set guifont=MigMix_1M:h9
  set guifontwide=MigMix_1M:h9

  augroup MyAutoCmd
    autocmd GUIEnter * simalt ~x
  augroup END
elseif has("mac")
  set imdisable

  set columns=220
  set lines=65
endif

call LoadMyColorshcheme()

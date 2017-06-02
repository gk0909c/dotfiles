setlocal iskeyword+=-

" define pattern
syntax keyword ps1Conditional if else elseif switch default
syntax keyword ps1Repeat while for do until break continue foreach in
syntax keyword ps1Operator -eq -ne -ge -gt -lt -le -like -notlike -match -notmatch -replace -split -contains -notcontains

syntax match ps1Comment '^\s*#.\+'

syntax match ps1Variable /\$\w\+\(:\w\+\)\?/
syntax match ps1Variable /\${\w\+\(:\w\+\)\?}/

syntax region ps1String start=/"/ skip=/`"/ end=/"/

" hightlight setting
highlight link ps1Conditional Conditional
highlight link ps1Repeat Repeat
highlight link ps1Operator Operator
highlight link ps1Comment Comment
highlight link ps1Variable Identifier
highlight link ps1String String

let b:current_syntax = "ps1"

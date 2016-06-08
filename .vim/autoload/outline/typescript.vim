function! outline#typescript#outline_info() abort
  return s:outline_info
endfunction

let s:pat_class = '\%(\s*export\%(\s\+default\)\=\s\+class\)'
let s:pat_method = '\%(\s\+\%(\%(public\|private\)\s\+\)\=\l\w\+\s*(\%(\w\|:\|\s\)*)\.*\)'

let s:outline_info = {
      \ 'heading': '^\%(' . s:pat_class . '\|' . s:pat_method . '\)'
      \ }

function! s:outline_info.create_heading(which, heading_line, matched_line, context) abort
  let word = a:heading_line
  let level = (indent(a:context.heading_lnum) / shiftwidth()) + 1
  
  if a:heading_line =~ '^' . s:pat_method
    let word = '|------' . word
  endif

  let heading = {
        \   'word' : word,
        \   'level': level,
        \   'type' : 'generic',
        \ }

  return heading
endfunction

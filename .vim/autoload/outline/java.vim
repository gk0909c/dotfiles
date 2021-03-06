function! outline#java#outline_info() abort
  return s:outline_info
endfunction

let s:pat_class = 
      \ '\%(\s*\%(public\|private\)\=' . 
      \ '\%(\s\+\%(abstract\)\)\=' . 
      \ '\s\+\%(class\|interface\)\s\+\u\w\+' . 
      \ '\%(\s\+\%(extends\|implements\)\s\+\u\w\+\)\=' . 
      \ '\s*{\)'

let s:pat_method = 
      \ '\%(\s\+\%(public\|protected\|private\)\=' .
      \ '\%(\s\+\%(static\)\)\=' . 
      \ '\%(\s\+\%(void\|\w\+\)\)\=' .
      \ '\s\+\w\+\s*(.*)\s*{\)'

let s:outline_info = {
      \ 'heading': '^\%(' . s:pat_class . '\|' . s:pat_method . '\)'
      \ }

function! s:outline_info.create_heading(which, heading_line, matched_line, context) abort
  let level = (indent(a:context.heading_lnum) / shiftwidth()) + 1

  let heading = {
        \   'word' : a:heading_line,
        \   'level': level,
        \   'type' : 'generic',
        \ }

  return heading
endfunction
      

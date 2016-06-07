function! outline#javascript#outline_info() abort
  return s:outline_info
endfunction

let s:pat_node_module = '\%(\s*module\.exports\s*=\s*function\)'
let s:pat_assign_func = '\%(\s*var\s\w\+\s*=\s*function\)'
let s:pat_gulp_task = '\%(\s*gulp.task(\)'
let s:pat_jasmine = '\%(\s*\%([Dd]escribe\|[Ii]t\)(.\+,\s*function\)'


let s:outline_info = {
      \ 'heading': '^\%(' . s:pat_node_module . '\|' . s:pat_assign_func . '\|' . 
      \                     s:pat_gulp_task . '\|' . s:pat_jasmine . '\)',
      \ 'highlight_rules': [
      \   { 'name' : 'description', 'pattern'  : '/''.\+''/', 'highlight': unite#sources#outline#get_highlight('type') }
      \ ]
      \ }

function! s:outline_info.create_heading(which, heading_line, matched_line, context) abort
  let word = a:heading_line
  let level = (indent(a:context.heading_lnum) / shiftwidth()) + 1

  if a:heading_line =~ '^\s\+[Ii]t('
    let word = '|------' . word
  endif

  let heading = {
        \   'word' : word,
        \   'level': level,
        \   'type' : 'generic',
        \ }

  return heading
endfunction

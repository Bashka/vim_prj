" Date Create: 2015-01-17 11:28:44
" Last Change: 2015-02-01 13:45:56
" Author: Artur Sh. Mamedbekov (Artur-Mamedbekov@yandex.ru)
" License: GNU GPL v3 (http://www.gnu.org/copyleft/gpl.html)

let s:File = vim_lib#base#File#
let s:Publisher = vim_lib#sys#Publisher#

"" {{{
" Метод создает каталог проекта для текущего проекта.
"" }}}
function! vim_prj#createPrj() " {{{
  let l:dirprj = s:File.relative('.vimprj')
  if !l:dirprj.isExists()
    call l:dirprj.createDir()
    call s:Publisher.new().fire('VimPrjCreate', {'dirprj': l:dirprj})
  endif
  let l:vimrc = l:dirprj.getChild('vimrc.vim')
  if !l:vimrc.isExists()
    call l:vimrc.createFile()
  endif
endfunction " }}}

"" {{{
" Метод сохраняет текущую сессию в файл .vimprj/session.vim
"" }}}
function! vim_prj#saveSession() " {{{
  set sessionoptions=folds,winsize,help,curdir
  exe 'mksession! .vimprj' . s:File.slash . 'session.vim'
endfunction " }}}

"" {{{
" Метод загружает сессию из файла .vimprj/session.vim
"" }}}
function! vim_prj#loadSession() " {{{
  if filereadable('.vimprj' . s:File.slash . 'session.vim')
    exe 'silent! so .vimprj' . s:File.slash . 'session.vim'
    filetype detect
    call s:Publisher.new().fire('VimPrjLoadSession')
  endif
endfunction " }}}

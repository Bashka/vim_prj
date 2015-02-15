" Date Create: 2015-01-17 11:28:44
" Last Change: 2015-02-15 12:11:53
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
    call s:Publisher.new().fire('VimPrjCreate', {'dirprj': l:dirprj.getDir().getAddress()})
  endif
  let l:vimrc = l:dirprj.getChild('vimrc.vim')
  if !l:vimrc.isExists()
    call l:vimrc.createFile()
  endif
  call g:vim_prj#.run()
endfunction " }}}

"" {{{
" Метод сохраняет текущую сессию в файл .vimprj/session.vim
"" }}}
function! vim_prj#saveSession() " {{{
  if g:vim_prj#.savesession
    set sessionoptions=folds,winsize,help,curdir,localoptions
    exe 'mksession! .vimprj' . s:File.slash . 'session.vim'
  endif
endfunction " }}}

"" {{{
" Метод загружает сессию из файла .vimprj/session.vim
"" }}}
function! vim_prj#loadSession() " {{{
  if g:vim_prj#.savesession && filereadable('.vimprj' . s:File.slash . 'session.vim')
    exe 'silent! so .vimprj' . s:File.slash . 'session.vim'
    call s:Publisher.new().fire('VimPrjLoadSession')
  endif
endfunction " }}}

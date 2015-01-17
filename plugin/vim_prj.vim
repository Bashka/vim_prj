" Date Create: 2015-01-17 10:48:16
" Last Change: 2015-01-17 19:37:58
" Author: Artur Sh. Mamedbekov (Artur-Mamedbekov@yandex.ru)
" License: GNU GPL v3 (http://www.gnu.org/copyleft/gpl.html)

let s:Plugin = vim_lib#sys#Plugin#
let s:File = vim_lib#base#File#

let s:p = s:Plugin.new('vim_prj', '1')
call s:p.def('dirprj', '.vimprj') " Наименование каталога проекта

function! s:p.run() " {{{
  let &g:rtp = s:p.dirprj . ',' . &g:rtp
  let self.global = $VIMRUNTIME
  if has('win16') || has('win32') || has('win64') || has('win95')
    let self.user = $HOME . '\vimfiles'
  else
    let self.user = $HOME . '/.vim'
  endif
  let self.prj = s:File.relative(g:vim_prj#.dirprj).getAddress()
endfunction " }}}

call s:p.comm('VimPrjCreate', 'createPrj') " Создание каталога проекта
call s:p.reg()

" Date Create: 2015-01-17 10:48:16
" Last Change: 2015-01-17 18:39:04
" Author: Artur Sh. Mamedbekov (Artur-Mamedbekov@yandex.ru)
" License: GNU GPL v3 (http://www.gnu.org/copyleft/gpl.html)

let s:Plugin = vim_lib#sys#Plugin#

let s:p = s:Plugin.new('vim_prj', '1')
call s:p.def('dirprj', '.vimprj') " Наименование каталога проекта

function! s:p.run() " {{{
  let &g:rtp = s:p.dirprj . ',' . &g:rtp
endfunction " }}}

call s:p.comm('VimPrjCreate', 'createPrj') " Создание каталога проекта
call s:p.reg()
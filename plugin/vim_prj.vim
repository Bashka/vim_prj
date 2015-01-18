" Date Create: 2015-01-17 10:48:16
" Last Change: 2015-01-18 15:35:58
" Author: Artur Sh. Mamedbekov (Artur-Mamedbekov@yandex.ru)
" License: GNU GPL v3 (http://www.gnu.org/copyleft/gpl.html)

let s:Plugin = vim_lib#sys#Plugin#
let s:File = vim_lib#base#File#

let s:p = s:Plugin.new('vim_prj', '1')

function! s:p.run() " {{{
  let self.global = $VIMRUNTIME
  let self.user = $HOME . s:File.slash . 'vimfiles'
  let l:prjDir = s:File.relative('.vimprj')
  let self.prj = l:prjDir.getAddress()
  let l:vimrc = l:prjDir.getChild('vimrc.vim')
  if l:vimrc.isExists()
    exec 'source ' . l:vimrc.getAddress()
  endif
endfunction " }}}

call s:p.comm('VimPrjCreate', 'createPrj') " Создание каталога проекта
call s:p.reg()

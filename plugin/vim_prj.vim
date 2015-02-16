" Date Create: 2015-01-17 10:48:16
" Last Change: 2015-02-16 14:09:34
" Author: Artur Sh. Mamedbekov (Artur-Mamedbekov@yandex.ru)
" License: GNU GPL v3 (http://www.gnu.org/copyleft/gpl.html)

let s:Plugin = vim_lib#sys#Plugin#
let s:File = vim_lib#base#File#
let s:System = vim_lib#sys#System#.new()

let s:p = s:Plugin.new('vim_prj', '1')
let s:p.vimrc = 1
let s:p.savesession = 1

function! s:p.run() " {{{
  " Определение адресов каталогов скриптов. {{{
  let self.global = $VIMRUNTIME
  if has('win16') || has('win32') || has('win64') || has('win95')
    let self.user = $HOME . s:File.slash . 'vimfiles'
  else
    let self.user = $HOME . s:File.slash . '.vim'
  endif
  let l:prjDir = s:File.relative('.vimprj')
  let self.prj = l:prjDir.getAddress()
  " }}}
  " Сохранение и восстановление последней сессии проекта. {{{
  if l:prjDir.isExists()
    call s:System.au('VimLeavePre', function('vim_prj#saveSession'))
    call s:System.au('VimEnter', function('vim_prj#loadSession'))
  endif
  " }}}
  " Исполнение скрипта .vimprj/vimrc.vim {{{
  let l:vimrc = l:prjDir.getChild('vimrc.vim')
  if self.vimrc && l:vimrc.isExists()
    exec 'source ' . l:vimrc.getAddress()
  endif
  " }}}
endfunction " }}}

call s:p.menu('CreatePrj', 'createPrj')

call s:p.comm('VimPrjCreate', 'createPrj()') " Создание каталога проекта

call s:p.reg()

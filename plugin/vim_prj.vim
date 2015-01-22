" Date Create: 2015-01-17 10:48:16
" Last Change: 2015-01-22 11:22:54
" Author: Artur Sh. Mamedbekov (Artur-Mamedbekov@yandex.ru)
" License: GNU GPL v3 (http://www.gnu.org/copyleft/gpl.html)

let s:Plugin = vim_lib#sys#Plugin#
let s:File = vim_lib#base#File#

let s:p = s:Plugin.new('vim_prj', '1')
call s:p.def('vimrc', 1)
call s:p.def('savesession', 1)

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
  if self.savesession && l:prjDir.isExists()
    au VimLeavePre * 
          \ set sessionoptions=folds,winsize,help,curdir,options |
          \ exe 'mksession! .vimprj' . vim_lib#base#File#.slash . 'session.vim'
    au VimEnter * 
          \ if filereadable('.vimprj' . vim_lib#base#File#.slash . 'session.vim') |
          \   exe 'silent! so .vimprj' . vim_lib#base#File#.slash . 'session.vim' |
          \   silent! echo vim_lib#sys#Publisher# |
          \   call vim_lib#sys#Publisher#.new().fire('VimPrjLoadSession') |
          \ endif
  endif
  " }}}
  " Исполнение скрипта .vimprj/vimrc.vim {{{
  let l:vimrc = l:prjDir.getChild('vimrc.vim')
  if self.vimrc && l:vimrc.isExists()
    exec 'source ' . l:vimrc.getAddress()
  endif
  " }}}
endfunction " }}}

call s:p.comm('VimPrjCreate', 'createPrj') " Создание каталога проекта
call s:p.reg()

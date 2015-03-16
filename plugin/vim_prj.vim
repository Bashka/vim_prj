" Date Create: 2015-01-17 10:48:16
" Last Change: 2015-03-16 12:23:02
" Author: Artur Sh. Mamedbekov (Artur-Mamedbekov@yandex.ru)
" License: GNU GPL v3 (http://www.gnu.org/copyleft/gpl.html)

let s:Plugin = vim_lib#sys#Plugin#
let s:File = vim_lib#base#File#
let s:System = vim_lib#sys#System#.new()

let s:p = s:Plugin.new('vim_prj', '1')
"" {{{
" @var bool true - если следует выполнять сохранение и восстановление последней сессии пользователя.
"" }}}
let s:p.savesession = 1
if !exists('g:vim_prj#opt')
  "" {{{
  " @var hash Свойства проекта.
  "" }}}
  let g:vim_prj#opt = {}
endif

function! s:p.run() " {{{
  " Определение адресов каталогов скриптов. {{{
  let self.global = $VIM . s:File.slash . 'vimfiles'
  if has('win16') || has('win32') || has('win64') || has('win95')
    let self.user = $HOME . s:File.slash . 'vimfiles'
  else
    let self.user = $HOME . s:File.slash . '.vim'
  endif
  let l:prjDir = s:File.relative('.vim')
  let self.prj = l:prjDir.getAddress()
  " }}}
  " Сохранение и восстановление последней сессии проекта. {{{
  if l:prjDir.isExists()
    call s:System.au('VimLeavePre', function('vim_prj#saveSession'))
    call s:System.au('VimEnter', function('vim_prj#loadSession'))
  endif
  " }}}
  set exrc
endfunction " }}}

call s:p.menu('CreatePrj', 'createPrj')

call s:p.comm('VimPrjCreate', 'createPrj()')

call s:p.reg()

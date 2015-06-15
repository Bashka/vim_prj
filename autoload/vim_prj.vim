" Date Create: 2015-01-17 11:28:44
" Last Change: 2015-06-16 00:00:39
" Author: Artur Sh. Mamedbekov (Artur-Mamedbekov@yandex.ru)
" License: GNU GPL v3 (http://www.gnu.org/copyleft/gpl.html)

let s:File = vim_lib#base#File#
let s:Publisher = vim_lib#sys#Publisher#
let s:Content = vim_lib#sys#Content#.new()

"" {{{
" Метод создает каталог проекта для текущего проекта.
"" }}}
function! vim_prj#createPrj() " {{{
  let l:dirprj = s:File.relative('.vim')
  if !l:dirprj.isExists()
    call l:dirprj.createDir()
    call s:Publisher.new().fire('VimPrjCreate', {'dirprj': l:dirprj.getDir().getAddress()})
  endif

  let l:pluginsFile = l:dirprj.getChild('plugins.vim')
  if !l:pluginsFile.isExists()
    call l:pluginsFile.createFile()
  endif

  let l:bundleDir = l:dirprj.getChild('bundle')
  if !l:bundleDir.isExists()
    call l:bundleDir.createDir()
  endif

  let l:vimrc = s:File.relative('.vimrc')
  if !l:vimrc.isExists()
    call l:vimrc.createFile()
    call l:vimrc.rewrite([
          \  'filetype off',
          \  "call vim_lib#sys#Autoload#init('.vim', 'bundle')",
          \  'so .vim/plugins.vim',
          \  'filetype indent plugin on',
          \])
  endif

  call g:vim_prj#.run()
endfunction " }}}

"" {{{
" Метод сохраняет текущую сессию в файл .vim/session.vim
"" }}}
function! vim_prj#saveSession() " {{{
  if g:vim_prj#.savesession && vim_prj#isPrj()
    set sessionoptions=folds,winsize,help,curdir,localoptions,tabpages
    exe 'mksession! .vim' . s:File.slash . 'session.vim'
  endif
endfunction " }}}

"" {{{
" Метод загружает сессию из файла .vim/session.vim
"" }}}
function! vim_prj#loadSession() " {{{
  if g:vim_prj#.loadsession && 
   \ bufname('%') == '' && 
   \ s:Content.isEmpty() && 
   \ vim_prj#isPrj() && 
   \ filereadable('.vim' . s:File.slash . 'session.vim')
    exe 'silent! so .vim' . s:File.slash . 'session.vim'
    call s:Publisher.new().fire('VimPrjLoadSession')
  endif
endfunction " }}}

"" {{{
" Метод определяет, является ли текущий каталог корневым каталогом проекта.
" @return bool true - если текущий каталог содержит каталог .vim, иначе - false.
"" }}}
function! vim_prj#isPrj() " {{{
  return s:File.absolute(getcwd() . s:File.slash . '.vim').isExists() && getcwd() != $HOME
endfunction " }}}

" hanoi.vim -- Tower of Hanoi game for Vim
" Author: Hari Krishna (hari_vim at yahoo dot com)
" Last Change: 02-Feb-2007 @ 16:56
" Created: 29-Jan-2004
" Requires: Vim-7.0, genutils.vim(2.0)
" Version: 2.0.0
" Licence: This program is free software; you can redistribute it and/or
"          modify it under the terms of the GNU General Public License.
"          See http://www.gnu.org/copyleft/gpl.txt 
" Acknowledgements:
"   - Thanks to Anoine J. Mechelynck (antoine dot Mechelynck at belgacom dot
"     net) for reporting problems and giving feedback.
" Download From:
"     http://www.vim.org/script.php?script_id=900
" Description:
"   This is just a quick-loader for the Tower of Hanoi game, see
"   games/hanoi/hanoi.vim for the actual code.
"
"   Use hjkl keys to move the disk. Use <Space> to pause the play. Use <C-C>
"   to stop the demo or play at any time.
"
"   Some good information about this puzzle can be found at:
"     http://www.cut-the-knot.org/recurrence/hanoi.shtml

if v:version < 700
  echomsg 'You need Vim 7.0 to run this version of hanoi.vim.'
  finish
endif
if v:version == 700 && !has('patch135')
  echomsg "hanoi: Your Vim version doesn't have the patch 135 that is required to avoid a crash"
  finish
endif


" Dependency checks.
if !exists('loaded_genutils')
  runtime plugin/genutils.vim
endif
if !exists('loaded_genutils') || loaded_genutils < 200
  echomsg 'hanoi: You need the latest version of genutils.vim plugin'
  finish
endif

command! -nargs=? Hanoi :call hanoi#Hanoi(<q-args>)


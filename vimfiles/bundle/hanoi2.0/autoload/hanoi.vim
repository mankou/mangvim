" See plugin/hanoi.vim for details
" TODO:
"   - Implement level 2.
"   - Smooth moves.

" Make sure line-continuations won't cause any problem. This will be restored
"   at the end
let s:save_cpo = &cpo
set cpo&vim

" Initialization {{{

if !exists('g:hanoiNoSplash')
  let g:hanoiNoSplash = 0
endif

if !exists('g:hanoiNDisks')
  let g:hanoiNDisks = ''
endif

if !exists('s:myBufNum')
  let s:myBufNum = -1
endif

if exists('s:NULL')
  unlockvar! s:NULL
endif
let s:NULL = {}
lockvar! s:NULL

let s:GAP = 2 " Gap between the pole and disk at the top.
let s:INCREMENT = 2 " Increment in width.
let s:POLE_CLEARANCE = 2
let s:MINWIDTH = 3 " Width of the disk with ID = 1.

let s:GAME_PAUSED = 'G A M E   P A U S E D'

let s:playPaused = 0
let s:moves = 0
let s:disks = []
let s:poles = []

let s:curdisk = s:NULL
let s:curpole = s:NULL

" Initialization }}}

function! s:SetupBuf()
  let s:MAXX = winwidth(0)
  let s:MAXY = winheight(0)
  let maxWidthByWidth = (s:MAXX - 4)/3 " Leave 1 space and devide into 3 parts.
  let maxWidthByHeight = s:MAXY - s:GAP - s:POLE_CLEARANCE + 1
  let s:MAXWIDTH = (maxWidthByWidth < maxWidthByHeight) ? maxWidthByWidth :
        \ maxWidthByHeight
  let s:MAX_DISKS = (s:MAXWIDTH - s:MINWIDTH)/s:INCREMENT

  call s:clear()
  call genutils#SetupScratchBuffer()
  setlocal noreadonly " Or it shows [RO] after the buffer name, not nice.
  setlocal nonumber
  setlocal foldcolumn=0 nofoldenable
  setlocal tabstop=1
  setlocal nolist
  setlocal bufhidden=hide

  " Setup syntax such a way that any non-tabs appear as selected.
  syn clear
  syn match HanoiSelected "[^\t]"
  hi HanoiSelected gui=reverse term=reverse cterm=reverse
 
  " Let pressing space again resume a paused game.
  nnoremap <buffer> <Space> :Hanoi<CR>
endfunction

function! hanoi#Hanoi(nDisks)
  if s:myBufNum == -1
    " Temporarily modify isfname to avoid treating the name as a pattern.
    let _isf = &isfname
    let _cpo = &cpo
    try
      set isfname-=\
      set isfname-=[
      set cpo-=A
      if exists('+shellslash')
	exec "sp \\\\[Hanoi]"
      else
	exec "sp \\[Hanoi]"
      endif
    finally
      let &isfname = _isf
      let &cpo = _cpo
    endtry
    let s:myBufNum = bufnr('%')
  else
    let buffer_win = bufwinnr(s:myBufNum)
    if buffer_win == -1
      exec 'sb '. s:myBufNum
    else
      exec buffer_win . 'wincmd w'
    endif
  endif
  wincmd _

  let restCurs = ''
  let _gcr = &guicursor
  try
    setlocal modifiable

    let restCurs = substitute(genutils#GetVimCmdOutput('hi Cursor'),
          \ '^\(\n\|\s\)*Cursor\s*xxx\s*', 'hi Cursor ', '')
    let hideCurs = substitute(genutils#GetVimCmdOutput('hi Normal'),
          \ '^\(\n\|\s\)*Normal\s*xxx\s*', 'hi Cursor ', '')
    " Font attribute for Cursor doesn't seem to be really used, and it might
    " cause trouble if has spaces in it, so just remove this attribute.
    let restCurs = substitute(restCurs, ' font=.\{-}\(\w\+=\|$\)\@=', ' ', '')
    let hideCurs = substitute(hideCurs, ' font=.\{-}\(\w\+=\|$\)\@=', ' ', '')

    let option = 'p'
    if !s:playPaused
      call s:SetupBuf()

      if a:nDisks == ''
        let number = s:welcome()
      else
        let number = a:nDisks+0
      endif
      if ! s:Initialize(number)
        quit
        return
      endif

      "exec "normal \<C-G>a" " Create an undo point.
      "call s:putstr(s:MAXY/2, s:MAXX/2-20,
      "      \ 'You want to play or see the Demo(p, d)?[p] ')
      "redraw
      echon 'You want to play or see the Demo(p, d)?[p] '
      let option = getchar()
      "silent! undo
      if option == '^\d\+$' || type(option) == 0
        let option = nr2char(option)
      endif " It is the ascii code.
    endif

    " This is like "hi Cursor guifg=White guibg=grey20" for desert color scheme.
    exec hideCurs
    " FIXME: This generates "W18: Invalid character in group name"
    set guicursor=n-i:hor1:ver1
    if option == "d"
      call s:demo()
    else
      call s:play()
    endif
  catch /^Vim:Interrupt$/
    " Do nothing.
  finally
    exec restCurs | " Restore the cursor highlighting.
    let &guicursor = _gcr
    call setbufvar(s:myBufNum, '&modifiable', !s:playPaused)
  endtry
endfunction

function! s:welcome()
  if g:hanoiNoSplash
    return
  endif

  call s:clear()
  let y = s:MAXY/2 - 6
  call s:putstrcentered(y, 'T O W E R   O F   H A N O I')
  call s:putstrcentered(y+3, 'F O R   V I M')
  call s:putstr(y+5, 1, 'Move all the disks from the I pole to III pole')
  call s:putstr(y+7, 1, 'Bigger disk on a Smaller one is not allowd')
  call s:putstr(y+9, 1, "Use 'h' & 'l' keys to Select the pole" .
        \ " and move a disk ")
  call s:putstr(y+11, 1, "Use 'j' & 'k' keys to lift and drop a disk")
  call s:putstr(y+13, 1, 'q or <ctrl>C to Quit and <Space> to Pause the play')
  call s:putstr(y+15, 1, 'How many disks you want to select?(<' .
        \ (s:MAX_DISKS+1) . ")? ")
  redraw
  return input('Enter number of disks: ') + 0
endfunction

function! s:Initialize(number)
  call s:clear()
  if a:number > s:MAX_DISKS
    echo "Sorry, too many disks."
    return 0
  elseif a:number < 1
    echo "Kidding?"
    return 0
  else
    let s:number = a:number
  endif

  " 1 for base and a few left out at the top.
  let s:poleheight = s:number + 1 + s:POLE_CLEARANCE
  let s:polepos = (s:MAXY - s:poleheight) / 2 + s:poleheight " Bottom position.

  " Create 3 poles.
  let nPoles = 3
  let i = 0
  let prevpole = s:NULL
  let s:poles = []
  while i < nPoles
    let pole = s:polecls.new(i, s:polepos, s:MAXX/6*(2*i+1), s:poleheight, s:GAP,
	  \ s:number)
    call add(s:poles, pole)
    call pole.Draw(s:MINWIDTH, s:INCREMENT)
    if prevpole isnot s:NULL
      let prevpole.next = pole
      let pole.prev = prevpole
    endif
    let i += 1
    let prevpole = pole
  endwhile
  let s:poles[0].prev = s:poles[-1]
  let s:poles[-1].next = s:poles[0]

  let i = s:number
  let s:disks = []
  while i > 0
    " Create disks.
    let disk = s:diskcls.new(i, s:MINWIDTH, s:INCREMENT)
    call add(s:disks, disk)
    let disk.ison = 1
    call s:poles[0].PushDisk(disk)
    call disk.Draw(' ', 1)
    let i -= 1
  endwhile
  let s:curdisk = s:disks[-1]
  call s:curdisk.Draw('-', 1)
  let s:curpole = s:poles[0]
  let s:moves = 0

  return 1
endfunction

function! s:play()
  if s:playPaused
    " Erase the game paused message.
    call s:putstrcentered(1, substitute(s:GAME_PAUSED, '.', "\t", 'g'))
    redraw
  endif
  let s:playPaused = 0
  redraw
  while !(s:poles[-1].NOD() == s:number && s:curdisk.ison)
    let char = getchar()
    if char == '^\d\+$' || type(char) == 0
      let char = nr2char(char)
    endif " It is the ascii code.

    if char == 'q'
      quit
      return
    elseif char == ' '
      let s:playPaused = 1
      call s:putstrcentered(1, s:GAME_PAUSED)
      return
    elseif char == 'k' " UP
      call s:PoleDiskUp()
    elseif char == 'j' " DOWN
      call s:PoleDiskDown()
    elseif char == 'l' " RIGHT
      if ! s:PoleMoveDisk(s:curpole.next)
        " If the disk is on the pole.
        call s:PoleSelectPole(s:curpole.next)
      endif
    elseif char == 'h' " LEFT
      if ! s:PoleMoveDisk(s:curpole.prev)
        " If the disk is on the pole.
        call s:PoleSelectPole(s:curpole.prev)
      endif
    endif
    call s:ShowMoves()
  endwhile
  call s:putstrcentered(s:MAXY/2 - 2, 'E X C E L L E N T !!')
endfunction

function! s:ShowMoves()
  call s:putstrcentered(s:MAXY, 'Moves: ' . s:moves) | redraw
endfunction

function! s:demo()
  let polenr = 0
  let i = 0
  while i < s:number
    call s:move(0, polenr, 2) " Ultimate target.
    if (polenr)
      let polenr = 0
    else
      let polenr = 1
    endif
    let i = i + 1
  endwhile
endfunction

" Move the disk at the given position from source pole to destination pole.
function! s:move(position, spnr, dpnr)
  let opnr = 3 - a:spnr - a:dpnr " Find the other pole.
  let position = a:position

  while position < (s:poles[a:spnr].NOD() - 1) " While this is not the top most disk,
    " first move the disk that is above this disk to the other pole,
    call s:move(position + 1, a:spnr, opnr)

    let tmpNDisks = s:poles[a:dpnr].NOD()
    let i = 0
    " if the destination pole is not empty,
    if tmpNDisks
      " find the disk which is larger than the present,
      while i < tmpNDisks
	if s:poles[a:dpnr].GetDiskID(tmpNDisks - i) >
	      \ s:poles[a:spnr].GetDiskID(position + 1)
	  break
	endif
	let i += 1
      endwhile
    endif
    " and move all the disks that are above this disk to the other pole, such
    " that the disk can be placed on the destination pole,
    if i
      call s:move(tmpNDisks - i, a:dpnr, opnr) " Results in a recursive call.
    endif
  endwhile
  " and finally move the disk that was asked for.
  call s:delay()
  call s:PoleSelectPole(s:poles[a:spnr])
  redraw
  call s:delay()
  call s:PoleDiskUp()
  call s:ShowMoves()
  call s:delay()
  call s:PoleMoveDisk(s:poles[a:dpnr])
  call s:ShowMoves()
  call s:delay()
  call s:PoleDiskDown()
  call s:ShowMoves()
endfunction

function! s:putrow(y, x1, x2, ch)
  let y = (a:y > 0) ? a:y : 1
  let x1 = (a:x1 > 0) ? a:x1 : 1
  let x2 = (a:x2 > 0) ? a:x2 : 1
  let x2 = (x2 == s:MAXX) ? x2 + 1 : x2
  let ch = a:ch[0]
  let _search = @/
  let _report = &report
  try
    set report=99999
    let @/ = '\%>'.(x1-1).'c.\%<'.(x2+2).'c'
    silent! exec y.'s//'.ch.'/g'
  finally
    let &report = _report
    let @/ = _search
  endtry
endfunction

function! s:putcol(y1, y2, x, ch)
  let y1 = (a:y1 > 0) ? a:y1 : 1
  let y2 = (a:y2 > 0) ? a:y2 : 1
  let x = (a:x > 0) ? a:x : 1
  let ch = a:ch[0]
  let _search = @/
  let _report = &report
  try
    set report=99999
    let @/ = '\%'.x.'c.'
    silent! exec y1.','.y2.'s//'.ch
  finally
    let &report = _report
    let @/ = _search
  endtry
endfunction

function! s:putstr(y, x, str)
  let y = (a:y > 0) ? a:y : 1
  let x = (a:x > 0) ? a:x : 1
  let _search = @/
  let _report = &report
  try
    if a:y > line('$')
      $put=a:str
    else
      set report=99999
      let @/ = '\%'.x.'c.\{'.strlen(a:str).'}'
      silent! exec y.'s//'.escape(a:str, '\&~')
    endif
  finally
    let &report = _report
    let @/ = _search
  endtry
endfunction

function! s:putstrcentered(y, str)
  call s:putstr(a:y, (s:MAXX-strlen(a:str))/2, a:str)
endfunction

function! s:clear()
  call genutils#OptClearBuffer()
  " Fill the buffer with tabs.
  let tabFill = substitute(genutils#GetSpacer(s:MAXX), ' ', "\t", 'g')
  while strlen(tabFill) < s:MAXX
    let tabFill = tabFill.strpart(tabFill, 0, s:MAXX - strlen(tabFill))
  endwhile
  silent! call setline(1, tabFill)
  let i = 2
  while i <= s:MAXY
    silent! $put=tabFill
    let i = i + 1
  endwhile 
endfunction

function! s:delay()
  sleep 500m
  "sleep 1m
endfunction

" Pole {{{

" To facilitate dynamic reloading.
if exists('s:polecls')
  unlockvar! s:polecls
endif

let s:polecls = {}
function! s:polecls.new(id, posy, posx, height, gap, maxno)
  let pole = copy(s:polecls)
  unlockvar! pole
  let pole.id = a:id " Id
  let pole.y = a:posy
  let pole.x = a:posx
  let pole.height = a:height
  let pole.gap = a:gap
  let pole.disks = []
  let pole.maxno = a:maxno " Capacity.
  let pole.next = s:NULL " Next pole.
  let pole.prev = s:NULL " Previous pole.
  return pole
endfunction

function! s:polecls.NOD()
  return len(self.disks)
endfunction

function! s:polecls.TopId()
  return (self.NOD() < 2) ? self.maxno + 1 : self.disks[self.NOD() - 2].id
endfunction

function! s:polecls.PushDisk(disk)
  " CHECK: if the current top disk is bigger than this disk.
  call add(self.disks, a:disk)
  call a:disk.MoveTo(self, self.NOD())
endfunction

function! s:polecls.PopDisk()
  " CHECK: if there are any other disks which are not on the poles.
  return remove(self.disks, -1)
endfunction

function! s:polecls.GetDisk(pos)
  return self.disks[a:pos - 1]
endfunction

" Get the disk id of the disk at the given position.
function! s:polecls.GetDiskID(pos)
  return (self.NOD() >= a:pos) ? self.GetDisk(a:pos).id : 0 " 0 for no disks.
endfunction

function! s:polecls.Draw(min, inc)
  call s:putcol(self.y-self.height, self.y, self.x, ' ')

  let disk = s:diskcls.new(self.maxno+1, a:min, a:inc) " Dummy disk as a base.
  let disk.ison = 1
  call disk.MoveTo(self, 0) " Move to the base position.
  call disk.Draw(' ', 0)
endfunction

" Get the next valid pole. Returns self when not found.
function! s:polecls.NextPole()
  let nextPole = self.next
  while nextPole != self
    if nextPole.NOD() != 0
      break
    endif
    let nextPole = nextPole.next
  endwhile
  return nextPole
endfunction

" Get the previous valid pole. Returns self when not found.
function! s:polecls.PrevPole()
  let prevPole = self.prev
  while prevPole != self
    if prevPole.NOD() != 0
      break
    endif
    let prevPole = prevPole.prev
  endwhile
  return prevPole
endfunction

" Static methods of Pole.
function! s:PoleSelectPole(newPole)
  if s:curpole != a:newPole
    call s:curdisk.Draw(' ', 1)
    let s:curdisk = a:newPole.GetDisk(a:newPole.NOD())
    call s:curdisk.Draw('-', 1)
    let s:curpole = a:newPole
  endif
endfunction

" These functions always operate on the current disk.
function! s:PoleMoveDisk(targetPole)
  if ! s:curdisk.ison " If the disk is not on the pole.
    call s:curdisk.Erase()
    call s:curdisk.pole.PopDisk()
    call a:targetPole.PushDisk(s:curdisk)
    call s:curdisk.Draw('-', 1)
    let s:curpole = a:targetPole
    let s:moves += 1
    return 1
  endif
  return 0
endfunction

function! s:PoleDiskUp()
  if s:curdisk.ison " If only on.
    call s:curdisk.Erase()
    let s:curdisk.ison = 0
    call s:curdisk.Draw('-', 1)
    let s:moves += 1
    return 1
  endif
  return 0
endfunction

function! s:PoleDiskDown()
  if ! s:curdisk.ison " If not already on only.
    " Allow only smaller disk.
    if s:curdisk.pole.TopId() > s:curdisk.id
      call s:curdisk.Erase()
      let s:curdisk.ison = 1
      call s:curdisk.Draw('-', 1)
      let s:moves += 1
      return 1
    endif
  endif
  return 0
endfunction

" Pole }}}

" Disk {{{

" To facilitate dynamic reloading.
if exists('s:diskcls')
  unlockvar! s:diskcls
endif
let s:diskcls = {}

function! s:diskcls.new(id, min, inc)
  let disk = copy(s:diskcls)
  unlockvar! disk
  let disk.id = a:id
  let disk.width = a:min + a:inc * (a:id - 1)
  let disk.pos = 0
  let disk.ison = 0
  let disk.pole = s:NULL
  return disk
endfunction

function! s:diskcls.MoveTo(pole, pos)
  let self.pole = a:pole
  let self.pos = a:pos
endfunction

function! s:diskcls.Erase()
  call self.DrawImpl("\t", (self.ison ? 2 : 0))
endfunction

function! s:diskcls.Draw(ch, opt)
  call self.DrawImpl(a:ch, a:opt)
endfunction

function! s:diskcls.DrawImpl(ch, opt)
  let y = self.ison ? self.pole.y - self.pos :
        \ self.pole.y - self.pole.height - self.pole.gap

  let stx = self.pole.x - self.width/2
  call s:putrow(y, stx, stx+self.width-1, a:ch)
  if a:opt == 1
    " Show the disk id in the middle.
    call s:putstr(y, self.pole.x, self.id)
  elseif a:opt == 2
    " Erasing, make sure pole is restored correctly.
    call s:putstr(y, self.pole.x, " ")
  endif
endfunction

lockvar! s:diskcls
 
" Disk }}}


" Restore cpo.
let &cpo = s:save_cpo
unlet s:save_cpo

" vim6:fdm=marker et sw=2

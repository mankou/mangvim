"last modify::2015/1/25 18:54:05

"#########规范说明####################
"建立于2012-04-26

"设置标题参考：#########Vimwiki相关设置#########  vimwiki与前面的#号之间不要有任何的字符，vimwiki之后可以随便添加汉字，以方便阅读。这样做的目的是以后可以通过搜索 #Vimwiki 快速定位到vimwiki设置区域。

"目前有 规范说明 全局设置 vimwiki calendar Voom 快捷键汇总 4个设置区

"自定义的快捷键在各自区域定义，如vimwiki的快捷键在vimwiki设置区域定义。但为了以后管理查看方便，要把设置的快捷键以注释的方式在 #######快捷键汇总##### 区域备份一下

"一般情况下各区域后面添加的设置放在各区域的后面，添加时搜索append 标题名快速定位到要添加的位置。如为vimwiki添加设置则搜索 append vimwiki 可快速定位到添加位置。

"每次修改完_vimrc 要更新last modify 以便dorm lab核对是否为同一版本。

"append　standard　规范说明在上面添加#######


"##########hotkey 快捷键汇总####################
"------下方都是自定义的快捷键，已经在各自区域设置，这里为了以后管理方便，为了防止以后设置快捷键冲突，所以这里集中起来。
"-------全局
	"map ,mdc : <esc>: cd E:\CodeSpace\C\mangCExercise_Vim<cr>
	"map ,mc : <esc>:!..\..\copyNext.bat
	"map ,mc2: <esc>:!D:\shortcut\commonTools\copyLog\copyLog.bat
	":nnoremap ,mt "=strftime("%c")<CR>p
	":nnoremap ,mtt "=strftime("%H:%M")<CR>p
	":map ,mg a`<esc>,mttw<esc>
	"map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR> 
"-------vimwiki
	"map ,ms : <esc>:VimwikiSearch
	"map ,mn : <esc>:lnext <Return>
	"map ,mp : <esc>:lprevious <Return>
	"map ,mo : <esc>:lopen <Return>
	"map ,w :w<cr>
	"map ,q :wq<cr>
"-------Voom
	"map \f <esc><LocalLeader><LocalLeader>:q<return> 

"-------Taglist
	"nnoremap <silent>  tg :TlistToggle<CR>
	"map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR> 
"------winManager
	"nmap ,wm :WMToggle<cr>
"------nerdtree
	"nmap <F3> :NERDTree  <CR>
"------Minibufexplorer
	"noremap Q :CMiniBufExplorer<CR>:q<CR>
	"noremap tm :TMiniBufExplorer<CR>  
"------bufexplorer
	":nmap <C-right> :<esc><C-l>:q<cr>
	":nmap <C-left> :<esc><C-h>:q<cr>
"------project
	"nmap <silent> <Leader>P <Plug>ToggleProject
"-------program
	"map <F5> :call Do_OneFileMake()<CR>
	"map <F6> :!make<CR>
	"map <c-F6> :!make clean<CR>
	"autocmd FileType c,cpp  map <buffer> <leader><space> :w<cr>:silent make<cr>:copen 5<cr>
	"nmap <F7> :cp<cr>
	"nmap <F8> :cn<cr>
	"map <C-F5> :call Debug()<CR>
	"nmap <leader>cw   :cw 5<cr>
	"nmap q :close<cr>
"---------git
	"map <leader>gs :GitStatus<cr>
	"map <leader>gc :GitCommit<cr>
	"map <leader>ga :GitAdd<cr>
	"map <leader>gp :GitPush<cr>
	"map <leader>gpa :GitPush --all<cr>
	"map <leader>gL :GitPull<cr>
	"map <leader>gl :GitLog<cr>

"---------vimim
	"CTRL+ ^ 各中文输入法间切换
	"CTRL+ - 打开/关闭中文输入法
	"CTRL+ H 退格
"append hotkey hotkye设置在上面添加


"##############global setting全局设置##########################

"pathogen 的设置，pathogen用于管理插件，以后安装插件在bundle目录下就ok.
call pathogen#infect()


set nocompatible
source $VIMRUNTIME/vimrc_example.vim
"注释掉下一行是为了vim的ctrl+v不与windows的冲突。
"source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction



"以下内容全部都由mang添加


"搜索时智能忽略大小写。即如果搜索词全是小写，则忽略大小写，如果有一个大写则大小写敏感
set ignorecase smartcase

" 打开语法高亮
syntax enable

" 配色方案
colorscheme desert

" 字体、字号
set guifont=Courier\ New:h20

"显示行号	
set nu

"不自动换行
set nowrap


"下面5行用来解决gVim菜单栏和右键菜单乱码问题"
set encoding=utf8
set langmenu=zh_CN.UTF-8
set imcmdline
source $VIMRUNTIME/delmenu.vim "不加这句，菜单乱码
source $VIMRUNTIME/menu.vim

" 解决gVim中提示框乱码
language message zh_CN.UTF-8

"当初是用来解决bat乱码问题的，也不知道是否有效。后来发现如果不加上它，打开有中文的文本时显示会乱码
"set fenc=chinese

"也不知道为什么要加它，可还是加上了。fencs：打开文件时猜测编码格式的列表
set fileencodings=utf-8,gb2312,ucs-bom,euc-cn,euc-tw,gb18030,gbk,cp936

" ######### 括号匹配 ######### "

" 设置括号、引号自动完成
:inoremap ( ()<ESC>i

:inoremap ) <c-r>=ClosePair(')')<CR>

"注释掉原因，为了设置Voom的快捷键[1 [2 [3
":inoremap { {}<ESC>i

:inoremap } <c-r>=ClosePair('}')<CR>

:inoremap [ []<ESC>i

:inoremap ] <c-r>=ClosePair(']')<CR>

:inoremap < <><ESC>i
	
:inoremap > <c-r>=ClosePair('>')<CR>

":inoremap " ""<ESC>i

"":inoremap ' ''<ESC>i

:inoremap ` ``<ESC>i

function ClosePair(char)
	if getline('.')[col('.') - 1] == a:char
		return "\<Right>"
	else
		return a:char
	endif
endf

" 窗口启动时自动最大化
au GUIEnter * simalt ~x

"设置自动缩进
set ai!  

"渐近式匹配incremental search 即搜索时 则会自动把光标定位到匹配处"
set incsearch

"不高亮显示搜索到字符"
"set nohlsearch
"按下esc键后取消搜索高亮
nnoremap <esc> : noh<return><esc>

"突出显示当前行
set cursorline 

"设置命令行的行数"
set cmdheight=2 


"显示特殊字符"
"set list

"设置tab键宽度
set tabstop=4

"设置每层缩进数
set shiftwidth=4


"设置 . 可用于选择模式下。即以前你想重复只能一行一行的重复。现在可以一次选中重复。
vnoremap . :normal .<CR>

"vim不产生备份文件，备份文件存放在~/vimtmp 目录下。若是windows系统，则~目录指的是C:\Documents and Settings\用户名
"set backup
"set writebackup
"set backupdir=d:\Program\ Files\vim\vimtmp\
set nobackup

"自动补全之字典补全 Ctrl+X Ctrl+K 
"在dict.txt文件中可以自定义自动补全的单词 如<red> <modify>
set dict=z:\AppData\百度云同步盘\applicationData\vim\dict.txt

" 重新载入_vimrc
:nmap <Leader>s :source $MYVIMRC

" 快速打开_vimrc, 也可使用:tabedit $MYVIMRC
:nmap <Leader>v :e $MYVIMRC<cr>

"快速打开当文件所以路径下的其它文件 来自于Vimtips
"在正常模式下使用 ,e 然后用tab 切换文件。当然可以先输入几个字符再tab可以快速定位到文件.但实际使用时报错，这里先删除该映射
"if has("unix")
"    map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
"else
"    map ,e :e <C-R>=expand("%:p:h") . "\" <CR>
"endif
"因为我已经设置了自动切换到文件当前路径，所以只要输入:e 部分文件名　就可打开当前路径下的其它文件.注意　:e　后面有一空格。
"也可,e <tab>
"打开文件，不过打开的是窗口让你选择 因为这个可以联用TC快速定位目录
map ,e :browse tabnew <cr>


"默认分割窗口的切换需要 Ctrl+w 与其他按键配合使用，下面的配置我觉得更加方便一些：
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"默认隐藏菜单栏和工具栏，可以通过 <F10> 切换显示和隐藏。

" @see http://www.linuxeden.com/html/softuse/20080331/52958.html  

"Toggle Menu and Toolbar
set guioptions-=m
set guioptions-=T
map <silent> <F10> :if &guioptions =~# 'T' <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=m <bar>
    \else <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=m <Bar>
    \endif<CR>

"映射F11为全屏快捷键，需要安装gvimfullscreen_win32.zip才可以
map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR> 

"pentadacty 本色设置　这样以后打开_pentadactyrcy就有语法着色了
au BufRead,BufNewFile _pentadactylrc set filetype=pentadactyl

"# 通用快捷键

"映射快速打开与快速关闭快捷键
map ,w :w<cr>
map ,q :wq<cr>

"映射快速复制、粘贴剪切板的快捷键
map ,p "+p
map ,P "+P
map ,y "+y
map ,x "+y<esc>dd

"来自VimTip--439:-Replace-text-in-highlighted…
"nnoremap n //<CR>
"nnoremap N ??<CR>


"##########,m自定义快捷键整合##########

"设置小键盘数字键1和大键盘1 映射到  跳转到行末
"map <k1> : <esc>$
"map 1 : <esc>$  "由于两个1都设置成快捷键在正常模式下将不能输入数字1

"设置运行批处理文件的快捷键，用在用vimwiki写完log并导出html后快速复制html到相应目录下 c表示copy
"map ,mc	: <esc>:!..\..\copyNext.bat

"设置切换到　mangCExercise_vim目录下。主要是为了使用版本控制的一些命令
"map ,mdc : <esc>: cd E:\CodeSpace\C\mangCExercise_Vim<cr>

"# ,mt 时间系列
"===,mt时间系列===

"* ,mt 设置快速插入当前日期及时间
"P表示把时间插入到当前光标前面,p表示把时间插入到当前光标后面
:nnoremap ,mt "=strftime("%c")<CR>p

"* ,mtt 设置快速插入当前时间的快捷键
" 注意必须是大写的H和M,小写的有问题
:nnoremap ,mtt "=strftime("%H:%M")<CR>p

"# ,mf 文件名系列
"===,mf文件名系列===

"* ,mft 插入文件名不包含路径 
"插入当前文件名 %t是不包含路径 %p包含路径
:map ,mft <esc>O<c-r>=expand("%:t")<CR> 

"* ,mfp 插入文件名包含路径
:map ,mfp <esc>O<c-r>=expand("%:p")<CR> 

"如下设置成缩写的方式 只要输入xfile就被替换成文件名
iab xfile <c-r>=expand("%:t")<CR>
iab xfilep <c-r>=expand("%:p")<CR>


"* ,mfs 快速在sql文件中插入文件名 如prompt BU_CHANGE_STORE_PLAN.sql的字样
:map ,mfs <esc>ggO<CR>prompt<CR>prompt xfile ...<esc>oprompt ==========<esc>

"* ,mff 快速取出路径中文件名
" 常用于从v4的svn日志中提取增量升级包
" 该命令只能提取一行的文件名你需要做成宏就可以批量执行了
map ,mff <esc>$?/<CR>d0xj


"# ,mw 工作常用相关的处理
"===,mw 工作常用相关的处理===

"* ,mwt tms 写日报用 因从evernote中复制过来后需要去掉空行再复制到剪切板
map ,mwt <esc>:g/^$/d<cr><esc>ggVG"+y

"* ,mwd 快速删除当前文件中的debugger;的行
"先跳转到第1行 然后删除含有debugger;行的代码
map ,mwd :<esc>gg:%g/debugger;/d<cr>

"* ,mwLoad 快速格式化装载机派工日志
" java:1338
":%s/-->/\r/g 将--> 换成换行
":g/list/s/:\|),/)\r/g 
" 将冒号: 或者), 替换成 )\r 即)换行
":g/list/,$ normal >>
	" 将包含list的行开始 到最后一行都 右移>> 这里包含list的行就是派工list
	" 注 我本想使用如下的命令 将两个list之间的行右移但报错 所以我换成其它的了
	":g/list/,/list/normal >>
":g/list/s/\s*//g
	" 将包含list行的行首空白删除
":g/^/s/^\s\+/\t/g
	" 将每一行的行前瞻空白换成tab
	" 因为做上面 g/list/,$ normal >> 的命令后所有行都右移了 所以要做这一步操作
" ggdd 删除第一行 因为第一行是空行
" Gdd 删除最后一行 因为最后一行是endlist
map ,mwLoad :<esc>:%s/-->/\r/g<cr>:g/list/s/:\\|),/)\r/g<cr>:g/list/,$ normal >><cr>:g/list/s/\s*//g<cr>:g/^/s/^\s\+/\t/g<cr><esc>ggddGdd


"* ,mwp 在url上快速加上ip 并复制到前切板
map ,mwp :<esc>0ihttp://127.0.0.1:9080/<esc>"+yy

"* ,mw# 快速删除shell中注释信息
"2,$g/^\s*#/d 表示从行2行开始 替换 以\s*#开头的行 并删除 \s表示空白
"*表示重复0次或n次 #就是shell中注释
"将连续的空行替换成单个空行
map ,mw# :2,$g/^\s*#/d<cr>:%s/^\n$//g<esc>

"* ,mwm 快速将vimrc中与,m有关的注释提取出来 
	" 快速提取,md  m 取md之意
" 操作说明
	" 执行vim快捷键 ,md 快速提取注释
	" 将文件名修改为 vim,m-shortcut.md
	" 将文件剪切到vimInWork 则在mweb中就能看到
"命令解释如下
	" 如下命令包含三部分 
		" :%v//d<cr> 找出需要的行 其它行都删除
			"\\| \\表示转义 输出\   反正是\|是表示或的意思 
			"^"\# ,m 表示找出以 "# ,m 这样的行 其中\#是转义
			"^"===,m 表示找出以 ^"===,m 这样的行
			"^"\* ,m 表示找出以 "* ,m 这样的行 其中\*是转义
		" gg0<c-v>Gx 删除每行的第一个字符 这里是"
		" g/^#/normal O 找出行首是#的行前面加一空行 主要是了mweb 
		" 在mweb中# 表示标题 如果不在前面加一空行其不认
		" ggdd 删除行一行
map ,mwm :%v/^"\#\+ ,m\\|^"\* ,m/d<cr><esc>gg0<c-v>Gx:g/^#/normal O<cr>ggdd
"map ,mwm :%v/^"\#\+ ,m\\|^"===,m\\|^"\* ,m/d<cr><esc>gg0<c-v>Gx

"* ,mwmac 快速将虚拟机windows中的路径换成mac下的路径方便你执行shell脚本
"mac 取mac的意思
"注 路径必须是windows中的路径 z:\ 而不是linux中的z:/ 路径
"第一部分 把z:\改成 /User/mang/
"第二部分 将\ 转换成/
map ,mwmac <esc>:%s!z:\\!/Users/mang/!g<cr>:%s!\\!/!g<cr>

"* ,mw\ 快速将\转换成/ 常用于windows中的路径转换中linux中的路径 
" \取\之意
" ! 这里用!代替原来s命令的/
" \\表示转义
map ,mw\ :%s!\\!/!g

"* ,mwl 快速在每行前面加一行号.空格 如1. 
" 使用场景: 常用markdown语法 需要将文字转换成有序列表 
" line('.')是取行号的意思 第2个.是字符串连接的意思 第3部分'. '是.和空格
map ,mwl %s/^/\=line('.').'. '


"* ,mwj 快速转换成json格式
" 2017-02-16
" 使用场景：
	" 整理接口规范时有时需要json样例则可以快速通过如下命令转换成json字符串
" 具体使用
	" 在excel中把列和值都写好一行一个
	" 粘贴到vim中
	" 执行快捷键 ,mwj
" 命令讲解
	" <esc>:g/^$/d<cr> 去掉空行 因为从excel中拷过来时第一行或者最后一行有空行
	" :%s/\t/":"g 将制表符换成":"
	" :%s/^/"/g<cr> 每行前面加一个双引号 "
	" :%s/$/"/g<cr>: 每行最后面加一个双引号 "
	" 1,$-1s/$/,/g<cr> 从第一行到倒数第二行行末加逗号
	" ggO{ 第一行加一个{
	" Go} 最后一行加一个}
map ,mwj <esc>:g/^$/d<cr>
			\:%s/\t/":"/g<cr>
			\:%s/^/"/g<cr>
			\:%s/$/"/g<cr>:
			\1,$-1s/$/,/g<cr>
			\ggO{<esc>
			\Go}<esc>


"* ,mm 将光标快速定位到行的中间
"2015-1-25来自百度
"实际上如果你不是要求很严格的话，可以通过 20<空格>或者20l的方式往后移动光标
map ,mm :exe "norm " . col("$")/2 . "\|" <CR>
"网上说如下方式也是可以的，但我没有试，因为上面的方式已经ok了
":cal cursor(line("."), col("$")/2)

"# ,mg割接使用
"===,mg割接使用===
"自定义宏命令
"因已经,mgd快捷键和该宏命令效果一样 所以就去掉
"let @m='v/^create sequence/d:%s/^create/drop/g:%s/$/;/g'

"## ,mgs 系列 sequence 系列 s取sequence的意思
"* ,mgnn 将sequence导出后的语句处理成select sequence.nextval from dual;的语句
"使用场景一 sequence已经通过dmp导入了 现在需要把sequence增长20次  如 天津港增加sequence(增加20次)-20150729.sql
"使用场景二 割接时需要快速做sequence 从正式库导出 再导入测试库 再把sequence弄大
map ,mgsn :<esc>:v/^create sequence/d:%s/^create sequence/select/g:%s/$/.nextval from dual;/g<cr>

"* ,mgnd 快速将导出的sequence的语句整理成drop sequence的语句
map ,mgsd :<esc> :v/^create sequence/d<cr><esc>:%s/^create/drop/g<cr><esc>:%s/$/;/g<cr>

"* ,mgsc 快速将导出的sequence整理成先drop 再创建 再nextvalue 50次

" 如下是原来的方式现在不用了 因为其复制的next.value是整体复制然后粘贴50次不好看
"ggVG"ay表示先将刚导出的创建sequence语句复制一份 放到a寄存器里
",mgn表示处理成 select nextvalue的语句
"ggVG"by表示把刚才处理成nextvalue的语句复制到b寄存器里
"u表示恢复 到刚开始的文本 因为还要进行下面的处理而且上面处理后的语句也都复制了
",mgd表示处理成drop语句
"G"ap表示把刚才复制到a寄存器的语句粘贴 形成 先drop 再创建的语句
"G50"bp 表示将粘贴第2步复制到寄存器的next语句 粘贴50次 形成先drop 再创建 再nextvaule50次的语句
"map ,mgc ggVG"ay,mgnggVG"byu,mgdG"apG50"bp<cr>

" 新方式 这种方式复制的next.value的语句是按每行复制50次粘贴 再复制第2行
"ggVG"ay表示先将刚导出的创建sequence语句复制一份 放到a寄存器里
",mgn表示处理成 select nextvalue的语句
"<esc>:g/^/normal yy50pj<cr> 表示把上面处理的select
"nextvalue的语句每行复制50次 而且是按顺序的
"ggVG"by 把刚才处理的复制50次之后的sequence 复制到b寄存器
",mgd表示处理成drop语句
"G"ap表示把刚才复制到a寄存器的语句粘贴 形成 先drop 再创建的语句
"G"bp 表示将粘贴第2步复制到寄存器的next语句 形成先drop 再创建 再nextvaule50次的语句
map ,mgsc ggVG"ay,mgsn<esc>:g/^/normal yy50pj<cr>ggVG"byu,mgsdG"apG"bp<cr>

"## ,mgt 系列 table 系列 t取table的意思

"* ,mgt0 快速将导出的建表语句中的comment设置成空
"mgt0 因mg是与割接有关的所以放在mgt下 0表示comment 0
"%v/^comment on /d 把有以comment on开头的行提取出来
"%s/$/ is '';/g 表示在行尾加上 is '';的语句
map ,mgt0 <esc>:%v/^comment on/d<cr>:%s/$/ is '';/g<cr>

"* ,mgta 快速将导出的建表语句中的comment语句取出
"mgta 因与割接有关所以放在mgt下 a表示comment all
"^comment on 表示以comment on开头的行
"^\s * is 表示以空白开头然后是is空格的行 注意is后面必须有空格 因为你有的字段名也是is
"^'; 因为有的行的注释其分成2行了把单引号和;分在下一行了所以要格外注意下
"\|表示或的意思 如果你在命令里直接写写成\|即可 但如果是在这里写配置要写成\\|
map ,mgta <esc>:%v/^comment on \\|^\s*is \\|^';/d<cr>


"* .mgcd 快速将导出的建表语句转换成drop表的语句并且倒序排列(解决有可能出现外键依赖的问题)
map ,mgcd <esc>:%v/^create table/d<cr>:%s/create/drop/<cr>:%s/$/;/g<cr>:g/^/m0<cr>


"# ,m自定义函数

"* ,m-CopyMatches
function! CopyMatches(reg)
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/ge
  let reg = empty(a:reg) ? '+' : a:reg
  execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register CopyMatches call CopyMatches(<q-reg>)

"* ,m-KeepLines
function! KeepLines(pattern)
    let pattern = a:pattern
    let hits = []
    exec '%s/' . pattern . '/\=add(hits, submatch(0))/ge'
    let str = join(hits, "\n") . "\n"
    %d
    put! = str
endfunction
command! -nargs=1 KeepLines call KeepLines(<f-args>)

"###############Vimwiki相关设置  ########################
"以下内容加于2011年8月11日18时40分54秒

"安装官方文档的要求，需要确保 vimrc 文件中有如下的设置 也不知道为什么
set nocompatible
filetype plugin on "针对不同文件类型的相应plugin, 你可以使用该命令开启对它的应用
syntax on

let $VIMHOME = 'z:\AppData\百度云同步盘\wiki\'
"设置wiki路径
let g:vimwiki_list = [
	\{
		\'path': $VIMHOME.'/wiki1',
		\ 'path_html':$VIMHOME.'/wiki1/html/',
 		\ 'template_path': '$VIMHOME/templates/',
        \ 'template_default': 'default',
        \ 'template_ext': '.html',	
		\ 'index': 'main',
		\'syntax': 'default',
		\ 'nested_syntaxes': {'C': 'c'},
	\},
	\{
		\ 'path': $VIMHOME.'/wikitest',
		\ 'path_html': $VIMHOME.'/wikitest/html/',
 		\ 'template_path': '$VIMHOME/templates/',
        \ 'template_default': 'default',
        \ 'template_ext': '.html',	
		\ 'index': 'main',
		\ 'nested_syntaxes': {'C': 'c'},
	\},
	\{
		\'path': $VIMHOME.'/work',
		\ 'path_html':$VIMHOME.'/work/html/',
 		\ 'template_path': '$VIMHOME/templates/',
        \ 'template_default': 'default',
        \ 'template_ext': '.html',	
		\ 'index': 'main',
		\'syntax': 'default',
		\ 'nested_syntaxes': {'C': 'c'},
	\},
	\{
		\'path': $VIMHOME.'/linuxwiki',
		\ 'path_html':$VIMHOME.'/linuxwiki/html/',
 		\ 'template_path': '$VIMHOME/templates/',
        \ 'template_default': 'default',
        \ 'template_ext': '.html',	
		\ 'index': 'main',
		\'syntax': 'default',
		\ 'nested_syntaxes': {'C': 'c'},
	\},
	\{
		\'path': $VIMHOME.'/ithink',
		\ 'path_html':$VIMHOME.'/ithink/html/',
 		\ 'template_path': '$VIMHOME/templates/',
        \ 'template_default': 'HaveNoHead',
        \ 'template_ext': '.html',	
		\ 'index': 'ithink',
		\'syntax': 'default',
		\ 'nested_syntaxes': {'C': 'c'},
	\},
	\{
		\'path': $VIMHOME.'/blog/mankou/wiki',
		\ 'path_html':$VIMHOME.'/blog/mankou/_posts/',
 		\ 'template_path': '$VIMHOME/templates/',
        \ 'template_default': 'HaveNoHead',
        \ 'template_ext': '.html',	
		\ 'index': 'mankoublog',
		\'syntax': 'default',
		\ 'nested_syntaxes': {'C': 'c'},
	\},
\]
"设置vimwiki各标题的颜色，标题1-标题6分别是红绿蓝粉青黄，注意这是在vim中显示的颜色，不是在网页中显示的颜色。
"配置颜色的目的：是为了配合Voom。我以前为Voom自定义了个配色的配置文件在$Vimhome/vimfiles/syntax/Voomtxt.wiki {现在安装了pathegon插件，所以该文件路径为$Vimhome/vimfiles/bundle/Voom/syntax 如果没有syntax目录的话，自己新建} 那里曾经也为vimwiki配置过颜色（vimwiki默认的配色不是这个样子），使用时需要每次输入命令 set ft=Voomtxt，才能看到配色的效果，使用起来比较麻烦。但我也不想把voomtxt关于vimwiki的配色设置删除掉，为了保护自己的劳动成果，所以在vimwiki下也设置了与那里相同的颜色。即本来使用的是Vimwiki默认的配色方案，但后来在Voomtxt.wiki中为wimwiki配置了颜色，但使用voomtxt又不是很方便，所以为了延续voomtxt的配色方案，这里把vimwiki的配色方案设置成与voomtxt一样的配色方案。
:hi VimwikiHeader1 guifg=#FF0000
:hi VimwikiHeader2 guifg=#00FF00
:hi VimwikiHeader3 guifg=#0000FF
:hi VimwikiHeader4 guifg=#FF00FF
:hi VimwikiHeader5 guifg=#00FFFF
:hi VimwikiHeader6 guifg=#FFFF00


"设置在vimwiki中可以使用的html标签
let g:vimwiki_valid_html_tags='b,i,s,u,small,sub,sup,kbd,br,hr,div,del,code,red,green,modify,center,left,right,h4,h5,h6,a,small,pre,ol'

"设置默认打开html的浏览器。当用命令\whh 时会自动将当前wiki转换成html，并用浏览器打开html
let g:vimwiki_browsers=['D:\Program Files\Mozilla Firefox\firefox.exe']
" 使用鼠标映射  
let g:vimwiki_use_mouse = 1


" 是否将驼峰式词组作为 Wiki 词条 1是 0否 默认是1
let g:vimwiki_camel_case = 0

" 标记为完成的 checkist 项目会有特别的颜色 
let g:vimwiki_hl_cb_checked = 1 

" F4当前页生成HTML，Shift+F4 全部页生成HTML 
map <S-F4> :VimwikiAll2HTML<cr> 
map <F4> :Vimwiki2HTML<cr> 

"设置切换任务列表的快捷键
map <leader>tt <Plug>VimwikiToggleListItem

" 加一个 vimwiki 菜单项
let g:vimwiki_menu = 'Vimwiki' 

" 是否开启按语法折叠 会让文件比较慢 
let g:vimwiki_folding = 1 

"启用子列表项折叠功能，现在也没看出来有什么效果
let g:vimwiki_fold_lists = 1

"输出的html是否自动编号。 默认为0。 0 关闭, 1 从一级标题开始 ,2 从二级标题开始
"依次类推
let g:vimwiki_html_header_numbering =1

"在一个没有复选框的列表项目上按下\tt(自己设置的热键)则可以创建列表框。默认是1
let g:vimwiki_auto_checkbox = 1

"使用预先定义的颜色高亮不同级别的标题 =Reddish=, ==Greenish==, ===Blueish===
let g:vimwiki_hl_headers = 1

"自动格式化表格
let g:vimwiki_table_auto_fmt = 1

"设置vimwiki下查找的快捷键 s代表search
map ,ms : <esc>:VimwikiSearch

"设置vimwiki查找后浏览的快捷键 如mn代表显示下一个匹配项 mp代表显示前一个匹配项 lm代表显示所有匹配项.原来设置的是ln lp lo　后来发现l是光标向右移动的键，所以又改成m了
map ,mn : <esc>:lnext <Return>
map ,mp : <esc>:lprevious <Return>
map ,mo : <esc>:lopen <Return>

"append vimwiki vimwiki 设置在上面添加


" ########calender的设置##################
" create:2011年10月24日


"设置日记路径的，但是不灵，可能是因为vimwiki的原因
"let g:calendar_diary = "E:/diary"

"定义热键，快速调出Calendar插件
map ca :Calendar<cr>

"以星期一为开始 
let g:calendar_monday = 1

"使*在数字左面.如果想在右面，则right
let g:calendar_mark = 'left' 

"可以让*与数字靠的更近一些
let g:calendar_mark = 'left-fit'

"显示第几周　每年1月1日为第一周
let g:calendar_weeknm = 1 " WK01
"append calendar calendar设置在上面添加

"############Voom的设置################
"create:2011年12月19日

"设置Tree区的宽度
let g:voom_tree_width=20

"设置为vimwiki快速出现Voom界面的快捷键,一个是vimwiki的 一个是一般的
map <LocalLeader><LocalLeader>w :Voom vimwiki<CR>
nnoremap <LocalLeader><LocalLeader> :Voom<CR>

"设置返回键，默认是<Return>键，即回车键，但在vimwiki下会冲突，所以调成了这个。
let g:voom_return_key = '<C-Return>'

"设置调转键，可以Tree区与body区来回跳，默认是<Tab>键，由于vimwiki的原因，这里设置了<C-Tab>
let g:voom_tab_key = '<C-Tab>'

"设置添加标题的快捷键
imap \[1 <esc>$a {{{1
map \[1 <esc>$a {{{1
imap \[2 <esc>$a {{{2
map \[2 <esc>$a {{{2
imap \[3 <esc>$a {{{3
map \[3 <esc>$a {{{3

"删除{{{1 {{{2 {{{3 的快捷键 2015-7-21决定去掉因为}是vim原生的快捷键
"跳转到下一个空白行
"map }  <esc>:s/{{{\d//g <CR>


 "配置标题颜色，该配置文件路径为：$vimhome/vimfiles/syntax/Voomtxt.vim 这里的标题是指vimwiki中的标题以及Voom中的标
 "该命令并非Voom中的命令，是全局的命令，但设置的效果是为了Voom的
 "该设置对于直接打开vimwiki的情况并不起作用，需要再在命令行中输入 :set ft=Voomtxt  才会看到着色效果。当然这并不影响实际使用。但对于只打开gvim的但不打开vimwiki的情况却是有效的，你输入 =1  1是会着色的。
set ft=Voomtxt

"设置全屏的快捷键
 "须光标在编辑区时方可正确使用，因为\\会在编辑区与tree区切换，如果当前在tree区，则执行下方快捷键的结果是关掉编辑区。
map \f <esc><LocalLeader><LocalLeader>:q<return> 


"append Voom  Voom设置在上面添加

"############Taglist的设置################
"由于Taglist以ctags为基础，所以下面会有些关于ctags的设置
"create:2012年5月16日

"映射自动生成tags文件的快捷键
"@see http://blog.csdn.net/bokee/article/details/6633193
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR> 

"这项也不知道什么意思，网上说的，也就这样设了。
set tags=tags;
"自动切换目录到当前编辑的文件所在路径
set autochdir

"设置ctags.exe的路径，当然也可直接加到系统的环境变量中，这里就不再设置了。本来想设置在vim相关目录下，但因为program有空格没有成功，所以就另设了一个没有空格的路径。
"注意下方路径是/ 而不是\ windows路径分隔符用\表示。或要用\则应该用两个\ 即\\
"let Tlist_Ctags_Cmd ="D:/Program\ Files/Vim/vimfiles/bundle/ctags/ctags.exe"
let Tlist_Ctags_Cmd ="E:/ApplicationData/netDisk/klive/application/ctags/ctags.exe"

"不同时显示多个文件的tag，只显示当前文件的
let Tlist_Show_One_File = 1

"如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Exit_OnlyWindow = 1

"打开vim时自动打开Tlist窗口，但这与打开文件类型有关.如：如果打开的是cpp文件，则自动打开Tlist 如果打开txt文件，则不会自动打开。因为有了WinManager插件，如果自动启动Tlist窗口，再输入wm 则会程三栏，所以这里就关闭了
"let Tlist_Auto_Open = 1

"映射打开Tlist窗口的快捷键
nnoremap <silent>  tg :TlistToggle<CR>

"设置Tlist窗口大小
let Tlist_WinWidth = 10


"append Taglist 设置在上面添加

"##########winManager 设置####################

"通过WinManager插件来将TagList窗口和netrw窗口整合起来
let g:winManagerWindowLayout='FileExplorer|TagList'

"映射wm的快捷键
nmap ,wm :WMToggle<cr>

"当右边窗口关窗时，自动关闭wm窗口
let g:persistentBehaviour=0

"设置wm窗口宽度
let g:winManagerWidth=10


"append winmanager 设置在上面添加




"##########program 编译、运行程序设置#############
"因quickfix与程序编译、运行密切相关，所以下面也有quickfix的配置
"create 09:59 2012-5-17


"下面这段代码来自于网上　VIM-一键编译单个源文件　http://www.vimer.cn/2009/10/11.html。当按下快捷键时会编译程序并打开错误窗口。有两个一个是编译单个文件　一个是编译多个文件。
 "iswindows是定义的一个全局变量　用于判断系统是linux还是windows
if(has("win32") || has("win95") || has("win64") || has("win16"))
    let g:iswindows=1
else
    let g:iswindows=0
endif

 "单个文件编译,如果有错显示出错窗口。如果没错直接运行。
 "2012年5月18日修改过一次 在gcc后面的参数上加了个-Wall 否则一出错不能显示错误在哪一行。
map <F5> :call Do_OneFileMake()<CR>
function Do_OneFileMake()
    if expand("%:p:h")!=getcwd()
        echohl WarningMsg | echo "Fail to make! This file is not in the current dir! Press <F7> to redirect to the dir of this file." | echohl None
        return
    endif
    let sourcefileename=expand("%:t")
    if (sourcefileename=="" || (&filetype!="cpp" && &filetype!="c"))
        echohl WarningMsg | echo "Fail to make! Please select the right file!" | echohl None
        return
    endif
    let deletedspacefilename=substitute(sourcefileename,' ','','g')
    if strlen(deletedspacefilename)!=strlen(sourcefileename)
        echohl WarningMsg | echo "Fail to make! Please delete the spaces in the filename!" | echohl None
        return
    endif
    if &filetype=="c"
        if g:iswindows==1
            set makeprg=gcc\ -Wall\ -o\ %<.exe\ %
        else
            set makeprg=gcc\ Wall\ -o\ %<\ %
        endif
    elseif &filetype=="cpp"
        if g:iswindows==1
            set makeprg=g++\ -Wall\ -o\ %<.exe\ %
        else
            set makeprg=g++\ -Wall\ -o\ %<\ %
        endif
        "elseif &filetype=="cs"
        "set makeprg=csc\ \/nologo\ \/out:%<.exe\ %
    endif
    if(g:iswindows==1)
        let outfilename=substitute(sourcefileename,'\(\.[^.]*\)' ,'.exe','g')
        let toexename=outfilename
    else
        let outfilename=substitute(sourcefileename,'\(\.[^.]*\)' ,'','g')
        let toexename=outfilename
    endif
    if filereadable(outfilename)
        if(g:iswindows==1)
            let outdeletedsuccess=delete(getcwd()."\\".outfilename)
        else
            let outdeletedsuccess=delete("./".outfilename)
        endif
        if(outdeletedsuccess!=0)
            set makeprg=make
            echohl WarningMsg | echo "Fail to make! I cannot delete the ".outfilename | echohl None
            return
        endif
    endif
    execute "silent make"
    set makeprg=make
    execute "normal :"
    if filereadable(outfilename)
        if(g:iswindows==1)
            execute "!".toexename
        else
            execute "!./".toexename
        endif
    endif
    execute "copen 5"
endfunction

"使用make编译。注意只编译不运行。有两种运行模式。
"下面的一条语句是以前用的,执行完make后会把结果输出到quickfix窗口。但因窗口太小看起来不爽，况且有c.vim的 ,rm 命令执行make。所以这个命令用的不多。而且c.vim的 ,rm命令用的也不爽。现在我不想那么做了，想直接查看make执行命令后的窗口，所以把下面的那句话注释了。改成直接调用外部程序
"map <F6> :call Do_make()<CR>
map <F6> :!make<CR>

"执行make clean
map <c-F6> :!make clean<CR>
"这是以前的用于执行make clean的代码，现在用着不爽了，所以换成直接用在命令行输的命令
"map <c-F6> :silent make clean<CR>
"function Do_make()
"    set makeprg=make
"    execute "silent make"
"    execute "copen 5"
"endfunction

"映射快速编译的快捷键,注意只编译不运行程序。<F5>不但编译还运行，这里只编译。废弃，因为用c插件，现在在用那里的快捷键
"autocmd FileType c,cpp  map <buffer> <leader><space> :w<cr>:silent make<cr>:copen 5<cr>

"映射快速运行当前目录下main.exe的快捷键
nmap <leader><space> :!.\main.exe<cr>

"映射　打开关闭quickfix窗口　的快捷键
nmap <leader>cw   :cw 5<cr>
nmap <leader>cc   :ccl<cr>


"把Cscope的查找结果输出到quickfix窗口
"@see http://blog.csdn.net/bokee/article/details/6633193 
set cscopequickfix=s-,c-,d-,i-,t-,e-

"映射下一个和前一个错误的快捷键
nmap <F7> :cp<cr>
nmap <F8> :cn<cr>
"映射退出quickfix窗口的快捷键
"因为q与录制宏快捷键冲突，所以这里注意掉。可通过<leader>cc关闭quickfix
"nmap q :close<cr>


"映射debug的快捷键
map <C-F5> :call Debug()<CR>
"定义Debug函数，用来调试程序
func Debug()
exec "w"
"C程序
if &filetype == 'c'
exec "!gcc % -g -o %<.exe"
exec "!gdb %<.exe"
elseif &filetype == 'cpp'
exec "!gcc % -g -o %<.exe"
exec "!gdb %<.exe"
"Java程序
elseif &filetype == 'java'
exec "!javac %"
exec "!jdb %<"
endif
endfunc
"结束定义Debug

"设置makeprg
"下面的设置基本没用，只是把以前出现的问题想保存下来而已。
"在使用:make时，vim会自动调用’makeprg‘选项定义的命令进行编译，并把编译输出重定向到一个临时文件中，当编译出现错误时，vim会从上述临时文件中读出错误信息
"set makeprg=make;
"下面这个设置makeprg的方法不行，估计是路径空格问题。
"set makeprg="D:/Program Files/MinGW/msys/1.0/bin/make.exe"
"下面方法来自于vi/vim使用进阶: 剑不离手 quickfix　是可以用的，但只是个小测试
"set makeprg=gcc\ -Wall\ -omain\ main.c"

"append program设置在上面添加
"###############MiniBufExplorer 设置###############

"当按下<C-Tab>或<C-S-Tab>光标不但会在各buffer间切换，而且会在当前窗口打开。在用Taglist时不好用，用wimwiki时好用。
let g:miniBufExplMapCTabSwitchBufs = 1
"可以使用<C-箭头>激活窗口,由于bufexplorer中映射了<C-right>与<C-left>与这里冲突，所以这里注释掉。
"let g:miniBufExplMapWindowNavArrows = 1

"使用minnibuf后 要按好几下q才能关闭窗口。这里映射个一次关闭窗口的快捷键。:CMinibBufExplorerii是关闭minibuf的命令
noremap Q :CMiniBufExplorer<CR>:q<CR>

"映射一个切换minibufexplorer的快捷键
noremap tm :TMiniBufExplorer<CR>  

"设置成0代表总是显示buf窗口，1表示当有一个文件时显示buf,2表示当有两个文件时才显示buf.依次类推.从其字面意思就能看出来morethanone3表示大于3时才有buf
let g:miniBufExplorerMoreThanOne=3

"append MiniBufExplorer设置在上面添加
"##########bufexplorer设置########

"主要是配合bufexplorer使用，因为buferxplorer新打开文件时会新划分出一个窗口。这里映射一个快速关闭另一个窗口的快捷键.当只有一个窗口，且已保存，且已关闭Minibufexplorer时可以关闭当前窗口。
:nmap <C-right> :<esc><C-l>:q<cr>
:nmap <C-left> :<esc><C-h>:q<cr>


"append bufexplorer设置在上面添加


"##############nerdtree的设置##########

"映射打开、关闭NERDTree窗口的快键键
nmap <F3> :NERDTree  <CR>
"where NERD tree window is placed on the screen
let NERDTreeWinPos = "left"
"设置NERDTree窗口的大
let NERDTreeWinSize = 10 "size of the NERD tree

"下面配置用于使winmanager将nerdtree 与taglist联合使用。具体的配置看不太懂。
"@see http://blog.csdn.net/bokee/article/details/6633193
	let g:NERDTree_title="[NERDTree]" 
	let g:winManagerWindowLayout="NERDTree|TagList"
	function! NERDTree_Start()  
    	exec 'NERDTree'  
	endfunction  
  
	function! NERDTree_IsValid()  
    	return 1  
	endfunction  
	nmap ,wm :WMToggle<CR>  

"append nerdtree的设置在上面添加#########

"###############project设置###############
"映射打开project窗口的快捷键
nmap <silent> <Leader>P <Plug>ToggleProject

"append project　的设置在上面添加

"###########c.vim 设置###############
"设置c.vim的<leader>键，因为用\不方便.该设置只对文件类型是c cpp的有效。
let g:C_MapLeader  = ','

"append c.vim 的设置在上面添加

"###########SuperTab 设置#################
"下面几行是关于自动补全的设置，与SuperTab无关
"缺省的，vim会使用下拉菜单和一个preview窗口(预览窗口)来显示匹配项目，下拉菜单列出所有匹配的项目，预览窗口则显示选中项目的详细信息。打开预览窗口会导致下拉菜单抖动，因此我一般都去掉预览窗口的显示，这需要改变’completeopt‘的值
set completeopt=longest,menu

"以下是supertab的设置
"设置supertab的补全类型
let g:SuperTabDefaultCompletionType = "context"

"append supertab　的设置在上面添加

"#################git-vim设置##################
"下面有些快捷键已经是由该插件默认的了，这里为了统一起见再定义一遍。

"务必阅读《wiz--git-vim插件的使用》中关于　使用时的诸多规范或限制　因为有些映射是有前提的
map <leader>gs :GitStatus<cr>
map <leader>gc :GitCommit<cr>
map <leader>ga :GitAdd<cr>
"自动提交的命令 gca取gc
"auto之意.因为目前提交时跳出的窗口必须手动关掉。有些麻烦，况且有时并不需要输入有用信息。如提交博客
map <leader>gca :!git commit -a -m "%date%"<cr>
map <leader>go  <leader>gca<leader>gpo

"注意如果只写GitPush 则默认的命令是　GitPush origin master
"如果远程仓库的名字不是origin则会出错，所以最好一开始就把远程仓库的名字配置是origin 即时当前分支不是master，也会push master分支. 本来想用\gp的，但发现映射后并不灵 而是指向了pull命令，可能与gitvim插件冲突了。所以这里设置成\gpo  因为oringin 所以用o
map <leader>gpo :GitPush<cr>

"相当于命令git push --all 即把本地所有分支都push到远程
map <leader>gpa :GitPush --all<cr>


"这个是我映射的，因为GitLog用的多，所以用小写，这里就用大写。
map <leader>gL :GitPull<cr>


map <leader>gl :GitLog<cr>
"映射统计提交信息的快捷键
map <leader>gls :GitLog --shortstat --pretty=format:"%ci %cr %an"<cr>

"因为Git用的多,所以这里映射个快捷键
map ,g :Git 
"#################git-vim设置在上面##################


"#################vimim设置在下面##################

"设定循环次序,若为-1则表示彻底关闭循环
let g:vimim_toggle='wubi,pinyin'
"let g:vimim_toggle='-1'

"不知道含义，是在一个网站上看到要这样设置的
"let g:vimim_wubi='jd'

"输入模式动态表示：每打一个字就显示选项。静态表示：打完空格才显示选项，默认是动态。
let g:vimim_mode = 'dynamic'
"let g:vimim_mode = 'static'

"开关输入法快捷键
let g:vimim_map='c-bslash'

" 彻底关闭云输入，五笔使用者可选
"let g:vimim_cloud=-1 

"#################vimim设置在上面##################

"####################latex设置在下面###################
"我也不理解这些设置，这些设置是从官网上摘来的

" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'


"来自于水木社区http://ar.newsmth.net/thread-3983d146501c3c.html
"目的是快速编译成pdf文件。因为默认生成dvi文件，如果要生成pdf文件需使用命令 :TTarget pdf 然后再使用\ll会生成pdf. 这里可通过 \lp 设置成默认pdf并生成pdf 以后用\ll也会生成pdf，方便些。
let g:Tex_FormatDependency_pdfs = 'dvi,ps,pdf'
let g:Tex_FormatDependency_pdfm = 'dvi,pdf'
let g:Tex_CompileRule_pdfs = 'ps2pdf $*.ps'
let g:Tex_CompileRule_pdfm = 'dvipdfm $*.dvi' 
map \lp <esc>:TCTarget pdfm<cr>\ll

"####################latex设置在上面###################

"该语法文件启用自18:55 2012-8-7 来自于善用佳软 
"使用方法：因为目前vimrc中设置了Voomtxt为默认语法文件，所以要使用该语法文件只能通过命令set ft=ztxt 设置。
 "如果嫌每次打开都要输入麻烦，可在文件第一行或者最后一行加上 vim: set ft=ztxt
 "以后有时间会把这两个语法文件融合成自己的，目前配色还有些冲突。
"相关网址
 "yntax for txt: 与neman兄共探讨 http://www.newsmth.net/bbscon.php?bid=731&id=11469
 "[讨论]txt的*标题：高亮并折叠 http://www.newsmth.net/bbscon.php?bid=731&id=21943

" ztxt.vim for text file
" by neman, xbeta @ www.newsmth.net
" 2005年9月2日
" http://www.newsmth.net/bbsdoc.php?board=VIM
"Last Change: 2005 Aug 9 or see file date
syn match zhead "^*.\+"
hi zhead guifg=green gui=bold

set fdm=expr
set foldexpr=Myindent(v:lnum)
func! Myindent(lnum)
    let s:a=strlen(matchstr(getline(v:lnum),'^\*\+'))
    if s:a == 2
        return '>2'
    elseif s:a == 1
        return '>1'
    else
        return '='
    endif
endf

"set foldcolumn=4
"	set lsp=5

"color ****************************************

" 语句的位置很重要，曾经把TxtUrl放在后面，结果不太对。
syn case ignore	
syn keyword   TxtOrg     sap erp cnooc cnoocltd ibm oracle zyx zhangyx yxz ey q31 tsinghua tsu "把一些组织名称高亮
"syn match     TxtBrac        "[  () \[\] ]" "if  include {}, the fold will error
"syn match     TxtSpecial     "[ ^ ~ ' \- \+ % * \/ ]"
"syn match     TxtChinese     "[ ，；。、…—＆×＋—：　？！（）《》￥※『』‘’“”]"
syn match       TxtNum   "\d"
" "\d\+\S\?\d\+\S\?\d\+" 
" -\=\<\d*\.\=[0-9_]\>" "TxtNumber
syn match	  TxtEn			 "[a-zA-Z]"
"syn region    TxtString     start=+L\="+ skip=+\\\\\|\\"+ end=+"+

syn match     br1         "(.\{-})"
	syn match     br2        "（.\{-}）"
	syn match     br3         "\[.\{-}\]"
	syn region    br4     start=/“/  end=/”\|$/
"	syn region    br5     start=/"/  end=/"\|$/
	syn match	  br6	"《.*》"
	syn match	zday "\d\+年\|\d\+月\|\d\+日"
hi br1 guifg=lightblue
	hi link br2 br1
	hi link br3 br1 "guifg=lightblue
	hi link br4 br1
	hi link br5 br1
	hi link br6 br1
	syn match     TxtUrl1         "http[s]\=://\S*"
	syn match     TxtUrl2         "mms\=://\S*"
	syn match     TxtUrl3         "ftp\=://\S*"
	syn match     TxtUrl4        "file\=://\S*"
	syn match     TxtUrl5        "\S*@\S*"
syn region 	  zHead1  		start=/^\s*::/ end=/$/ " ::，表示标题。前面可以有空格、tab
syn region	  zHead2			start=/^\s*\d\{1,2}\./ end=/$/ " 1-2位数跟小数点，表示标题。前面可以有空格、tab


"syn match     TxtComment     "^#.*$"  contains=TxtUrl1,TxtUrl5,TxtUrl4,TxtUrl3,TxtUrl2,TxtString
"syn match     TxtVIPLine     "^__.*$" contains=TxtUrl1,TxtUrl5,TxtUrl4,TxtUrl3,TxtUrl2,TxtString

"hi link       TxtOrg     Special    "cyan
hi TxtOrg guifg=green  guibg=blue "gui=underline
hi link       TxtBrac        Identifier "palegreen
hi link       TxtSpecial     Constant   "gold
hi link       TxtChinese     Repeat     "
"hi link 	  TxtEn			 Normal
"hi link       TxtNum      Constant   "gold
hi TxtNum guifg=#ffa0a0 guibg=grey20
hi link       TxtString      String     "lightred
	hi link       TxtUrl1		Underlined    
	hi link       TxtUrl2		Underlined    "
	hi link       TxtUrl3		Underlined       "green
	hi link       TxtUrl4		Underlined       "green
	hi link       TxtUrl5		Underlined    "cyan
hi link       zHead1        Type       "green
hi link		  zHead2			 Type
hi link       TxtComment     Comment    "gold
hi link       TxtVIPLine     cComment   "skyblue
hi link       TxtVIPWord     cComment   "skyblue

hi zHead1 guifg=green gui=underline guibg=blue
hi zHead2 guifg=green gui=underline guibg=blue
hi tst guifg=green gui=underline guibg=blue
hi TxtEn guifg=lightgreen
hi zday  guifg=green


"折叠设置 
 "*为一级标题
 "**为二级标题
"下面注释掉几行是从 http://www.newsmth.net/bbscon.php?bid=731&id=11469 下载的语法文件的原始内容，添加的内容是从 http://www.newsmth.net/bbscon.php?bid=731&id=21943 贴出来的内容。都是一个作者修改的。这里保留原有内容，供以后学习。
" fold**************************************** 
" syn sync fromstart
"	set foldmethod=syntax
"	syn region myFold start="{" end="}" transparent fold
"let b:current_syntax = "ztxt"


syn match zhead "^*.\+"
hi zhead guifg=green gui=bold

set fdm=expr
set foldexpr=Myindent(v:lnum)
func! Myindent(lnum)
    let s:a=strlen(matchstr(getline(v:lnum),'^\*\+'))
    if s:a == 2
        return '>2'
    elseif s:a == 1
        return '>1'
    else
        return '='
    endif
endf

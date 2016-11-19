"以下语句用于Voom插件，给标题行着色 标题1-标题3分别着色为红绿蓝但{{{1 {{{2 {{{3不着色。着色只对Voom默认的标题行有效，即{{{\d 形式的标题行。对于其它形式的标题行并不起作用。虽然在.vimrc中加了 set ft=Voomtxt 但对于打开的已经有的文件并没有着色效果，需要自己再输命令，但对于新建的文件直接有颜色效果。
"该文件在windows上必须放在以下路径内 $Vimhome/vimfiles/syntax linux上没有试过
"需在 .vimrc中设置 set ft=Voomtxt 才有效
"该配置参考自http://xbeta.info/vim-voof.htm
syn match zkey "{{{1" contained
syn match zhead1 "^.\+{{{1" contains=zkey
hi zhead1 gui=bold guifg=red guibg=black

syn match zkey "{{{2" contained
syn match zhead2 "^.\+{{{2" contains=zkey
hi zhead2 gui=bold guifg=green guibg=black

syn match zkey "{{{3" contained
syn match zhead3 "^.\+{{{3" contains=zkey
hi zhead3 gui=bold guifg=blue guibg=black

"以下语句本来是用于给vimwiki的Voom着色的，其实没有用处，vimwiki本来的着色就很好了，你没必要再着色了，这里只是为了保护自己的劳动成果。虽然在.vimrc中设置了 set ft=Voomtxt 但对于以前就有的文件还是不能着色的，需要自己输入命令才会看到着色效果。目前还未解决该问题
"需在 .vimrc中设置 set ft=Voomtxt 才有效
"该配置参考自http://xbeta.info/vim-voof.htm
"原理：vim
"syntax语法我看不懂，都是从参考中直接抄来的，我改了下正则表达式。\{1\}表示前面的字符至少出现一次，由于{}是特殊字符所以要转义。+表示前面的字符至少出现一次，也要转义。这里出现2次的着色会把出现一次的着色给覆盖掉，所以各标题行着色不一。
"标题1-标题6着色分别为红绿蓝粉青黄
syn match zkey "=" contained
syn match zhead1 "=\{1\}.\+=" contains=zkey
hi zhead1 gui=bold guifg=#FF0000 guibg=black
syn match zkey "=" contained
syn match zhead2 "=\{2\}.\+=" contains=zkey
hi zhead2 gui=bold guifg=#00FF00 guibg=black
syn match zkey "=" contained
syn match zhead3 "=\{3\}.\+=" contains=zkey
hi zhead3 gui=bold guifg=#0000FF guibg=black
syn match zkey "=" contained
syn match zhead4 "=\{4\}.\+=" contains=zkey
hi zhead4 gui=bold guifg=#FF00FF guibg=black
syn match zkey "=" contained
syn match zhead5 "=\{5\}.\+=" contains=zkey
hi zhead5 gui=bold guifg=#00FFFF guibg=black
syn match zkey "=" contained
syn match zhead6 "=\{6\}.\+=" contains=zkey
hi zhead6 gui=bold guifg=#FFFF00 guibg=black



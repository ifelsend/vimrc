set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
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

"打开行号
set nu!
set wrap "自动折行
set cursorline "突出显示当前行

set shiftwidth=4 " 设定 << 和 >> 命令移动时的宽度为 4
set softtabstop=4 " 使得按退格键时可以一次删掉 4 个空格
set tabstop=4 " 设定 tab 长度为 4
set expandtab "不允许在代码使用TAB符，而以4个空格代之
set nobackup " 覆盖文件时不备份
set autochdir " 自动切换当前目录为当前文件所在的目录

filetype plugin indent on " 开启插件
"set backupcopy=yes " 设置备份时的行为为覆盖
set ignorecase smartcase " 搜索时忽略大小写，但在有一个或以上大写字母时仍保持对大小写敏感
set nowrapscan " 禁止在搜索到文件两端时重新搜索
set incsearch " 输入搜索内容时就显示搜索结果
set hlsearch " 搜索时高亮显示被找到的文本
set noerrorbells " 关闭错误信息响铃
set novisualbell " 关闭使用可视响铃代替呼叫
set t_vb= " 置空错误铃声的终端代码
" set showmatch " 插入括号时，短暂地跳转到匹配的对应括号
" set matchtime=2 " 短暂跳转到匹配括号的时间
set magic " 设置魔术
set hidden " 允许在有未保存的修改时切换缓冲区，此时的修改由 vim 负责保存
set guioptions-=T " 隐藏工具栏
set guioptions-=m " 隐藏菜单栏
set smartindent " 开启新行时使用智能自动缩进
set backspace=indent,eol,start " 不设定在插入状态无法用退格键和 Delete 键删除回车符
set cmdheight=1 " 设定命令行的行数为 1
set showcmd "在命令行显示当前输入的命令

"--------------------------------------------------------------------------
"状态栏相关的设置[包括文件路径、文件类型、坐标、所占比例、时间等]
"--------------------------------------------------------------------------
"set statusline=\%<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\ " 设置在状态行显示的信息
"set statusline=\%F%m%r%h%w [%{(&fenc=="")?&enc:&fenc}%{(&bomb?",BOM":"")}] %y%r%m%*%= [%l,%v] [%p%%] [共%L行] %{strftime("%d/%m/%y - %H:%M")} \
set statusline=%2*%n%m%r%h%w%*\%F\%1*[FORMAT=%2*%{&ff}:%{&fenc!=''?&fenc:&enc}%1*]\ [TYPE=%2*%Y%1*]\ [COL=%2*%03v%1*]\ [ROW=%2*%03l%1*/%3*%L(%p%%)%1*]
"set statusline=%2*%n%m%r%h%w%*\%F\%1*[FORMAT=%2*%{&ff}:%{&fenc!=''?&fenc:&enc}%1*]\ [TYPE=%2*%Y%1*]\ [COL=%2*%03v%1*]\ [ROW=%2*%03l%1*/%3*%L(%p%%)%1*]\ [DATE=%2*%{strftime(\"%c\",getftime(expand(\"%%\")))}%1*]   
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2 " 总是显示状态行 显示状态栏 (默认值为 1, 无法显示状态栏)
set ruler " 在编辑过程中，在右下角显示光标位置的状态行

function! InsertStatuslineColor(mode)
if a:mode =='i'
    hi statusline guibg=red
elseif a:mode =='r'
    hi statusline guibg=blue
else
    hi statusline guibg=black
endif
endfunction
 
au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi statusline guibg=orange guifg=white
hi statusline guibg=black
 
hi User1 guifg=gray
hi User2 guifg=red
hi User3 guifg=white

set filetype=php

set foldenable " 开始折叠
"set foldmethod=syntax " 设置语法折叠
"set foldmethod=indent " 设置缩进折叠
set foldmethod=manual " 设置手工折叠
""""""""""""
"折叠命令
"zf 折叠当前行，或选中的文本
"zfa{[(<
"zo zd zD
""""""""
set foldcolumn=1 " 设置折叠区域的宽度
setlocal foldlevel=1 " 设置折叠层数为
set foldclose=all " 设置为自动关闭折叠 
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR> " 用空格键来开关折叠


"语法高亮
"colorscheme desert 
"syntax enable 
syntax on
syntax enable
set background=dark
colorscheme solarized

"设置编码
set encoding=utf-8
set fileencodings=utf-8,chinese,latin-1
if has("win32")
set fileencoding=chinese
else
set fileencoding=utf-8
endif

"解决consle输出乱码
language messages zh_CN.utf-8

"设置文件编码检测类型及支持格式
set fencs=utf-8,gbk,ucs-bom,gb18030,gb2312,cp936
"指定菜单语言
set langmenu=zh_CN.utf-8
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
set guifont=DejaVu\Sans\Mono:h12
"set guifontwide=youyuan:h10

"帮助语言
set helplang=cn
set iskeyword+=

"文件浏览组建WinManager
let g:winManagerWindowLayout='FileExplorer' 
nmap wm :WMToggle<cr>

""""""""""""""""""""""""""""""
" miniBufexplorer Config
"多文件编辑
""""""""""""""""""""""""""""""
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapCTabSwitchWindows = 1
let g:miniBufExplMapCTabSwitchBufs = 1 
let g:miniBufExplModSelTarget = 1

"解决FileExplorer窗口变小问题
let g:miniBufExplForceSyntaxEnable = 1
let g:miniBufExplorerMoreThanOne=1

""""""""""""""""""""""""""""""
" BufExplorer
""""""""""""""""""""""""""""""
""let g:bufExplorerDefaultHelp=0       " Do not show default help.
""let g:bufExplorerShowRelativePath=1  " Show relative paths.
""let g:bufExplorerSortBy='mru'        " Sort by most recently used.
""let g:bufExplorerSplitRight=0        " Split left.
""let g:bufExplorerSplitVertical=1     " Split vertically.
""let g:bufExplorerSplitVertSize = 30  " Split width
""let g:bufExplorerUseCurrentWindow=1  " Open in new window.
""autocmd BufWinEnter \[Buf\ List\] setl nonumber

"""""新文件标题""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"新建.php文件，自动插入文件头 
autocmd BufNewFile *.php exec ":call SetTitle()" 
""定义函数SetTitle，自动插入文件头 
func SetTitle() 
    "如果文件类型为.php文件 
    if &filetype == 'php' 
		call setline(1,"<?php")		
        call append(line("."), "\/**") 
        call append(line(".")+1, "\ * File Name: ".expand("%")) 
        call append(line(".")+2, "\ * Author: Naodai") 
        call append(line(".")+3, "\ * mail: zhao_brain@163.com") 
        call append(line(".")+4, "\ * Created Time: ".strftime("%c"))  
        call append(line(".")+5, "\ */") 
        call append(line(".")+6, "") 
    endif
    "新建文件后，自动定位到文件末尾
    autocmd BufNewFile * normal G
endfunc 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']

""vim启动时自动加载Rainbow Parentheses插件 rainbow_parenthsis
func! s:rainbow_parenthsis_load()
	call rainbow_parenthsis#LoadSquare()
	call rainbow_parenthsis#LoadRound()
	call rainbow_parenthsis#Activate()
endfunc
au Syntax csc call s:rainbow_parenthsis_load()

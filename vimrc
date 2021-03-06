""""""""""""""" 基础配置 """""""""""""""""""
"设置行号
set number
" 设置相对行号 挺好玩的
set relativenumber
" 设置智能缩进
set smartindent
" 设置自动缩进的长度
set shiftwidth=4
" 设置<Tab>键占用的列数
set tabstop=4
" 使用空格代替tab
set expandtab            
" 编写代码时，换行自动缩进
set autoindent
" 保持光标距离屏幕顶部和底部有3行的距离
set scrolloff=3
" 将被搜索的字符串进行高亮设置
set hlsearch
" 设置查找自动提示
set incsearch
" 在当前窗口中，如果单行长度过长
" 则能显示多少就显示多少
" 不用将整行全部显示出来
set display=lastline
" 设置高亮光标所在列
set cursorcolumn
" 设置高亮光标所在行
set cursorline
" 配置状态栏
" 总是显示状态拦
set laststatus=2
" 打开文件默认不折叠代码
set foldlevelstart=99
" 自动匹配括号
set showmatch
" 代码可折叠
set foldmethod=indent
set foldlevel=99
" 设置编码格式
set encoding=utf-8
" 系统剪切板
set clipboard=unnamed
" 解决退格键失效的问题
set backspace=indent,eol,start
set modifiable
" 在显示帮助信息列表的时候，显示状态栏
set wildmenu
" 设置里面命令保存条数
set history=1000

" 所有python语法高亮功能生效
let python_highlight_all=1

set term=screen

" 显示执行的命令
set showcmd
" 设置自动保存
set autowrite
" 设置81行高亮
set colorcolumn=81
" 设置单行超过80个字符自动换行
" set textwidth=80
" set fo+=mB

""""""""""""""""""""" 映射方案 """"""""""""""""""""
" 使用jk退出插入模式
inoremap jk <esc>
" 在插入模式下，将光标所在单词转化为大写
inoremap <C-u> <esc>gUiwea
" 括号自动补全
inoremap ( ()<ESC>i
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap [ []<ESC>i
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap { {}<ESC>i
inoremap } <c-r>=ClosePair('}')<CR>
" 换行之后插入#保持只能缩进
inoremap # X#

" 按键绑定，将调用函数并执行
nnoremap <leader>f :call Mydict()<CR>
" 快速编辑vimrc文件
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" 加载vimrc文件
nnoremap <leader>sv :source $MYVIMRC<cr>
" 在命令模式下将小写转化为大写
nnoremap <leader>u gUiwe
" 将H映射为到行首
nnoremap H <S-^>
" 将L映射为到行尾
nnoremap L $
" 映射选中当前光标所在单词
nnoremap M #N
" 在窗口之间快速移动
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-H> <C-W>h
nnoremap <C-L> <C-W>l
" buffer 的快速切换
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>
" 代码折叠快捷键
nnoremap <space> za
" 快速保存
" nnoremap <leader>w :w<CR>

" 缩写映射
iabbrev xmlv <?xml version="1.0" encoding="utf-8" ?>

" 事件监听
" 自动启动文件浏览目录
autocmd VimEnter * :NERDTreeTabsOpen
" 为python文件自动添加文件头
autocmd BufNewFile *.py execute ":call NewPy()"
function! NewPy()
    " call setline(1,"#!/usr/bin/env python")
    call setline(1,"# -*- encoding: utf-8 -*-")
endfunction
" 记录上次关闭vim光标所在的位置
autocmd BufReadPost *
            \ if line("'\"")>0&&line("'\"")<=line("$") |
            \   exe "normal g'\"" |
            \ endif

" Python 快速插入断点
nnoremap <F2> oimport ipdb; ipdb.set_trace()<ESC>:w<CR>

syntax enable
let g:solarized_termtrans = 1
" 设置背景色
" set background=dark
set background=light
colorscheme solarized
" airline 状态栏配置
" 显示buffer标签
let &t_Co=256
let g:airline#extensions#tabline#enabled=1
" let g:airline_theme='solarized'
let g:airline_theme='papercolor'
let g:airline_powerline_fonts=1

" 高亮行列的配色方
" 深色
" highlight CursorLine   cterm=NONE ctermbg=black ctermfg=white guibg=red guifg=white
" highlight CursorColumn cterm=NONE ctermbg=black ctermfg=white guibg=red guifg=white
" 浅色
highlight CursorLine   cterm=NONE ctermbg=lightgray ctermfg=black guibg=red guifg=white
highlight CursorColumn cterm=NONE ctermbg=lightgray ctermfg=black guibg=red guifg=white
" 修改高亮的背景色
highlight SyntasticErrorSign guifg=white guibg=black

"自动补全结束函数
function! ClosePair(char)
	if getline('.')[col('.') - 1] == a:char
		return "\<Right>"
	else
		return a:char
	endif
endfunction

" 获得vi启动路径
function! CurDir()
    let curdir = substitute(getcwd(),$HOME,"~","g")
    return curdir
endfunction

" 配置markdown转化html
nnoremap <leader>md :call Header() <CR>

function! Header()
    ":execute ':%!/usr/local/bin/Markdown.pl --html4tags'
    :execute ':%!python /usr/local/lib/python2.7/dist-packages/markdown2.py -x tables'
    :execute 'normal! Go'
    r ~/mail/mutt/signature.html
endfunction

" 终端下设置alt快捷键可用
let c='a'
while c <= 'z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw

set timeout ttimeoutlen=50
"插件管理
"""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

" 文件管理
Plug 'scrooloose/nerdtree'
" 标签共享nerdtree
Plug 'jistr/vim-nerdtree-tabs'
" 在nerdtree中显示git信息
Plug 'Xuyuanp/nerdtree-git-plugin'
" 语法检查
Plug 'tpope/vim-pathogen'
" Plug 'vim-syntastic/syntastic'
" 滚屏插件，使滚屏看起来好看一下
Plug 'yonchu/accelerated-smooth-scroll'
" 标签编写插件
Plug 'mattn/emmet-vim'
" 代码折叠
Plug 'tmhedberg/SimpylFold'
" 缩进插件
Plug 'indentpython.vim'
" 自动补全插件
Plug 'Valloric/YouCompleteMe'
" 语法高亮插件
Plug 'nvie/vim-flake8'
" 主题插件
Plug 'jnurmine/Zenburn'
Plug 'altercation/vim-colors-solarized'
" 文件搜索插件
Plug 'ctrlpvim/ctrlp.vim'
" git支持
Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv'
" 状态栏插件
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" outline插件
Plug 'majutsushi/tagbar'
" 单词搜索
Plug 'mileszs/ack.vim'
" 对齐线
Plug 'nathanaelkane/vim-indent-guides'
" 快速注释
Plug 'scrooloose/nerdcommenter'
" 日历插件
Plug 'itchyny/calendar.vim'
" 在vim中使用shell
Plug 'Shougo/vimshell.vim'
Plug 'Shougo/vimproc.vim'
" Python Debug 工具
Plug 'gotcha/vimpdb'
" Python pep8检查
Plug 'vim-scripts/pep8'
" 配对插件
Plug 'tpope/vim-surround'
" git 信息
Plug 'airblade/vim-gitgutter'
" 整行移动
Plug 'matze/vim-move'
" Tmux 使用airline配置
" Plug 'edkolev/tmuxline.vim'
" buffer 关闭管理
Plug 'schickling/vim-bufonly'
" java 自动补全插件
Plug 'artur-shaik/vim-javacomplete2'
" 漂亮的目录图标
Plug 'ryanoasis/vim-devicons'
" NERDTree根据文件类型，显示不同的颜色
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" Vim Wiki 个人知识管理
Plug 'vimwiki/vimwiki'

call plug#end()

filetype plugin indent on

runtime macros/matchit.vim
runtime ftplugin/man.vim

"插件配置
"""""""""""""""""""""""""""""""""""""""""""""""""""
"文件浏览快捷键
" 关闭NERDTree快捷键
map <leader>t :NERDTreeToggle<CR>
" 显示行号
let NERDTreeShowLineNumbers=1
" let NERDChristmasTree=1
let NERDTreeAutoCenter=1
" 是否显示隐藏文件
let NERDTreeShowHidden=1
" 设置宽度
let NERDTreeWinSize=50
" 在终端启动vim时，共享NERDTree
let g:nerdtree_tabs_open_on_console_startup=1
"let g:nerdtree_tabs_focus_on_files=1
"let g:nerdtree_tabs_smart_startup_focus=2
" 忽略一下文件的显示
let NERDTreeIgnore=['\.pyc','\~$','\.swp','\.class']
" 显示书签列表
let NERDTreeShowBookmarks=1
" git信息显示配置
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }
" 对文件进行排序
let NERDTreeCaseSensitiveSort=1
" 当NERDTree根目录变化时，CWD的目录也跟随变化
let NERDTreeChDirMode=2
" 状态栏
let NERDTreeStatusline='%{b:NERDTree.root.path.strForOS(0)}'
" 自动删除没用的buffer
let NERDTreeAutoDeleteBuffer=1
" 还没搞明白什么意思
let NERDTreeCreatePrefix='silent keepalt keepjumps'
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" java 格式检查
let g:syntastic_java_checkstyle_classpath='~/.vim/checkstyle-7.1.2.jar'
let g:syntastic_java_checkstyle_conf_file='~/.vim/sun_checks.xml'
let g:syntastic_java_javac_config_file_enabled=1

" 代码概况配置
" 需要安装ctags
" sudo apt-get install ctags
nnoremap <leader>p :TagbarToggle<CR><C-W><C-L>
" 显示行号
let g:tagbar_show_linenumbers=-1

" 语法检查配置
" 当打开一个buffer的时候，会进行语法检查
let g:syntastic_check_on_open=1
" 当保存编辑的时候会进行语法检查
let g:syntastic_check_on_wq=0
" 错误符号
let g:syntastic_error_symbol='>>'
" 警告符号
let g:syntastic_warning_symbol='>'
let g:syntastic_enable_highlighting=1
" 使用pyfakes进行语法检查，速度比pylint快
let g:syntastic_python_checkers=['pyflakes']
" js 语法检查
let g:syntastic_javascript_checkers = ['jsl', 'jshint']
" html 语法检查
let g:syntastic_html_checkers=['tidy', 'jshint']
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_loc_list_height = 5

" 代码折叠配置
let g:SimpylFold_docstring_preview=1

" 自动补全配置
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_python_binary_path = 'python'
map <leader>g :YcmCompleter GoToDefintionElseDeclaration<CR>
set completeopt-=preview

" python语法检查配置
" execute pathogen#infect()
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" 对齐线设置
let g:indent_guides_guide_size=1

" 日历插件配置
" 日期格式：year-month-day
let g:calendar_date_endian="big"
" 日期分割符
let g:calendar_date_separator="-"
" 打开日历时的视图
let g:calendar_view="week"
" 设置view布局
let g:calendar_views=['year','day','month','week','clock','day']
" 配置快捷键
"nnoremap ca :Calendar<cr>

" 配置RopeVim
let ropevim_codeassist_maxfixes=10
let ropevim_guess_project=1
let ropevim_vim_completion=1
let ropevim_enable_autoimport=1
let ropevim_extended_complete=1

" ctrlP 配置
" 忽略文件
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc
let g:ctrlp_custom_ignore = '\v[\/]\.(git)$'
let g:ctrlp_custom_ignore = {
	\ 'dir':  '\v[\/]\.(git)$',
	\ 'file': '\v\.(swp|pyc)$',
	\ }

" let g:tmuxline_preset = {
"       \'a'    : '#S',
"       \'c'    : ['#(whoami)', '#(uptime | cud -d " " -f 1,2,3)'],
"       \'win'  : ['#I', '#W'],
"       \'cwin' : ['#I', '#W', '#F'],
"       \'x'    : '#(date)',
"       \'y'    : ['%R', '%a', '%Y-%m-%d'],
"       \'z'    : '#H'}

" VimShell 配置
let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
"let g:vimshell_right_prompt = 'vcs#info("(%s)-[%b]", "(%s)-[%b|%a]")'
let g:vimshell_prompt = $USER."% "

function! CustomCodeAssistInsertMode()
    call RopeCodeAssistInsertMode()
    if pumvisible()
        return "\<C-L>\<Down>"
    else
        return ''
    endif
endfunction

function! TabWrapperComplete()
    let cursyn = synID(line('.'), col('.') - 1, 1)
    if pumvisible()
        return "\<C-Y>"
    endif
    if strpart(getline('.'), 0, col('.')-1) =~ '^\s*$' || cursyn != 0
        return "\<Tab>"
    else
        return "\<C-R>=CustomCodeAssistInsertMode()\<CR>"
    endif
endfunction

inoremap <buffer><silent><expr> <Tab> TabWrapperComplete()

function! Mydict()
  "执行sdcv命令查询单词的含义,返回的值保存在expl变量中
  let expl=system('sdcv -n ' . expand("<cword>"))
  "在每个窗口中执行命令，判断窗口中的文件名是否是dict-tmp，如果是，强制关闭
  windo if expand("%")=="dict-tmp" |q!|endif	
  "纵向分割窗口，宽度为25，新窗口的内容为dict-tmp文件的内容
  35vsp dict-tmp
  "设置查询结果窗口的属性，不缓存，不保留交换文件
  setlocal buftype=nofile bufhidden=hide noswapfile
  "将expl的内容显示到查询结果窗口
  1s/^/\=expl/
  :1
  "跳转回文本窗口
  "wincmd p
endfunction

" java 自动补全插件配置 
autocmd FileType java setlocal omnifunc=javacomplete#Complete
nmap <F4> <Plug>(JavaComplete-Imports-AddSmart)
imap <F4> <Plug>(JavaComplete-Imports-AddSmart)
nmap <F3> <Plug>(JavaComplete-Imports-Add)
imap <F3> <Plug>(JavaComplete-Imports-Add)
nmap <F6> <Plug>(JavaComplete-Imports-AddMissing)
imap <F6> <Plug>(JavaComplete-Imports-AddMissing)
nmap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)
imap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)
nmap <leader>jI <Plug>(JavaComplete-Imports-AddMissing)
nmap <leader>jR <Plug>(JavaComplete-Imports-RemoveUnused)
nmap <leader>ji <Plug>(JavaComplete-Imports-AddSmart)
nmap <leader>jii <Plug>(JavaComplete-Imports-Add)

imap <C-j>I <Plug>(JavaComplete-Imports-AddMissing)
imap <C-j>R <Plug>(JavaComplete-Imports-RemoveUnused)
imap <C-j>i <Plug>(JavaComplete-Imports-AddSmart)
imap <C-j>ii <Plug>(JavaComplete-Imports-Add)

nmap <leader>jM <Plug>(JavaComplete-Generate-AbstractMethods)

imap <C-j>jM <Plug>(JavaComplete-Generate-AbstractMethods)

nmap <leader>jA <Plug>(JavaComplete-Generate-Accessors)
nmap <leader>js <Plug>(JavaComplete-Generate-AccessorSetter)
nmap <leader>jg <Plug>(JavaComplete-Generate-AccessorGetter)
nmap <leader>ja <Plug>(JavaComplete-Generate-AccessorSetterGetter)
nmap <leader>jts <Plug>(JavaComplete-Generate-ToString)
nmap <leader>jeq <Plug>(JavaComplete-Generate-EqualsAndHashCode)
nmap <leader>jc <Plug>(JavaComplete-Generate-Constructor)
nmap <leader>jcc <Plug>(JavaComplete-Generate-DefaultConstructor)

imap <C-j>s <Plug>(JavaComplete-Generate-AccessorSetter)
imap <C-j>g <Plug>(JavaComplete-Generate-AccessorGetter)
imap <C-j>a <Plug>(JavaComplete-Generate-AccessorSetterGetter)

vmap <leader>js <Plug>(JavaComplete-Generate-AccessorSetter)
vmap <leader>jg <Plug>(JavaComplete-Generate-AccessorGetter)
vmap <leader>ja <Plug>(JavaComplete-Generate-AccessorSetterGetter)

" 目录图标配置
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1

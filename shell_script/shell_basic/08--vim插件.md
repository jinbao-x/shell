#### 想要使得在vim内部就可以运行脚本测试，可以编辑家目录路下的.vimrc文件
```shell
"""""""""""""""
"Quickly Run
"""""""""""""""
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
        exec "w"
        if &filetype == 'sh'		"shell脚本按F5键可脚本内直接运行调试
                :!time bash %
        elseif &filetype == 'python'	"python脚本按F5键可脚本内直接运行调试
                exec "!time python3 %"
        endif
endfunc
```

#### 为vim添加编程提示插件jedi-vim
#jedi-vim是基于jedi的自动补全插件，与snipmate不同，此插件更加智能，可以称为“编程提示”，而不是代码补全，jedi是自动补全和静态分析的python库，直接用pip安装即可
1、先安装vundle
#Vundle是Vim的一个插件管理器，基于git，通过Vundle可以方便的安装github上的Vim插件

```shell
sudo apt-get upgrade vim 
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim ~/.vimrc
#添加：
set nocompatible              "be iproved, required去除一致性，必须
filetype off                  "required必须

"set the runtime path to include Vundle and initialize设置包括vundle和初始化相关的运行时路径
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required启用vundle管理插件，必须
Plugin 'VundleVim/Vundle.vim'

"All of your Plugins must be added before the following line所有的插件配置都应该在vundle#end之前
call vundle#end()            " required
filetype plugin indent on    " required加载vim自带和插件相应的语法和文件类型相关脚本

" To ignore plugin indent changes, instead use:
"filetype plugin on
"jeid-vim 关闭预览界面，取消帮助文档的提示
"jedi-vim  中帮助文章在预览界面中出现，感觉意义不大还影响对其它地方的观察，所以选择取消这一功能
autocmd FileType python setlocal completeopt-=preview
```

2、安装jedi-vim

```shell
git clone --recursive  https://gitee.com/chenjo/jedi-vim.git   ~/.vim/bundle/jedi-vim
#编辑.vimrc
#然后在Plugin 'VundleVim/Vundle.vim'下方添加
Plugin 'davidhalter/jedi-vim'
```

然后直接输入vim
命令行模式下输入:PluginInstall
然后就会把插件安装上了

#### 编辑vim里的缩进补全等
```shell
filetype plugin on
let g:pydiction_location = '/root/.vim/bundle/pydiction/complete-dict'
syntax on
"set cursorline
set scrolloff=7
set ai
set ts=4	"set tabstop设置tab为4个空格长度
set et		"set expandtab将tab转换为空格
set encoding=utf8	"设置编码为utf8
autocmd FileType yaml setlocal sw=2 ts=2 et ai	"为yml设置2个空格长度的tab，并自动扩展为2个空格
nnoremap <C-a> <Home>
nnoremap <C-e> <End>
nnoremap <F2> :set nu! nu?<CR>
nnoremap ; :
```

#synatastic语法检查插件




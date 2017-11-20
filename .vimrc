autocmd BufWritePost $MYVIMRC source $MYVIMRC

let mapleader=";"

syntax enable
syntax on

set encoding=utf8
set fileencoding=utf8
set fileencodings=utf8,gbk,gb2312,big5
set number
" 总是显示状态栏
set laststatus=2
" 显示光标当前位置
set ruler
" 高亮显示当前行/列
set cursorline
set cursorcolumn
" 高亮显示搜索结果
set hlsearch
" 开启实时搜索功能
set incsearch
" 搜索时大小写不敏感
set ignorecase
" 关闭兼容模式
set nocompatible
" vim 自身命令行模式智能补全
set wildmenu
set backspace=indent,eol,start

"""""""""""""Theme Setting""""""""""""""""
set t_Co=256
set background=dark  
"colorscheme molokai
"let g:solarized_termcolors=16
colorscheme solarized
"colorscheme gruvbox
"let g:gruvbox_termcolors=256
"colorscheme zenburn

""""""""""""""""""""""""""" vundle 环境设置"""""""""""""""""""""""""
" 安装命令 
" :PluginInstall
" 删除命令，首先从配置文件中删除，然后执行下面命令
" :PluginClean
" 更新命令
" :PluginUpdate
" vundle 管理的插件列表必须位于 vundle#begin() 和 vundle#end() 之间
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off
filetype plugin indent on
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'
Plugin 'morhetz/gruvbox'
" Plugin 'vim-scripts/phd'
" Plugin 'Lokaltog/vim-powerline'
" Plugin 'octol/vim-cpp-enhanced-highlight'
" Plugin 'nathanaelkane/vim-indent-guides'
" Plugin 'derekwyatt/vim-fswitch'
" Plugin 'kshenoy/vim-signature'
" Plugin 'vim-scripts/BOOKMARKS--Mark-and-Highlight-Full-Lines'
" Plugin 'majutsushi/tagbar'
" Plugin 'vim-scripts/indexer.tar.gz'
" Plugin 'vim-scripts/DfrankUtil'
" Plugin 'vim-scripts/vimprj'
" Plugin 'dyng/ctrlsf.vim'
" Plugin 'terryma/vim-multiple-cursors'
" Plugin 'scrooloose/nerdcommenter'
" Plugin 'vim-scripts/DrawIt'
" Plugin 'SirVer/ultisnips'
" Plugin 'Valloric/YouCompleteMe'
" Plugin 'derekwyatt/vim-protodef'
 Plugin 'scrooloose/nerdtree'
" Plugin 'fholgado/minibufexpl.vim'
" Plugin 'gcmt/wildfire.vim'
" Plugin 'sjl/gundo.vim'
" Plugin 'Lokaltog/vim-easymotion'
" Plugin 'suan/vim-instant-markdown'
" Plugin 'lilydjwg/fcitx.vim'
call vundle#end()


"""""""" 使用 NERDTree 插件查看工程文件。"""""""
"设置快捷键，速记：file list
""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>fl :NERDTreeToggle<CR>
" 设置NERDTree子窗口宽度
let NERDTreeWinSize=32
" 设置NERDTree子窗口位置
let NERDTreeWinPos="left"
" 显示隐藏文件
let NERDTreeShowHidden=1
" NERDTree 子窗口中不显示冗余帮助信息
let NERDTreeMinimalUI=1
"设置忽略文件类型"
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
" 删除文件时自动删除文件对应 buffer
let NERDTreeAutoDeleteBuffer=1


"""""""""YouCompleteMe""""""""""
"<ctrl+o> jump backward
""""""""""""""""""""""""""""""""
"nnoremap <leader>gd :YcmCompleter GoToDeclaration<CR>
"nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
"let g:ycm_goto_buffer_command = 'horizontal-split'
let g:ycm_goto_buffer_command = 'vertical-split'
nnoremap <leader>gf :YcmCompleter GoToDefinitionElseDeclaration<CR>


"""""""""Python Setting""""""""""
au BufRead *.py map <buffer> <F5> :w<CR>:!/usr/bin/env python % <CR>
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |

autocmd BufWritePost $MYVIMRC source $MYVIMRC
autocmd BufNewFile *.py 0put =\"#!/usr/bin/env python\<nl>\#-*- coding=utf8 -*-\"|$
autocmd BufNewFile *.sh 0put =\"#!/bin/bash\<nl>\set -xe\"|$
autocmd BufNewfile * normal G
autocmd Filetype json let g:indentLine_setConceal = 0
autocmd FileType python noremap <buffer> <leader>f :call Autopep8()<CR>
autocmd BufNewFile,BufRead *.{py,sh,json,yml,yaml}
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |

"< 向外缩进
"> 向内缩进

let mapleader=";"
set pastetoggle=<F9>
inoremap <leader><Space> <Esc>
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
inoremap <C-d> <DELETE>
nnoremap <C-y> "+y
nnoremap <C-p> "+p
vnoremap y "+y

set foldenable
set foldmethod=indent
set foldcolumn=0
setlocal foldlevel=1
set foldlevelstart=99
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

syntax enable
syntax on
set encoding=utf8
set fileencoding=utf8
set fileencodings=utf8,gbk,gb2312,big5
set number
set laststatus=2
set ruler
set cursorline
set cursorcolumn
set hlsearch
set incsearch
set ignorecase
set wildmenu
set backspace=indent,eol,start


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
set nocompatible
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'
Plugin 'morhetz/gruvbox'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'wsdjeg/FlyGrep.vim'
Plugin 'Yggdroot/indentLine'
Plugin 'tell-k/vim-autopep8'
Plugin 'jiangmiao/auto-pairs'
Plugin 'thinca/vim-quickrun'
Plugin 'SirVer/ultisnips'
Plugin 'bronson/vim-trailing-whitespace'
" Plugin 'vim-syntastic/syntastic'
Plugin 'w0rp/ale'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'tmux-plugins/vim-tmux-focus-events'
Plugin 'roxma/vim-tmux-clipboard'
" Plugin 'Valloric/YouCompleteMe'
" Plugin 'vim-scripts/phd'
" Plugin 'Lokaltog/vim-powerline'
" Plugin 'nathanaelkane/vim-indent-guides'
" Plugin 'derekwyatt/vim-fswitch'
" Plugin 'kshenoy/vim-signature'
" Plugin 'vim-scripts/BOOKMARKS--Mark-and-Highlight-Full-Lines'
" Plugin 'vim-scripts/indexer.tar.gz'
" Plugin 'vim-scripts/DfrankUtil'
" Plugin 'vim-scripts/vimprj'
" Plugin 'dyng/ctrlsf.vim'
" Plugin 'terryma/vim-multiple-cursors'
" Plugin 'vim-scripts/DrawIt'
" Plugin 'derekwyatt/vim-protodef'
" Plugin 'fholgado/minibufexpl.vim'
" Plugin 'gcmt/wildfire.vim'
" Plugin 'sjl/gundo.vim'
" Plugin 'suan/vim-instant-markdown'
" Plugin 'lilydjwg/fcitx.vim'
call vundle#end()
filetype plugin indent on


"""""""""""""Theme Setting""""""""""""""""
set t_Co=256
set background=dark
colorscheme gruvbox
let g:gruvbox_termcolors=256
"colorscheme solarized
"let g:solarized_termcolors=16
"colorscheme zenburn
"colorscheme molokai


"""""""""""""""" NERDTree""""""""""""""""""
"u 显示上级目录
"C 进入目录或者文件所在目录
"gt 切换tab
"i 在新窗口打开
"""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>t :NERDTreeToggle<CR>
let NERDTreeWinSize=28
let NERDTreeWinPos="left"
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
let NERDTreeAutoDeleteBuffer=1


"""""""""""""""""""NERDComment""""""""""""""""""
"<leader>c<space> 自动判断添加或取消注释
"<leader>cc 添加注释
"<leader>cu 取消注释
"<leader>cy 注释并复制
"<leader>cs 美化版注释
"""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_java = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1


"""""""""YouCompleteMe""""""""""
"<ctrl+o> jump backward
""""""""""""""""""""""""""""""""
set runtimepath+=~/.vim/bundle/YouCompleteMe
"nnoremap <leader>gd :YcmCompleter GoToDeclaration<CR>
"nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
"let g:ycm_goto_buffer_command = 'horizontal-split'
let g:ycm_goto_buffer_command = 'vertical-split'
nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>


"""""""""""CtrlP"""""""""""""""
let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }


"""""""""""Easy-motion"""""""""""""""
" <Leader>m{char} to move to {char}
" map  <Leader>m <Plug>(easymotion-bd-f)
"; nmap <Leader>m <Plug>(easymotion-overwin-f)
" s{char}{char} to move to {char}{char}
nmap m <Plug>(easymotion-overwin-f2)
map  <leader>w <Plug>(easymotion-bd-w)
nmap <leader>w <Plug>(easymotion-overwin-w)
let g:EasyMotion_smartcase = 1


"""""""""""FlyGrep"""""""""""""""
nnoremap <leader>s :FlyGrep<cr>


"""""""""""Tagbar"""""""""""""""
nnoremap <leader>o :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let tagbar_width=28


""""""""indentLine settings""""""
let g:indentLine_char = "¦"
let g:indentLine_enabled = 1
let g:autopep8_disable_show_diff=1


"""""""""""""""""""""""""""UltiSnip"""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger="<leader>a"
let g:UltiSnipsEditSplit="vertical"


"""""""""""""""""""""""""""Syntastic"""""""""""""""""""""""""
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" let g:syntastic_mode_map= {"mode": "passive", "active_filetypes": ["python"], "passive_filetypes": ["java"]}


"""""""""""""""""""""""""""""ale"""""""""""""""""""""""""""""
let g:airline#extensions#ale#enabled = 1
let g:ale_fix_on_save = 0
let g:ale_completion_enabled = 1
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 1
let g:ale_set_signs = 1
" highlight ALEWarning ctermbg=DarkMagenta
highlight ALEError ctermbg=red
nmap <leader>k <Plug>(ale_previous_wrap)
nmap <leader>j <Plug>(ale_next_wrap)


"""""""""""""""""""""""""""Quick Run"""""""""""""""""""""""""
let g:quickrun_no_default_key_mappings = 1
"nmap <Leader>r <Plug>(quickrun)
map <F5> :QuickRun<CR>
map <leader>rr :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!time java %<"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        exec "!time python %"
    elseif &filetype == 'html'
        exec "!firefox % &"
    elseif &filetype == 'go'
"        exec "!go build %<"
        exec "!time go run %"
    elseif &filetype == 'mkd'
        exec "!~/.vim/markdown.pl % > %.html &"
        exec "!firefox %.html &"
    endif
endfunc


"""""""""""""""""""vim-airline""""""""""""""""""""""""""
let g:airline_theme="bubblegum"
let g:airline_powerline_fonts = 1

let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#symbol = '!'
" set guifont=Consolas\ for\ Powerline\ FixedD:h11
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '¶'

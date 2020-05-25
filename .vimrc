autocmd BufWritePost $MYVIMRC source $MYVIMRC
autocmd BufNewFile *.py 0put =\"#!/usr/bin/env python\<nl>\#-*- coding=utf8 -*-\"|$
autocmd BufNewFile *.sh 0put =\"#!/bin/bash\<nl>\set -xe\"|$
autocmd BufNewfile * normal G
autocmd BufNewFile,BufRead *.{py,sh,json,yml,yaml,xml,html}
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |

"""""""""""代码缩进"""""""""""""
"   < 向外缩进
"   > 向内缩进
""""""""""""""""""""""""""""""""

let mapleader=";"
set pastetoggle=<F9>
nnoremap <F10> :set invnumber<CR>
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


""""""""""""""""""""""""""vim plugin管理"""""""""""""""""""""""""""
" 安装命令
" :PluginInstall
" 删除命令，首先从配置文件中删除，然后执行下面命令
" :PluginClean
" 更新命令
" :PluginUpdate
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'majutsushi/tagbar'
Plug 'kien/ctrlp.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Lokaltog/vim-easymotion'
Plug 'Yggdroot/indentLine'
Plug 'bronson/vim-trailing-whitespace'
Plug 'tpope/vim-surround'
"Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()


"""""""""""""Theme Setting""""""""""""""""
set t_Co=256
set background=dark
colorscheme gruvbox
let g:gruvbox_termcolors=256


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


"""""""""""""""""""""CtrlP"""""""""""""""""""""""
let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }


"""""""""""""""""""""CtrlSF"""""""""""""""""""""""
nnoremap   <leader>s :CtrlSF<space>
let g:ctrlsf_default_view_mode = 'compact'


"""""""""""""""Easy-motion"""""""""""""""""""
" <Leader>m{char} to move to {char}
" map  <Leader>m <Plug>(easymotion-bd-f)
" nmap <Leader>m <Plug>(easymotion-overwin-f)
" s{char}{char} to move to {char}{char}
"""""""""""""""""""""""""""""""""""""""""""""
nmap m <Plug>(easymotion-overwin-f2)
map  <leader>w <Plug>(easymotion-bd-w)
nmap <leader>w <Plug>(easymotion-overwin-w)
let g:EasyMotion_smartcase = 1


"""""""""""Tagbar"""""""""""""""
nnoremap <leader>o :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let tagbar_width=28


""""""""indentLine settings""""""
autocmd Filetype json let g:indentLine_setConceal = 0 
let g:indentLine_char = "¦"
let g:indentLine_enabled = 1
let g:autopep8_disable_show_diff=1


""""""""""""""""""""""surround""""""""""""""""""""""""""
"  cs"'        change the delimiter
"  ds"         remove the delimiters
"  ysiw]       ys,iw,]  [Hello] world!
"  yssb/yss)   (hello world)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""vim-airline""""""""""""""""""""""""""
let g:airline_theme="gruvbox"
let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#symbol = '!'
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


""""""""""""""""""""""""""coc settings start"""""""""""""""""""""""""""""
let g:coc_global_extensions = [
\ 'coc-python',
\ 'coc-java',
\ 'coc-go',
\ 'coc-powershell',
\ 'coc-json',
\ 'coc-yaml',
\ 'coc-html',
\ 'coc-css',
\ 'coc-xml',
\ 'coc-highlight',
\ 'coc-snippets',
\ 'coc-pairs',
\ 'coc-lists',
\ 'coc-git',
\ 'coc-imselect',
\ ]

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
""""""""""""""""""""""""""coc settings end"""""""""""""""""""""""""""""

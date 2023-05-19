" -----------------options----------------- 
" line number
set number
set relativenumber

" tabs & indentation
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent

" line wrapping
set wrap

" search setting
set hlsearch
set smartcase
set ignorecase
exec "nohlsearch"

" cursorline
set cursorline

" tab 提示
set wildmenu

" scrolloff
set scrolloff=5

" 尝试去兼容 vi 编辑器的行为
set nocompatible
" 开启文件类型检测
filetype on
" 文件类型缩进
filetype indent on
filetype plugin on
filetype plugin indent on
" 语法高亮
syntax on

" 允许使用鼠标
set mouse=a
" 设置字符集
set encoding=utf-8

" 定义backspace 的行为
" indent 允许删除缩进
" eol 允许删除换行符
" start 允许退格键在当前行的开头位置删除字符。
set backspace=indent,eol,start

" 设置折叠方式
set foldmethod=indent

" -----------------keymaps----------------- 

let mapleader=" "

" 初学者必备，禁止方向键行为，强迫使用 h j k l
inoremap <Up> <nop>
nnoremap <Up> <nop>
inoremap <Down> <nop>
nnoremap <Down> <nop>
inoremap <Left> <nop>
nnoremap <Left> <nop>
inoremap <Right> <nop>
nnoremap <Right> <nop>
" 设置  jk 为退出 insert 模式
inoremap jk <Esc>
"禁止 ctrl + c
inoremap <C-c> <nop>

" 映射上下左右 为 h j k l
noremap <Left> h
noremap <Right> l
noremap <Up> k
noremap <Down> j

" J K 快速上下跳转
noremap J 5j
noremap K 5k
noremap L $
noremap H ^

vnoremap Y "+y

" 禁止 s 行为
map s <nop>
" S 保存
map S :w<CR>
" Q 退出
map Q :q<CR>
" R source vimrc
map R :source $MYVIMRC<CR>



" 在输入模式下改变光标(iterm2,arch 上面生效)
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"


" - = 上下查找搜索的内容
noremap = nzz
noremap - Nzz
noremap <LEADER><CR> :nohlsearch<CR>

" split winodows
noremap sl :set splitright<CR>:vsplit<CR>
noremap sh :set nosplitright<CR>:vsplit<CR>
noremap sk :set nosplitbelow<CR>:split<CR>
noremap sj :set splitbelow<CR>:split<CR>



" 插件
call plug#begin('~/.vim/plugged')

Plug 'bluz71/vim-nightfly-colors', { 'as': 'nightfly' }
Plug 'tpope/vim-surround'
Plug 'christoomey/vim-tmux-navigator'

"fzf
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'run': 'make' }
" coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()


" nightfly
colorscheme nightfly

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" ==================== coc.nvim ====================
let g:coc_global_extensions = [
	\ 'coc-css',
	\ 'coc-diagnostic',
	\ 'coc-eslint',
	\ 'coc-explorer',
	\ 'coc-gitignore',
  \ 'coc-go',
	\ 'coc-html',
	\ 'coc-import-cost',
	\ 'coc-json',
	\ 'coc-snippets',
	\ 'coc-syntax',
	\ 'coc-tasks',
	\ 'coc-tsserver',
	\ 'coc-vetur',
	\ 'coc-vimlsp',
	\ 'coc-yaml',
	\ 'coc-yank']
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <c-o> coc#refresh()
function! Show_documentation()
	call CocActionAsync('highlight')
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction
nnoremap <LEADER>h :call Show_documentation()<CR>
" set runtimepath^=~/.config/nvim/coc-extensions/coc-flutter-tools/
" let g:coc_node_args = ['--nolazy', '--inspect-brk=6045']
" let $NVIM_COC_LOG_LEVEL = 'debug'
" let $NVIM_COC_LOG_FILE = '/Users/david/Desktop/log.txt'

nnoremap <silent><nowait> <LEADER>d :CocList diagnostics<cr>
nmap <silent> <LEADER>- <Plug>(coc-diagnostic-prev)
nmap <silent> <LEADER>= <Plug>(coc-diagnostic-next)
nnoremap <c-c> :CocCommand<CR>
" Text Objects
xmap kf <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap kf <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
xmap kc <Plug>(coc-classobj-i)
omap kc <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
" Useful commands
nnoremap <silent> <space>y :<C-u>CocList -A --normal yank<cr>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD :tab sp<CR><Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nmap tt :CocCommand explorer<CR>
" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>aw  <Plug>(coc-codeaction-selected)

noremap <silent> <leader>ts :CocList tasks<CR>
" coc-snippets
imap <C-l> <Plug>(coc-snippets-expand)
vmap <C-e> <Plug>(coc-snippets-select)
let g:coc_snippet_next = '<c-e>'
let g:coc_snippet_prev = '<c-n>'
imap <C-e> <Plug>(coc-snippets-expand-jump)
autocmd BufRead,BufNewFile tsconfig.json set filetype=jsonc

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
set scrolloff=10

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
set foldmethod=manual

" -----------------keymaps----------------- 

let mapleader=" "

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

" coc
"
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

call plug#end()

" nightfly
colorscheme nightfly


" ==================== coc.nvim ====================
let g:coc_global_extensions = ["coc-json","coc-vimlsp","coc-tsserver"]
set updatetime=100
set signcolumn=yes
" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" trigger completion
inoremap <silent><expr> <c-o> coc#refresh()

" Use `LEADER [` and `LEADER ]` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nnoremap <silent> <LEADER>d :CocList diagnostics
nmap <silent> <LEADER>[ <Plug>(coc-diagnostic-prev)
nmap <silent> <LEADER>] <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use LEADER k to show documentation in preview window
nnoremap <silent> <LEADER>k :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)


" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

lua <<EOF
require'nvim-treesitter.configs'.setup {
	ensure_installed = { 
    "css",
    "dockerfile",
    "javascript",
    "json",
    "typescript",
    "tsx",
    "go"
    },
	highlight = {
		enable = true,  
    additional_vim_regex_highlighting = false,
	},
}
EOF



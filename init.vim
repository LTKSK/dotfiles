" Normal mode
cnoremap init :<C-u>edit $MYVIMRC<CR> " init.vim呼び出し
noremap <Space>s :source $MYVIMRC<CR> " init.vim読み込み
noremap <Space>w :<C-u>w<CR>	      " file保存

inoremap <silent> jj <ESC>:<C-u>w<CR>
inoremap <C-d> <BS>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-k> <Up>
inoremap <C-j> <Down>

map <C-n> :NERDTreeToggle<CR>

set encoding=utf-8
set number
set splitbelow
set splitright
set wildmenu
set tabstop=2
set shiftwidth=2
set expandtab
set incsearch

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" pluginディレクトリへのpath
let s:dein_dir = expand('~/.vim/dein')
" path for dein.vim
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
" path for toml
let s:toml_dir = expand('~/.config/nvim')

" Required:
execute 'set runtimepath^=' . s:dein_repo_dir


" Required:
" set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " Let dein manage dein
  " Required:
  call dein#add('~/.vim/dein/repos/github.com/Shougo/dein.vim')

  " call dein#load_toml(s:toml_dir . '/dein.toml', {'lazy': 0})
  " call dein#load_toml(s:toml_dir . '/lazy.toml', {'lazy': 1})

  " Required:
  call dein#end()
  call dein#save_state()
endif

call dein#add('preservim/nerdtree')
call dein#add('prettier/vim-prettier')
call dein#add('Shougo/denite.nvim')
call dein#add('tomasr/molokai')
call dein#add('leafgarland/typescript-vim')
call dein#add('peitalin/vim-jsx-typescript')

set clipboard=unnamedplus,unnamed
colorscheme molokai
filetype plugin indent on
syntax enable

"If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif



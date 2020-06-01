"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

"lNormal mode
cnoremap init :<C-u>edit $MYVIMRC<CR> " init.vim呼び出し
noremap <Space>s :source $MYVIMRC<CR> " init.vim読み込み
noremap <Space>w :<C-u>w<CR>	      " file保存

" window move
noremap <c-h> <c-w><c-h> 
noremap <c-j> <c-w><c-j>
noremap <c-k> <c-w><c-k>
noremap <c-l> <c-w><c-l>

inoremap <silent> jj <ESC>
inoremap <C-d> <BS>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-k> <Up>
inoremap <C-j> <Down>

map <C-n> :NERDTreeToggle<CR>

" 基本設定
set encoding=utf-8
set number
set nowrap
set splitbelow
set splitright
set wildmenu
set tabstop=2
set shiftwidth=2
set expandtab
set incsearch
set fileencoding=utf-8 encoding=utf-8
set fileencodings=iso-2022-jp,utf-8,euc-jp,ucs-2le,cp932
set nobomb
set t_Co=256
" 挿入モードでもバックスペースで削除できるように
set backspace=indent,eol,start

" enable mouse
set mouse=a

" pluginディレクトリへのpath
let s:dein_dir = expand('~/.vim/dein')
" path for dein.vim
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
" path for toml
let s:toml_dir = expand('~/.config/nvim')

" Required:
execute 'set runtimepath^=' . s:dein_repo_dir

" Required:
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " Let dein manage dein
  " Required:
  call dein#add('~/.vim/dein/repos/github.com/Shougo/dein.vim')

  call dein#load_toml(s:toml_dir . '/dein.toml', {'lazy': 0})
  " call dein#load_toml(s:toml_dir . '/lazy.toml', {'lazy': 1})

  " Required:
  call dein#end()
  call dein#save_state()
endif

call dein#add('preservim/nerdtree')
call dein#add('prettier/vim-prettier', {'build': 'yarn install'})
call dein#add('Shougo/denite.nvim')
call dein#add('tomasr/molokai')
call dein#add('jistr/vim-nerdtree-tabs')
call dein#add('leafgarland/typescript-vim')
call dein#add('maxmellon/vim-jsx-pretty')
call dein#add('peitalin/vim-jsx-typescript')
call dein#add('neovim/node-host', {'build': 'npm install'})
call dein#add('billyvg/tigris.nvim', {'build': './install.sh'})

" denite settings
call dein#add('Shougo/denite.nvim')
if !has('nvim')
call dein#add('roxma/nvim-yarp')
  call dein#add('roxma/vim-hug-neovim-rpc')
endif

" Define mappings
nnoremap # :<C-u>Denite file/rec -split=floating file:new<CR>
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
   nnoremap <silent><buffer><expr> <CR>
   \ denite#do_map('do_action')
   nnoremap <silent><buffer><expr> d
   \ denite#do_map('do_action', 'delete')
   nnoremap <silent><buffer><expr> p
   \ denite#do_map('do_action', 'preview')
   nnoremap <silent><buffer><expr> q
   \ denite#do_map('quit')
   nnoremap <silent><buffer><expr> i
   \ denite#do_map('open_filter_buffer')
   nnoremap <silent><buffer><expr> <Space>
   \ denite#do_map('toggle_select').'j'
 endfunction

" setting for tigris.nvim
let g:tigris#debug = 1
let g:tigris#on_the_fly_enabled = 1
let g:tigris#delay = 300

autocmd BufNewFile,BufRead *.ts set filetype=typescript
autocmd BufNewFile,BufRead *.vue set filetype=vue
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx
autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
" auto format
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
autocmd BufWritePre *.ts,*.tsx,*.js,*.jsx :Prettier

set clipboard=unnamedplus,unnamed
colorscheme molokai
filetype plugin indent on
syntax enable

"If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif


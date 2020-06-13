"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" scheme and syntax
syntax enable
colorscheme ck 

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
set number
set nowrap " swapfileを作成しない
set splitbelow
set splitright
set wildmenu
set tabstop=2
set shiftwidth=2
set incsearch
set encoding=utf-8
set fileencoding=utf-8 
set fileencodings=utf-8,iso-2022-jp,euc-jp,cp932
set nobomb
set smartindent " 改行時にいい感じにインデント
set expandtab " tab > space "
set autoread " 変更を自動で再読み込み
set t_Co=256
set colorcolumn=80
set listchars=space:-
highlight ColorColumn ctermbg=lightgray
set backspace=indent,eol,start " 挿入モードでもバックスペースで削除できるように

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

" call quickfix after vim grep
autocmd QuickFixCmdPost *grep* cwindow

set clipboard=unnamedplus,unnamed
filetype plugin indent on

" ========show syntax info
" from http://cohama.hateblo.jp/entry/2013/08/11/020849
function! s:get_syn_id(transparent)
  let synid = synID(line("."), col("."), 1)
  if a:transparent
    return synIDtrans(synid)
  else
    return synid
  endif
endfunction
function! s:get_syn_attr(synid)
let name = synIDattr(a:synid, "name")
let ctermfg = synIDattr(a:synid, "fg", "cterm")
let ctermbg = synIDattr(a:synid, "bg", "cterm")
let guifg = synIDattr(a:synid, "fg", "gui")
let guibg = synIDattr(a:synid, "bg", "gui")
  return {
\ "name": name,
\ "ctermfg": ctermfg,
\ "ctermbg": ctermbg,
\ "guifg": guifg,
\ "guibg": guibg}
endfunction
function! s:get_syn_info()
let baseSyn = s:get_syn_attr(s:get_syn_id(0))
echo "name: " . baseSyn.name .
\ " ctermfg: " . baseSyn.ctermfg .    "   "
\ " ctermbg: " . baseSyn.ctermbg .
\ " guifg: " . baseSyn.guifg .
\ " guibg: " . baseSyn.guibg
let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
echo "link to"
echo "name: " . linkedSyn.name .
\ " ctermfg: " . linkedSyn.ctermfg .
\ " ctermbg: " . linkedSyn.ctermbg .
\ " guifg: " . linkedSyn.guifg .
\ " guibg: " . linkedSyn.guibg
endfunction
command! SyntaxInfo call s:get_syn_info()"
" ========end show syntax info

"If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif


set guifont=Consolas:cRUSSIAN
runtime colors/desert.vim


set modelines=0

set laststatus=2
set statusline=%f%m%w%y%q\ l=%l\ c=%c\ %{\"fenc=\".(&fenc).\"\ enc=\".(&enc)}

set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

set backspace=2

syntax enable
set is
set hls
let mapleader=","
nnoremap <esc><esc> :q<cr>
nnoremap <F2> :w<cr>
nnoremap <leader>j O<esc> 
nnoremap <leader>k kdd 
"nnoremap <tab> <c-w>w
inoremap <c-space> <c-n>
inoremap <F2> <esc>:w<cr>i
vnoremap <c-c> "*y
nnoremap <c-v> "*p
inoremap <c-v> <esc>"*pi

set expandtab
set tabstop=4
set shiftwidth=4

set undodir=~/.vimundo
set undofile
set visualbell
set cursorline

nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

set list
set listchars=tab:>-,eol:¬

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

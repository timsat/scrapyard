set guifont=Inconsolata\ Medium\ 12
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

inoremap jj <esc>

nnoremap <space> za
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" configure tags - add additional tags here or comment out not-used ones
set tags+=~/.vim/tags/cpp
set tags+=~/.vim/tags/libusb
set tags+=~/.vim/tags/boost
"set tags+=~/.vim/tags/gl
"set tags+=~/.vim/tags/sdl
"set tags+=~/.vim/tags/qt4

" enable tagbsearch
set tbs

" build tags of your own project with Ctrl-F12
map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

map <leader><CR> <C-w><C-]>
map <leader>f <C-w>gf



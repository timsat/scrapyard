set guifont=Liberation\ mono\ 11
colors elflord



set modelines=0

set laststatus=2
set statusline=%f%m%w%y%q\ l=%l\ c=%c\ %{\"fenc=\".(&fenc).\"\ enc=\".(&enc)}

set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

set backspace=2

syntax enable

"incsearch
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
"set cursorline
syntax sync minlines=256

"nnoremap / /\v
"vnoremap / /\v
set ignorecase
set smartcase
"set gdefault
set noshowmatch
set matchtime=5

"remove highlights
nnoremap <leader><space> :noh<cr>

"completion
inoremap <c-s-space> <c-X><c-U>

nnoremap <tab> %
vnoremap <tab> %

inoremap <s-tab> :set noexpandtab<cr><tab>:set expandtab

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
nnoremap <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q ./<CR>

nnoremap <leader><CR> <C-w><C-]>
nnoremap <leader>f <C-w>gf
nnoremap <leader>u :Ack <cword><cr>
nnoremap t :tabnew<cr>

au BufRead,BufNewFile *.md set filetype=markdown

" make completion work with eclim
filetype plugin indent on

au FileType markdown :command! -range Bq :cal localFun#insertPrefix(<line1>,<line2>,'> ') 
au FileType markdown nnoremap <leader>q :Bq<cr>
au FileType markdown vnoremap <leader>q :Bq<cr>

au FileType \(c\|cpp\) :command! -range Bc :cal localFun#insertPrefix(<line1>,<line2>,'// ') 
au FileType \(c\|cpp\) nnoremap <leader>c :Bc<cr>
au FileType \(c\|cpp\) vnoremap <leader>c :Bc<cr>

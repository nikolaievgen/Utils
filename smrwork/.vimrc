" Vimrc for dev
"
"

set nocompatible              " be improved, required for Vundle
filetype off                  " required for Vundle
 
" vundle plugin settings
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
 
" User defined plugins
Plugin 'tpope/vim-commentary'
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'Python-mode-klen'
Plugin 'mileszs/ack.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on    " required
" Put your non-Plugin stuff after this line
" Позволим конфигурационным файлам в проекте изменять настройки vim'a
" Включим чтение конфигурационных файлов .vimrc в текущей директории
set exrc                                                                     
" Запретим опасные команды в локальных .vimrc файлах (эта опция должна идти
" в вашем 
" ~/.vimrc после запрещаемых команд, таких как write)
set secure 
" ------------------------------------------------------------------------
" MY Settings
" ------------------------------------------------------------------------

set encoding=utf-8
set fileencoding=utf-8
set autoread

" Backspace enable
set backspace=indent,eol,start

" Tab settings
" Отступы пробелами, а не табуляциями
set expandtab
" Ширина строки 80 символов
"set textwidth=80
" Ширина табуляции в колонках
set ts=2
" Количество пробелов (колонок) одного отступа
set shiftwidth=2
" Новая строка будет с тем же отступом, что и предыдущая
set autoindent
" Умная расстановка отступов (например, отступ при начале нового блока)
set smartindent
" Search settings
set hlsearch
set ignorecase
set smartcase
set incsearch
" Указывать номера строк
set number
" Подсветить максимальную ширину строки
let &colorcolumn=&textwidth
" Цвет линии - тёмно-серый
highlight ColorColumn ctermbg=darkgray
" set colorcolumn=110
" Включаем bash-подобное дополнение командной строки                        
set wildmode=longest:list,full
" Не делать все окна одинакового размера                                    
set noequalalways                                                          
" Высота окон по-умолчанию 20 строк                                         
set winheight=20
" С/C++ файлы
" Расставлять отступы в стиле С
autocmd filetype c,cpp set cin 

set splitright
" 
" set variables
set showcmd
"set cursorline
set showmode
colorscheme desert
syntax on

let g:ctrlp_cmd = 'CtrlPMRU'

" Navigations
" Navig between tabs
nnoremap <f8> :tabn<CR>
nnoremap <s-f8> :tabp<CR>
nnoremap <f2> :NERDTreeToggle<CR>
" Navig between windows
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" With a map leader it's possible to do extra key combinations
let mapleader = ","
let g:mapleader = ","

nnoremap <f5> :exe "resize ".(winheight(0)*3/2)<CR>
nnoremap <leader><f5> :exe "resize ".(winheight(0)*2/3)<CR>
nnoremap <f6> :exe "vertical resize ".(winwidth(0)*3/2)<CR>
nnoremap <leader><f6> :exe "vertical resize ".(winwidth(0)*2/3)<CR>

"
" Fast saving
nnoremap <leader>w :w!<cr>
nnoremap <leader>q :q!<cr>
nnoremap <leader>wq :wqa!<cr>
nnoremap <leader>qa :qa!<cr>
" 
" Quick vimrc edit
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :so %<cr>

" Finding
map <F4> :execute "vimgrep /" . expand("<cword>") . "/j **" <CR>

nnoremap gr :grep -r '\b<cword>\b'  %:p:h <CR>

"
" Run, execute current script
nnoremap <leader>r :!%:p<cr>
"
"
" Copy, Cut line
inoremap <leader>cc <esc>yyi
inoremap <leader>cx <esc>ddi
inoremap <leader>cv <esc>Pi

map <leader>s :NERDTreeFind<cr>

" no help document window
let g:pymode_doc = 0
" tags location
let &tags="./tags,./TAGS,tags,TAGS,/home/n.orgeev/smr1/tags"


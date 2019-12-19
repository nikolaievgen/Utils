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
Plugin 'ericcurtin/CurtineIncSw.vim'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'qpkorr/vim-bufkill'
Plugin 'chiel92/vim-autoformat'
Plugin 'ervandew/supertab'
Plugin 'raimondi/delimitmate'
Plugin 'taglist.vim'
Plugin 'szw/vim-tags'

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
set fileencodings=utf8,cp1251
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
" colorscheme
" colorscheme default
colorscheme morning
syntax on

let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_match_window = 'max:20,results:100' " overcome limit imposed by max height"

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

" synch with browser tree
nnoremap <leader>s :NERDTreeFind<cr>

nnoremap <f5> :exe "resize ".(winheight(0)*6/5)<CR>
nnoremap <leader><f5> :exe "resize ".(winheight(0)*5/6)<CR>
nnoremap <f6> :exe "vertical resize ".(winwidth(0)*6/5)<CR>
nnoremap <leader><f6> :exe "vertical resize ".(winwidth(0)*5/6)<CR>

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

"
" Run, execute current script
nnoremap <leader>r :!%:p<cr>
"
"
" Copy, Cut line
" inoremap <leader>cc <esc>yyi
" inoremap <leader>cx <esc>ddi
" inoremap <leader>cv <esc>Pi


" no help document window
let g:pymode_doc = 0
" tags location
" setted in extension ctags
" let &tags="./tags,./TAGS,tags,TAGS"
let g:vim_tags_auto_generate = 0

" show command line menu on tab 
set wildchar=<Tab> wildmenu wildmode=full
" switch c++ header / source
map <leader>ko :call CurtineIncSw() <CR>
" add include path for gf command
if isdirectory('/home/n.orgeev/smr/include')
      set path+=/home/n.orgeev/smr/include
endif

set splitbelow
set splitright
set hidden

" change encoding current buffer
":e ++enc=cp1251

" If installed using git
set rtp+=~/.fzf
set formatprg=astyle

" let g:airline_powerline_fonts = 1
set t_Co=256
let g:airline_theme='dark'
" let g:airline_section_c = '%t'

set novisualbell "Не мигать 
set t_vb= "Не пищать! (Опции 'не портить текст', к сожалению, нету)

let g:formatdef_my_cpp = '"astyle "'
let g:formatters_cpp = ['my_cpp']
noremap <leader>f :Autoformat<CR>
noremap <leader>fv :!astyle<CR>
noremap <leader>fz :!cat % \| fzf<CR>

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

cnoreabbrev Ack Ack!
nnoremap <Leader>agg :Ack!<CR>
nnoremap <Leader>ag :Ack!<Space>
" Finding
" map <F4> :execute "vimgrep /" . expand("<cword>") . "/j **" <CR>

nnoremap gr :grep -r '\b<cword>\b'  %:p:h <CR>

let g:ackprg = 'ag --path-to-ignore=/home/n.orgeev/proj/working/base/.ignore --vimgrep '

nnoremap <Leader>ctg :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q . <CR>

let delimitMate_quotes = ""

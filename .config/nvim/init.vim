call plug#begin(stdpath('data') . '/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

" Show line numbers
set number relativenumber 
set scrolloff=4
set smartcase smartindent ignorecase

" Set the behavior of tab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

set path+=**
set wildmenu

" Fzf
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-g> :GFiles<CR>
nnoremap <silent> <C-o> :Buffers<CR>
nnoremap <C-f> :Rg! 
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Keys
let mapleader = " "
nnoremap <Leader>w :write<CR>
nnoremap <Leader>e :25Lex<CR>

" Reload config
nnoremap <Leader>r :source ~/.config/nvim/init.vim<CR>

" Tab bindings 
nnoremap <Leader>t    :tabnew<CR>
nnoremap <Leader>x    :tabclose<CR>
nnoremap <Leader>j    :tabprevious<CR>
nnoremap <Leader>k    :tabnext<CR>

" easy split generation
nnoremap <Leader>v    :vsplit
nnoremap <Leader>s    :split

" easy split navigation
nnoremap <C-h>    <C-w>h
nnoremap <C-l>    <C-w>l
nnoremap <C-j>    <C-w>j
nnoremap <C-k>    <C-w>k

" buffer navigation
nnoremap <Tab>    :bnext <CR>
nnoremap <S-Tab>    :bprevious <CR>
nnoremap <Leader>d    :bd! <CR>

" adjust split sizes easier
nnoremap <C-Left> :vertical resize +3<CR>
nnoremap <C-Right> :vertical resize -3<CR>

" Easy way to get back to normal mode from home row
inoremap kk <Esc>
inoremap jj <Esc>

" Automatically close brackets, parethesis, and quotes
inoremap ' ''<left>
inoremap " ""<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap /* /**/<left><left>
inoremap < <><left>
inoremap !! ![]()<left><left><left><C-R>+<right><right><C-R>+<right><CR><CR>
inoremap ** ****<left><left>
inoremap -[ - [ ] 

" Automatically surround with symbols
vnoremap <Leader>s" di"<ESC>pa"
vnoremap <Leader>s' di'<ESC>pa'
vnoremap <Leader>s[ di[<ESC>pa]
vnoremap <Leader>s** di**<ESC>pa**
vnoremap <Leader>s{ di{<ESC>pa}
vnoremap <Leader>s( di(<ESC>pa)
vnoremap <Leader>s< di<<ESC>pa>
vnoremap <Leader><down> :sort<CR>
vnoremap <Leader><up> :sort!<CR>

nnoremap <c-j> :m .+1<CR>==
nnoremap <c-k> :m .-2<CR>==

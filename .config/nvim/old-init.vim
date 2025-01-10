" data path = ~/.local
call plug#begin(stdpath('data') . '/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'artur-shaik/vim-javacomplete2'
Plug 'airblade/vim-rooter'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()

" Set colorscheme
colorscheme desert
hi Pmenu ctermbg=gray
hi PmenuSel ctermbg=yellow

" Show line numbers
set number relativenumber 
set scrolloff=4
set smartcase smartindent ignorecase 

" Set the behavior of tab
filetype indent on
autocmd FileType java setlocal expandtab tabstop=4 sw=4 sts=4
autocmd BufNewFile,BufRead *.go setlocal expandtab tabstop=4 shiftwidth=4 sts=4
let g:go_fmt_autosave = 0
let g:go_code_completion_icase = 1

" set tabstop=2
" set shiftwidth=2
" set softtabstop=2
" set expandtab
" set completeopt=longest,menu
 
set path+=**
" set wildmenu
let mapleader = " "


" vim-javacomplete2 mappings
autocmd FileType java setlocal omnifunc=javacomplete#Complete

nmap <F6> <Plug>(JavaComplete-Imports-Add) <Plug>(JavaComplete-Imports-AddMissing) <Plug>(JavaComplete-Imports-RemoveUnused) <Plug>(JavaComplete-Imports-AddSmart)
imap <F6> <Plug>(JavaComplete-Imports-Add) <Plug>(JavaComplete-Imports-AddMissing) <Plug>(JavaComplete-Imports-RemoveUnused) <Plug>(JavaComplete-Imports-AddSmart)

imap <silent> <C-space> <C-x><C-O>
autocmd FileType java,go imap <silent> . .<C-x><C-O>
autocmd FileType java,go inoremap <silent> " ""<left>
autocmd FileType java,go inoremap <silent> ' ''<left>
autocmd FileType sh,bash inoremap <silent> ` ``<left>

" Lua scripts
lua require('basic')

" Vim rooter
" All files
" let g:rooter_targets = '*'

" Directories and everything under /home
" let g:rooter_targets = ['/', '/home/*']
let g:rooter_patterns = ['=src']

" YAML files
let g:rooter_targets = '*.yml,*.yaml'

" Directories and YAML files
let g:rooter_targets = '/,*.yml,*.yaml'

" To exclude a pattern, prefix it with !
let g:rooter_patterns = ['!.git/worktrees', '!=extras', '!^fixtures', '!build/env.sh']

" Fzf
nnoremap <silent> <C-a> :Files<CR>
nnoremap <silent> <C-g> :GFiles<CR>
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Keys
nnoremap <Leader>w :up<CR>
nnoremap <Leader>e :25Lex<CR>
nnoremap :Q :q
nnoremap ; :
vnoremap ; :
nnoremap ç $
vnoremap ç $<left>
nmap ,p "0p
nmap ,P "0P

" Vimgrep and quickfix list
nnoremap <Leader>l :copen<CR>
nnoremap <Leader>] :cnext<CR>
nnoremap <Leader>[ :cprev<CR>
nnoremap <Leader>c :cclose<CR>
" Search the entire project for text to be written
nnoremap <F9>s :vimgrep // **/*.%:e<left><left><left><left><left><left><left><left><left><left>
" Search the entire project for text under cursor 
nnoremap <F9>c :vimgrep /<C-R><C-W>/ **/*.%:e <cr>
" Search and Replace text under cursor with text to be written with confirmation
nnoremap <F10>r :%s /<C-R><C-W>//gc<left><left><left>
" Search in current file for text to be written
nnoremap <F10>s :vimgrep //g %<left><left><left><left>
" Search in current file for text under cursor
nnoremap <F10>c :vimgrep /<C-R><C-W>/g % <cr>

" Reload config
nnoremap <Leader>r :source ~/.config/nvim/init.vim<CR>

" Tab bindings 
" nnoremap <Leader>t    :tabnew<CR>
" nnoremap <Leader>x    :tabclose<CR>
" nnoremap <Leader>j    :tabprevious<CR>
" nnoremap <Leader>k    :tabnext<CR>

" easy split generation
nnoremap <Leader>v    :vsplit
nnoremap <Leader>s    :split

" easy split navigation
" nnoremap <C-h>    <C-w>h
" nnoremap <C-l>    <C-w>l
" nnoremap <C-j>    <C-w>j
" nnoremap <C-k>    <C-w>k

" buffer navigation
nnoremap <Leader><tab> :Buffers<cr>
nnoremap <Tab>     :bnext <CR>
nnoremap <S-Tab>   :bprevious <CR>
nnoremap <Leader>d :bd! <CR>

" adjust split sizes easier
nnoremap <C-Left> :vertical resize +3<CR>
nnoremap <C-Right> :vertical resize -3<CR>

" Easy way to get back to normal mode from home row
inoremap kk <Esc>
inoremap jj <Esc>
inoremap kj <Esc>
inoremap jk <Esc>

" Shortcuts For coding
"
" Go testing func argument
autocmd FileType go inoremap ttt t *testing.T
" Java system console output
autocmd FileType java inoremap cwl Console.writeln("");<left><left><left>
autocmd FileType java inoremap sop System.out.println("");<left><left><left>
autocmd FileType java inoremap forc for( : <C-r>") {}<esc>^wa
autocmd FileType java inoremap fori for(int i=0; i < <C-r>".size(); i++) {<cr><cr>}<esc>kS

" Automatically close brackets, parenthesis, and quotes
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap /* /**/<left><left>
inoremap !! ![]()<left><left><left><c-r>+<right><right><c-r>+<right><cr><cr>
inoremap ** ****<left><left>
inoremap -[ - [ ] 

" Automatically surround with symbols
nnoremap <Leader>" viwdi"<ESC>pa"<ESC>
nnoremap <Leader>' viwdi'<ESC>pa'<ESC>
nnoremap <Leader>s[ viwdi[<ESC>pa]<ESC>
nnoremap <Leader>** viwdi**<ESC>pa**<ESC>
nnoremap <Leader>s{ viwdi{<ESC>pa}<ESC>
nnoremap <Leader>s( viwdi(<ESC>pa)<ESC>
nnoremap <Leader>s9 viwdi(<ESC>pa)<ESC>
nnoremap <Leader>< viwdi<<ESC>pa><ESC>
nnoremap <Leader>, viwdi<<ESC>pa><ESC>
nnoremap <Leader><down> :sort<CR><ESC>
nnoremap <Leader><up> :sort!<CR><ESC>

vnoremap <Leader>" di"<ESC>pa"<ESC>
vnoremap <Leader>' di'<ESC>pa'<ESC>
vnoremap <Leader>s[ di[<ESC>pa]<ESC>
vnoremap ** di **<ESC>pa**<ESC>
vnoremap <Leader>s{ di{<ESC>pa}<ESC>
vnoremap <Leader>s( di(<ESC>pa)<ESC>
vnoremap <Leader>s9 di(<ESC>pa)<ESC>
vnoremap < di <<ESC>pa><ESC>
vnoremap , di <<ESC>pa><ESC>
vnoremap <Leader><down> :sort<CR><ESC>
vnoremap <Leader><up> :sort!<CR><ESC>

nnoremap <c-j> :m .+1<CR>==
nnoremap <c-k> :m .-2<CR>==
vnoremap <c-j> :m '>+1<CR>gv=gv
vnoremap <c-k> :m '<-2<CR>gv=gv
inoremap <c-j> <Esc>:m .+1<CR>==gi
inoremap <c-k> <Esc>:m .-2<CR>==gi

" Format columns
vnoremap <leader>f :!column -t<cr> gv=

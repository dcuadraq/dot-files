set guioptions-=L
set guioptions=-l

set number " display line number

set relativenumber

"autocmd InsertEnter * :set number " when entering Insertmode show absolute num line
"autocmd InsertLeave * :set relativenumber " when leaving insertmode show relative line numbers

set colorcolumn=100 " highlight column #

:colorscheme slate

"set directory=~/tmp
"set backup=~/tmp

"custom maps
set backupskip=/tmp/*,/private/tmp/*
set directory=$HOME/.vim/tmp/swap
set undodir=$HOME/.vim/tmp/undo
set undofile

set ttyfast " faster scrolling
set lazyredraw " buffer screen updates instead of updating all the time

:set expandtab " soft tabs
:set tabstop=2 " soft tab = 2 spaces
:set shiftwidth=2 " > identantion

" Use numbers to pick the tab you want (In OS X replace M for D)
map <silent> <M-0> :tabn 0<cr>
map <silent> <M-1> :tabn 1<cr>
map <silent> <M-2> :tabn 2<cr>
map <silent> <M-3> :tabn 3<cr>
map <silent> <M-4> :tabn 4<cr>
map <silent> <M-5> :tabn 5<cr>
map <silent> <M-6> :tabn 6<cr>
map <silent> <M-7> :tabn 7<cr>
map <silent> <M-8> :tabn 8<cr>
map <silent> <M-9> :tabn 9<cr>

autocmd BufWritePre * :%s/\s\+$//e

autocmd Filetype gitcommit setlocal spell textwidth=72 "spell checking and automatic wrapping at the recommended 72 columns to you commit messages

" vim-plug
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
" Plug 'junegunn/seoul256.vim'
" Plug 'junegunn/vim-easy-align'

" Group dependencies, vim-snippets depends on ultisnips
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using git URL
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }

" Unmanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'

" Hard time
Plug 'https://github.com/takac/vim-hardtime.git'

call plug#end()

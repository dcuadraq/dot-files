" Shorcuts to remember
" gv = previous selection
" zz = sets current line in the middle of screen
" z<Enter> = sets current line at top of screen
" zt = sets current line at top of screen
" zb = sets current line at bottom of screen

set cursorcolumn
set cursorline
set ruler

set smartcase

" yanks uses OS clipboard
set clipboard=unnamed

set guioptions-=L
set guioptions=-l

set number " display line number

set relativenumber

"autocmd InsertEnter * :set number " when entering Insertmode show absolute num line
"autocmd InsertLeave * :set relativenumber " when leaving insertmode show relative line numbers

set colorcolumn=80 " highlight column #

set background=dark

" status line always visible
set laststatus=2

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

" sets vim update time to a higher frecuency than default (4s) for vim-gitgutter
set updatetime=250

" Ctrl + H/L moves to next tab
map <silent> <C-L> :tabnext <cr>
map <silent> <C-H> :tabprevious <cr>

" Use numbers to pick the tab you want (In OS X replace M for D)
" clashes with appending next line
map <silent> <D-0> :tabn 0<cr>
map <silent> <D-1> :tabn 1<cr>
map <silent> <D-2> :tabn 2<cr>
map <silent> <D-3> :tabn 3<cr>
map <silent> <D-4> :tabn 4<cr>
map <silent> <D-5> :tabn 5<cr>
map <silent> <D-6> :tabn 6<cr>
map <silent> <D-7> :tabn 7<cr>
map <silent> <D-8> :tabn 8<cr>
map <silent> <D-9> :tabn 9<cr>

" function to strip trailing whitespace, except for markdown
fun! StripTrailingWhitespace()
  " Don't strip on these filetypes
  if &ft =~ 'markdown' " :set filetype?  to see the curent filetype
    return
  endif
  %s/\s\+$//e
endfun

" My functions ----------------------------------
function! DeleteEmptyLines ()
  :g/^\s*\n/d
endfunction

function! DeleteComments()
  :g/^\s*#/d
endfunction
" -----------------------------------------------

"function! GitBranch()
  "return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
"endfunction

"function! StatuslineGit()
  "let l:branchname = GitBranch()
  "return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
"endfunction

"set statusline=
"set statusline+=%#PmenuSel#
"set statusline+=%{StatuslineGit()}
"set statusline+=%#LineNr#
"set statusline+=\ %f
"set statusline+=%m\
"set statusline+=%=
"set statusline+=%#CursorColumn#
"set statusline+=\ %y
"set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
"set statusline+=\[%{&fileformat}\]
"set statusline+=\ %p%%
"set statusline+=\ %l:%c
"set statusline+=\

" remove trailing whitespace on save
autocmd BufWritePre * call StripTrailingWhitespace()
"autocmd BufWritePre * :%s/\s\+$//e

autocmd Filetype gitcommit setlocal spell textwidth=72 "spell checking and automatic wrapping at the recommended 72 columns to you commit messages

" Jump to the next or previous line that has the same level or a lower
" level of indentation than the current line.
"
" exclusive (bool): true: Motion is exclusive
" false: Motion is inclusive
" fwd (bool): true: Go to next line
" false: Go to previous line
" lowerlevel (bool): true: Go to line with lower indentation level
" false: Go to line with the same indentation level
" skipblanks (bool): true: Skip blank lines
" false: Don't skip blank lines
function! NextIndent(exclusive, fwd, lowerlevel, skipblanks)
  let line = line('.')
  let column = col('.')
  let lastline = line('$')
  let indent = indent(line)
  let stepvalue = a:fwd ? 1 : -1
  while (line > 0 && line <= lastline)
    let line = line + stepvalue
    if ( ! a:lowerlevel && indent(line) == indent ||
          \ a:lowerlevel && indent(line) < indent)
      if (! a:skipblanks || strlen(getline(line)) > 0)
        if (a:exclusive)
          let line = line - stepvalue
        endif
        exe line
        exe "normal " column . "|"
        return
      endif
    endif
  endwhile
endfunction

" Moving back and forth between lines of same or lower indentation.
nnoremap <silent> [l :call NextIndent(0, 0, 0, 1)<CR>
nnoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<CR>
nnoremap <silent> [L :call NextIndent(0, 0, 1, 1)<CR>
nnoremap <silent> ]L :call NextIndent(0, 1, 1, 1)<CR>
vnoremap <silent> [l <Esc>:call NextIndent(0, 0, 0, 1)<CR>m'gv''
vnoremap <silent> ]l <Esc>:call NextIndent(0, 1, 0, 1)<CR>m'gv''
vnoremap <silent> [L <Esc>:call NextIndent(0, 0, 1, 1)<CR>m'gv''
vnoremap <silent> ]L <Esc>:call NextIndent(0, 1, 1, 1)<CR>m'gv''
onoremap <silent> [l :call NextIndent(0, 0, 0, 1)<CR>
onoremap <silent> ]l :call NextIndent(0, 1, 0, 1)<CR>
onoremap <silent> [L :call NextIndent(1, 0, 1, 1)<CR>
onoremap <silent> ]L :call NextIndent(1, 1, 1, 1)<CR>


call plug#begin('~/.vim/plugged')
" Javascript sytanx highlight
Plug 'https://github.com/pangloss/vim-javascript'

" JSX syntax highlight
Plug 'https://github.com/mxw/vim-jsx'

" Comment
Plug 'scrooloose/nerdcommenter'

" Status line
Plug 'vim-airline/vim-airline'

" Make sure you use single quotes
" Plug 'junegunn/seoul256.vim'
" Plug 'junegunn/vim-easy-align'

" Group dependencies, vim-snippets depends on ultisnips
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
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
" Plug 'https://github.com/takac/vim-hardtime.git'

" Solarized colorschemes
Plug 'altercation/vim-colors-solarized'

" Display identtation
Plug 'https://github.com/nathanaelkane/vim-indent-guides'

" Monokai colorscheme
Plug 'https://github.com/tomasr/molokai'

" Dependecy for unite, go to its folder and run 'make'
Plug 'Shougo/vimproc.vim'
" File searcher, requires ag the-silver-searcher installed
Plug 'Shougo/unite.vim'

" ag for vim
"Plug 'rking/ag.vim'

" Search and replace
Plug 'https://github.com/yegappan/greplace'

Plug 'tpope/vim-fugitive'

" Fuzzi finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install' }
Plug 'junegunn/fzf.vim'

" Cursor on terminal
Plug 'https://github.com/jszakmeister/vim-togglecursor'

" Marks modified lines from git
Plug 'https://github.com/airblade/vim-gitgutter'

" Sintaxis linter
"Plug 'https://github.com/scrooloose/syntastic'

" Required by vim-markdown
Plug 'godlygeek/tabular'
" Markdown syntax highlight
Plug 'plasticboy/vim-markdown'
"
Plug 'https://github.com/romainl/Apprentice'

" Markdown live
Plug 'shime/vim-livedown', { 'do': 'npm install -g livedown' }

" Surround
Plug 'tpope/vim-surround'

" Repeat makes . work with macros and some plugins
Plug 'tpope/vim-repeat'

" Switch panes tmux like
Plug 'https://github.com/t9md/vim-choosewin'

call plug#end()

" disables pre-folding on markdowns due to godlygeek/tabular
let g:vim_markdown_folding_disabled = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Javascript highlight
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Concealing characters
let g:javascript_conceal_function             = "ƒ"
let g:javascript_conceal_null                 = "ø"
let g:javascript_conceal_this                 = "@"
let g:javascript_conceal_return               = "⇚"
let g:javascript_conceal_undefined            = "¿"
let g:javascript_conceal_NaN                  = "ℕ"
let g:javascript_conceal_prototype            = "¶"
let g:javascript_conceal_static               = "•"
let g:javascript_conceal_super                = "Ω"
let g:javascript_conceal_arrow_function       = "⇒"
"let g:javascript_conceal_noarg_arrow_function = "🞅"
"let g:javascript_conceal_underscore_arrow_function = "🞅"

set conceallevel=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin JSX highlight
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:jsx_ext_required = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin mapping - scrooloose/nerdcommenter
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Trigger commenting on every mode
imap <leader>/ <esc><plug>NERDCommenterToggle<CR>i
nmap <leader>/ <plug>NERDCommenterToggle<CR>
vmap <leader>/ <plug>NERDCommenterToggle

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin set up - shime/vim-livedown
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Should markdown preview get shown automatically upon opening markdown buffer
let g:livedown_autorun = 1
" the browser to use
" let g:livedown_browser = "safari"
" the port on which Livedown server will run
let g:livedown_port = 1337

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin mapping - junegunn/fzf && junegunn/fzf-vim
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" List and select from file list
map <leader><tab> :Files<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin mapping - vim-choosewin
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" invoke with '-'
nmap  -  <Plug>(choosewin)
let g:choosewin_overlay_enable = 1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4

filetype plugin indent on
let g:hardtime_default_on = 1 " hard time from beginning

" Set initial colorscheme
":colorscheme molokai
" https://github.com/romainl/Apprentice
:colorscheme apprentice

" Unite configuration
let g:unite_source_history_yank_enable = 1
try
  let g:unite_source_rec_async_command='ag --nocolor --nogroup -g ""'
  call unite#filters#matcher_default#use(['matcher_fuzzy'])
catch
endtry
" search a file in the filetree
nnoremap <space><space> :split<cr> :<C-u>Unite -start-insert file_rec/async<cr>
" reset not it is <C-l> normally
:nnoremap <space>r <Plug>(unite_restart)


" ag configuration
" --- type ° to search the word in all files in the current dir
"nmap | :Ag <cr>=expand("<cword>")<cr><cr>
nnoremap <space>/ :Ag

" MOVE CODE UP AND DOWN
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" open a list of files, each on a new tab
" vim -p `git diff --name-only master`

" ~/.config/nvim/init.vim

"set nocompatible            " Disable compatibility to old-time vi
set showmatch               " Show matching brackets.
"set ignorecase              " Do case insensitive matching
set mouse=v                 " middle-click paste with mouse
set hlsearch                " highlight search results
set tabstop=2               " number of columns occupied by a tab character
set softtabstop=2           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=2            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
" set rnu                     " show relative numbers
set number " relativenumber   " show current line as absolute
set wildmode=longest,list   " get bash-like tab completions
set cc=80                   " column mark
set cursorcolumn            " highlight for current column
set list                    " highlight trailing whitespace and tabs
set conceallevel=1          " might not be needed
set nowrap                  " disables word wrap
set cursorline              " highlights current line
set conceallevel=0          " display quotes on JSON



" Space as leader key
let mapleader = "\<Space>"
" let localmapleader = "\<Space>"
nnoremap <leader>f :Files <cr>
nnoremap <leader>t :Tags <cr>
nnoremap <leader>s :Ag <cr>
nnoremap <leader>w :W <cr>
nnoremap <leader>q :ChooseWin <cr>
nnoremap <leader>e :Explore <cr>
nnoremap <leader><leader> :Commands <cr>
nnoremap <leader>r :source $MYVIMRC <cr>

" remaps Ctrl-] to go-to-definition, if only 1 match, jumps directly
" <c-r><C-w> takes word under cursor
map <silent> <C-]> :tjump <c-r><C-w> <cr>

" moves selection
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv

au BufLeave * silent! wall " autosave when leaving buffer/pane

" reloads buffers when changed outside vim
set autoread
autocmd FocusGained * checktime

" Resize buffers if vim is resized
autocmd VimResized * :wincmd =

" Zoom a vim pane
nnoremap <leader>z :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

" Ctrl + H/L moves to next tab
" On Explorer overrides Causes Netrw to refresh the directory listing |netrw-ctrl-l|
map <silent> <C-L> :tabnext <cr>
" On Explorer overrides Edit file hiding list |netrw-ctrl-h|
map <silent> <C-H> :tabprevious <cr>

" function to strip trailing whitespace, except for markdown
fun! StripTrailingWhitespace()
  " Don't strip on these filetypes
  if &ft =~ 'markdown' " :set filetype?  to see the curent filetype
    return
  endif
  %s/\s\+$//e
endfun

" remove trailing whitespace on save
autocmd BufWritePre * call StripTrailingWhitespace()

" NeoVim fix to change the color of the cursorcolumn
function CorrectColorScheme()
  highlight CursorColumn ctermbg=Black
endfunction
autocmd VimEnter * call CorrectColorScheme()

" Auto install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
  " Color theme based on Visual Studio
  " Plug 'tomasiser/vim-code-dark'

  " Color theme
  " Plug 'Nequo/vim-allomancer'

  " Color theme
  " Plug 'aonemd/kuroi.vim'

  " Color theme
  " Plug 'gkapfham/vim-vitamin-onec'

  " Color theme
  Plug 'sonph/onehalf', { 'rtp': 'vim/' }

  " Color theme
  Plug 'liuchengxu/space-vim-dark'

  " JSX syntax highlight
  Plug 'mxw/vim-jsx'

  " Async linter
  Plug 'w0rp/ale'

  " Tmux like buffer navigation
  " Plug 't9md/vim-choosewin'

  " Avoid key binding crash with tmux
  Plug 'christoomey/vim-tmux-navigator'

  " Highlights indentations
  Plug 'Yggdroot/indentLine'

  " Fuzzi finder
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install' }
  Plug 'junegunn/fzf.vim'

  " ferret
  Plug 'wincent/ferret'

  " Pretty command for JS code
  Plug 'prettier/vim-prettier'

  " insert or delete brackets, parens, quotes in pair
  Plug 'jiangmiao/auto-pairs'

  " Git wrapper
  Plug 'tpope/vim-fugitive'

  " Git branch viewer
  Plug 'rbong/vim-flog'

  " Git Fugitive extension to manage Git branches
  Plug 'idanarye/vim-merginal'

  " Shows a git diff in the gutter (sign column)
  Plug 'airblade/vim-gitgutter'

  " for surrounding
  Plug 'tpope/vim-surround'

  " for commenting
  Plug 'tpope/vim-commentary'

  " easily search for, substitute, and abbreviate multiple variants of a word
  Plug 'tpope/vim-abolish'

  " enable repeating supported plugin maps with .
  Plug 'tpope/vim-repeat'

  " Ruby on Rails power tools
  Plug 'tpope/vim-rails'

  " A set of mappings for HTML, XML, PHP, ASP, eRuby, JSP, and more (formerly allml)
  Plug 'tpope/vim-ragtag'

  " Asynchronous build and test dispatcher
  Plug 'tpope/vim-dispatch'

  " Search and replace across files
  Plug 'skwp/greplace.vim'

  " Swift
  Plug 'keith/swift.vim'

  " CSV
  Plug 'chrisbra/csv.vim'

  " Line at bottom
  " Plug 'vim-airline/vim-airline'

  " Zen HTML
  Plug 'mattn/emmet-vim'

  " Rainbow Parentheses
  Plug 'luochen1990/rainbow'

  " Smooth scrolling
  " Plug 'psliwka/vim-smoothie'

  " Context
  Plug 'wellle/context.vim'

  " JSX
  Plug 'MaxMEllon/vim-jsx-pretty'

  " Multi line
  Plug 'mg979/vim-visual-multi', {'branch': 'master'}

call plug#end()

" ************************
" Config for plugins
" ************************
"
" ******************
" mxw/vim-jsx config
" ******************
" higlight for JS files
let g:jsx_ext_required = 0


" ******************
" tomasiser/vim-code-dark config
" ******************
" sets the colorscheme
" colorscheme codedark
" set termguicolors

" ******************
" Nequo/vim-allomancer config
" ******************
" sets the colorscheme
" set termguicolors
" colo allomancer

" ******************
" aonemd/kuroi.vim config
" ******************
" sets the colorscheme
" set termguicolors
" set background=dark   "or use the light theme: set background=light
" colorscheme kuroi

" ******************
" sonph/onehalf config
" ******************
set termguicolors
" colorscheme onehalfdark
" let g:airline_theme='onehalfdark'

" ******************
" liuchengxu/space-vim-dark config
" ******************
colorscheme space-vim-dark

" ******************
" t9md/vim-choosewin config
" ******************
" sets key combo
nmap _ <Plug>(choosewin)

" ******************
" 'Yggdroot/indentLine' config
" ******************
" sets indentation character
let g:indentLine_char = '¦' " other options: ¦, ┆, │, ⎸, or ▏

" if you want to use overlay feature
let g:choosewin_overlay_enable = 1

" ******************
" 'junegunn/fzf.vim' config
" ******************
" points to fzf installation folder
set rtp+=~/.fzf

" Prettier conf
let g:prettier#autoformat = 0
" autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql PrettierAsync
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#jsx_bracket_same_line = 'false'

" ******************
" 'w0rp/ale' config
" ******************
let g:ale_completion_enabled = 1
let g:ale_lint_on_text_changed = 'never'
" let g:ale_linters = {'javascript': ['flow', 'eslint']}
"
" ******************
" luochen1990/rainbow config
" ******************
" activate
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

" ******************
" Aliases
" ******************
command Gs Gstatus
command Gd Gdiff

" Use \z to fold everything but matching lines of last search
nnoremap \z :setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\\|\\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2<CR>

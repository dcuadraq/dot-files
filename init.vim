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
set rnu                     " show relative numbers
set number relativenumber   " show current line as absolute
set wildmode=longest,list   " get bash-like tab completions
set cc=80                   " column mark
set cursorcolumn            " highlight for current column
set list                    " highlight trailing whitespace and tabs
set conceallevel=1          " might not be needed
set nowrap                  " disables word wrap
set cursorline              " highlights current line

au BufLeave * silent! wall " autosave when leaving buffer/pane

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

" NeoVim fix to change the color of the cursorcolumn
function CorrectColorScheme()
  highlight CursorColumn ctermbg=Black
endfunction
autocmd VimEnter * call CorrectColorScheme()

call plug#begin()
  " Color theme based on Visual Studio
  Plug 'tomasiser/vim-code-dark'

  " JSX syntax highlight
  Plug 'mxw/vim-jsx'

  " Async linter
  Plug 'w0rp/ale'

  " Tmux like buffer navigation
  Plug 't9md/vim-choosewin'

  " Highlights indentations
  Plug 'Yggdroot/indentLine'

  " Fuzzi finder
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install' }
  Plug 'junegunn/fzf.vim'

  " Pretty command for JS code
  Plug 'prettier/vim-prettier'

  " insert or delete brackets, parens, quotes in pair
  Plug 'jiangmiao/auto-pairs'

  " Git wrapper
  Plug 'tpope/vim-fugitive'

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
colorscheme codedark

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
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql PrettierAsync
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#jsx_bracket_same_line = 'false'

let g:ale_completion_enabled = 1
" let g:ale_linters = {'javascript': ['flow', 'eslint']}

" ******************
" Aliases
" ******************
command Gs Gstatus
command Gd Gdiff

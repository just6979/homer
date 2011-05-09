" justin's Vim prefs

" my terminals are usually white on black
set background=dark
" turn on syntax highlighting, duh
syntax on
" use just \n for line endings
set fileformat=unix
" create folds for multiple indented lines. great for python
"set foldmethod=indent
"set foldlevel=6
" highlight search terms, makes * work great
set hlsearch
" search as you type
set incsearch
" show line numbers
set number
" Toggle line numbers and fold column for easy copying:
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>

highlight LineNr term=bold cterm=none ctermfg=black ctermbg=gray gui=none guifg=black guibg=gray
" turn on the info-ruler at the bottom
set ruler
" hit F3 to have Vim no autoindent pasted text
set pastetoggle=<F3>
" keep two lines of context above or below the cursor when scrolling
set scrolloff=2
" show what Vim's doing
set showcmd
set showmode

" turn on visual mouse
set mouse=a

" set indent stuff to work with 4 spaces per tab
set shiftwidth=4
set tabstop=4
set autoindent
set smartindent
set backspace=2
set linebreak
set expandtab
set smarttab
filetype indent on

set history=100

" because my pinky is often slow to release shift :P
map :Wq		:wq
map :Wq!	:wq!
map :WQ 	:wq
map :WQ!	:wq!
map :W		:w
map :W!		:w!
map :Q		:q
map :Q!		:q!


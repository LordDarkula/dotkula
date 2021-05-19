" =====================================
" Vim Configuration
" Author: Aubhro Sengupta (lorddarkula)
" Email: hello@aubhro.com
" Website: https://aubhro.me
" =====================================


" Basic options
" -------------

" turns off legacy vi support
set nocompatible
" auto-detect filetype
filetype on
" allow backspace over autoindents, line breaks, start of indent
set backspace=indent,eol,start
" disable bells
set noerrorbells
set vb
" start searching while typing
set incsearch
" colors
syntax enable
" enable netrw and file type detection
filetype plugin on

" Appearance
" ----------

" line numbers
set number relativenumber
" enable cursor line
set cursorline
" use jellybeans if installed or else use elflord
try
	colorscheme jellybeans
catch
	colorscheme elflord
endtry

" Status Line
" -----------

" Status line construction
let g:currentmode={
	\ 'n'  : 'Normal ',
	\ 'v'  : 'VISUAL ',
	\ 'V'  : 'V·Line ',
	\ '' : 'V·Block ',
	\ 'i'  : 'INSERT ',
	\ 'R'  : 'Replace ',
	\ 'Rv' : 'V·Replace ',
	\ 'c'  : 'Command ',
	\}

" permanently show status line
set laststatus=2

" status line construction
set statusline=

" left side
" edit mode
set statusline+=\ %{get(g:currentmode,mode(),'V-Block')}
" full path to current buffer
set statusline+=\ %f
" add [+] if current buffer is modified
set statusline+=%{&modified?'[+]':''}
" line number
set statusline+=:%l
"column number
set statusline+=.%c

" right side
set statusline+=%=
" place in the file
set statusline+=\ %P

" Indentation
" -----------

" turn on autoindent
set autoindent
" smarter automatic indenting
set smartindent
" stricter indent specifically for c
autocmd FileType c,cpp silent! set cindent

" Tabs and Spaces
" ---------------

" tabs show as 4 spaces by
set tabstop=2
" tabs are hard tabs
set noexpandtab
" shift > is equal to 4 spaces
set shiftwidth=2
" newline tabs and backspaces will be equivalent to shiftwidth
set smarttab

" file specific settings
autocmd FileType py,pyw,python silent! set expandtab tabstop=4 shiftwidth=4

" Multiple Files
" -------------

" Search through subdirectories
set path+=**
" Display matching file names when using tab complete
set wildmenu
" Ignore unimportant directories
set wildignore+=**/.git/**
set wildignore+=**/node_modules/**
set wildignore+=**/__pycache__/**
set wildignore+=**/*.out/**

" opens new panes below and to the right of currently open panes
set splitbelow
set splitright

" Netrw
" -----
let g:netrw_banner = 0
let g:netrw_liststyle = 3

" opens new netrw buffers below and to the right of currently open buffers
let g:netrw_altv = 1
let g:netrw_alto = 1

" Highlighting
" ------------

" Highlight mutt config files
au BufRead,BufNewFile *.muttrc,*.mutt set filetype=muttrc

" whitespace hightlighted in white
highlight ExtraWhitespace ctermbg=white guibg=white
autocmd BufEnter * silent! 2match ExtraWhitespace /\s\+$/

" tabs highlighted in grey
highlight Tabs ctermbg=darkgrey guibg=darkgrey
autocmd BufEnter * silent! match Tabs /\t\+$/

" Custom Keybindings
" ------------------

" map leader key to space
" leader used as a prefix for user keymaps
let mapleader = " "

" scroll up and down with Control+(k/j)
nnoremap <C-J> <C-d>
nnoremap <C-K> <C-u>

" buffers
" open buffer list
nnoremap <leader>a :ls<CR>
" open netrw
nnoremap <leader>e :E<CR>
" open new buffer with find
nnoremap <leader>f :find<Space>
" switch buffers
nnoremap <leader>b :b<Space>
nnoremap <leader>n :bnext<CR>
nnoremap <leader>N :bprev<CR>
" close currently open buffer
nnoremap <leader>q :bd<CR>

" window splitting
nnoremap <leader>sp :Sexplore<CR>
nnoremap <leader>vs :Lexplore<CR>

" window switching
nnoremap <leader><Space> <C-W><C-W>
nnoremap <leader>h <C-W><C-H>
nnoremap <leader>j <C-W><C-J>
nnoremap <leader>k <C-W><C-K>
nnoremap <leader>l <C-W><C-L>

" disable arrow keys
noremap <Up>	<Nop>
noremap <Down> 	<Nop>
noremap <Left>	<Nop>
noremap <Right> <Nop>

" Additional Options
" ------------------
" auto-reload file after cursor stops moving
au CursorHold,CursorHoldI * checktime

" rename tmux tab name to filename
autocmd BufEnter,BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window " . expand("%:t"))
autocmd BufLeave,BufWinLeave * call system("tmux rename-window $(basename $SHELL)")


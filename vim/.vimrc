" =====================================
" Author: Aubhro Sengupta (lorddarkula)
" Vim Configuration
" Email: hello@aubhro.com
" Website: https://aubhro.me
" =====================================


" No Plugins
" ----------

" enable netrw and file type detection
filetype plugin on
" turn on basic syntax highlighting
syntax on


" Basic Options
" -------------

" turns off legacy vi support
set nocompatible

" allow backspace over indents, line breaks, start of indent
set backspace=indent,eol,start

" disallow cursor from going to first or last line on screen
set scrolloff=1

" disable bells
set noerrorbells
set novisualbell

" when file is changed by external source, reload it in vim
set autoread
" autowrite current buffer when switching buffers
set autowrite


" Indentation
" -----------

" turn on autoindent
set autoindent
" smarter automatic indenting
set smartindent
" stricter indent specifically for c
autocmd FileType h,c,cc,cpp silent! set cindent


" Tabs and Spaces
" ---------------

" Scenario 4 in :help tabstop
" Insert hard tabs by default (shows up as 2 spaces)
" However, if the file already uses spaces, stick to them
set tabstop=2
set noexpandtab
set shiftwidth=2
set smarttab


" External Files
" --------------

" swapfile stores changes before saving so they can be recovered if unsaved
" however, they can cause conflicts if vim quits unexpectedly.
" I save my changes regularly so it is unneeded
" Opening multiple buffers also litters the filesystem with swapfiles.
set noswapfile

" undofile stores change history so they can be reverted after saving
" and closing vim
set undofile

" backups slow down vim and are made redundant by version control
set nobackup
set nowritebackup


" Appearance
" ----------

" line numbers
set number relativenumber

" highlight line of cursor so it can be seen at all times
set cursorline

" mode is show in status bar and is not needed to be shown on last line
set noshowmode

" use jellybeans if installed or else use elflord
try
	colorscheme jellybeans
catch
	colorscheme elflord
endtry

" Search
" ------

" start searching while typing
set incsearch
" highlight / searches
set hlsearch
" ignore case in / searches
set ignorecase


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
autocmd BufRead,BufNewFile *.muttrc,*.mutt set filetype=muttrc

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


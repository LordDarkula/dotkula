" =====================================
" Neovim Configuration (init.vim)
" Author: Aubhro Sengupta (lorddarkula)
" Email: hello@aubhro.com
" Website: https://aubhro.me
" =====================================


" Vim-plug Setup
" --------------

if &compatible
  set nocompatible " Be iMproved
endif

call plug#begin()

" sensible defaults above set nocompatible
Plug 'tpope/vim-sensible'

" auto detect tabs vs spaces
Plug 'tpope/vim-sleuth'

" colorscheme
Plug 'nanotech/jellybeans.vim'

" advanced highlighting
Plug 'sheerun/vim-polyglot'

" Rainbow brackets
Plug 'frazrepo/vim-rainbow'

" Status bar
Plug 'itchyny/vim-gitbranch'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'

Plug 'preservim/tagbar'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()

filetype plugin indent on
syntax enable


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
autocmd FileType c,cpp silent! set cindent


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

" show tabs if there are multiple tabs
set showtabline=1


" map leader key to space
" leader used as a prefix for user keymaps
let mapleader = " "

" Plugin setup
" ------------

" Lightline

set noshowmode
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'filetype', 'lineinfo' ] ],
      \	  'right': [ ],
      \ },
      \ 'component_function': {
      \   'gitbranch': 'GitBranchTruncated',
      \	  'filename': 'LightlineFilename',
      \ },
      \ 'inactive': {
      \   'left': [ [ 'filename', 'lineinfo' ] ],
      \	  'right': [ ],
      \ },
      \ 'tabline': {
      \   'left': [ ['buffers'] ],
      \   'right': [ ['close'] ]
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ }
      \ }

function! GitBranchTruncated()
  return gitbranch#name()[0:7]
endfunction

" combined filename and modified status
function! LightlineFilename()
  let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
  let modified = &modified ? '[+]' : ''
  return modified[0:30] . filename
endfunction

" Rainbow

" enable vim rainbow
let g:rainbow_active = 1

" Set custom vim rainbow colors
let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick']
let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']

" FZF

let g:fzf_preview_window = ['right:50%', 'ctrl-/']
let g:fzf_layout = {'down': '40%'}

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --ignore-vcs --hidden --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)


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

" whitespace hightlighted in white
highlight ExtraWhitespace ctermbg=yellow guibg=yellow
autocmd BufWinEnter * silent! 2match ExtraWhitespace /\s\+$/

" tabs highlighted in grey
highlight Tabs ctermbg=darkgrey guibg=darkgrey
autocmd BufWinEnter * silent! match Tabs /\t\+$/

" lines longer than 80 chars highlighted on char 81
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

" Custom Keybindings
" ------------------

" scroll up and down with Control+(k/j)
nnoremap <C-J> <C-d>
nnoremap <C-K> <C-u>

nnoremap J ddp
nnoremap K ddkP

nnoremap <leader>m :<C-u>marks<CR>:normal! `

" buffers
" open buffer list
nnoremap <leader>a :ls<CR>
" open netrw
nnoremap <leader>e :Explore<CR>
" open new buffer with find
nnoremap <leader>f :Files<CR>
" switch buffers
nnoremap <leader>b :Buffers<CR>
nnoremap <C-l> :bnext<CR>
nnoremap <C-h> :bprev<CR>
" close currently open buffer
nnoremap <leader>q <C-W>q

" tagbar
nnoremap <leader>t :TagbarToggle<CR>

" window splitting
nnoremap <leader>sp :Sexplore<CR>
nnoremap <leader>vs :Vexplore!<CR>

" window switching
nnoremap <leader><Space> <C-W><C-W>
nnoremap <leader>h <C-W><C-H>
nnoremap <leader>j <C-W><C-J>
nnoremap <leader>k <C-W><C-K>
nnoremap <leader>l <C-W><C-L>

" disable arrow keys
noremap <Up>		<Nop>
noremap <Down> 	<Nop>
noremap <Left>	<Nop>
noremap <Right> <Nop>


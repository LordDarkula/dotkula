" =====================================
" Neovim Configuration (init.vim)
" Author: Aubhro Sengupta (lorddarkula)
" Email: hello@aubhro.com
" Website: https://aubhro.me
" =====================================


" dein Setup
" ------------
if &compatible
  set nocompatible " Be iMproved
endif

" Required:
" Add the dein installation directory into runtimepath
set runtimepath+={path to dein.vim directory}

" Required:
call dein#begin({path to plugin base path directory})

" Let dein manage dein
call dein#add({path to dein.vim directory})
if !has('nvim')
  call dein#add('roxma/nvim-yarp')
  call dein#add('roxma/vim-hug-neovim-rpc')
endif

" Add or remove your plugins here like this:
"call dein#add('Shougo/neosnippet.vim')
"call dein#add('Shougo/neosnippet-snippets')

" sensible defaults above set nocompatible
call dein#add('tpope/vim-sensible')

" auto detect tabs vs spaces
call dein#add('tpope/vim-sleuth')

" colorscheme
call dein#add('nanotech/jellybeans.vim')

" advanced highlighting
call dein#add('sheerun/vim-polyglot')

" Rainbow brackets
call dein#add('frazrepo/vim-rainbow')

" Status bar
call dein#add('itchyny/lightline.vim')

" Telescope (fuzzy file finding)
call dein#add('nvim-lua/plenary.nvim')
call dein#add('nvim-telescope/telescope.nvim')

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" Basic Options
" -------------

" Do not use swap file to avoid conflicts
set noswapfile

" if hard tabs are used, show them as 2 spaces
set tabstop=2
set shiftwidth=2

" line numbers
set number

" do not highlight search
set nohlsearch

"set colorscheme
colorscheme jellybeans

" map leader key to space
" leader used as a prefix for user keymaps
let mapleader = " "

" Plugin setup
" ------------

" Lightline

set noshowmode
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ }

" Rainbow

" enable vim rainbow
let g:rainbow_active = 1

" Set custom vim rainbow colors
let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick']
let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']


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

" buffers
" open buffer list
nnoremap <leader>a :ls<CR>
" open netrw
nnoremap <leader>e :Explore<CR>
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

" Additional Options
" ------------------
" auto-reload file after cursor stops moving
autocmd BufWritePost,CursorHold,CursorHoldI * checktime

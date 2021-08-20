" =====================================
" Neovim Configuration (init.vim)
" Author: Aubhro Sengupta (lorddarkula)
" Email: hello@aubhro.com
" Website: https://aubhro.me
" =====================================


" Vundle Setup
" ------------

" Install vundle by cloning git repository
command InstallVundle !git clone https://github.com/VundleVim/Vundle.vim.git ~/.config/nvim/bundle/Vundle.vim

" necessary options for vundle
set nocompatible
filetype off

" Put vundle runtime path in neovim config folder
set rtp+=~/.config/nvim/bundle/Vundle.vim

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" My plugins
" ----------

" sensible defaults above set nocompatible
Plugin 'tpope/vim-sensible'

" Custom start page
Plugin 'mhinz/vim-startify'

" auto detect tabs vs spaces
Plugin 'tpope/vim-sleuth'

" colorschemes
Plugin 'nanotech/jellybeans.vim'
Plugin 'bluz71/vim-moonfly-colors'

" advanced highlighting
Plugin 'sheerun/vim-polyglot'

Plugin 'itchyny/lightline.vim'
" Status bar
"Plugin 'vim-airline/vim-airline'
" Plugin 'vim-airline/vim-airline-themes'

" Neovim lsp support
" Plugin 'nvim-lspconfig'

" Rainbow brackets
Plugin 'frazrepo/vim-rainbow'

Plugin 'airblade/vim-gitgutter'

call vundle#end()
filetype plugin indent on

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
syntax enable
colorscheme jellybeans

" map leader key to space
" leader used as a prefix for user keymaps
let mapleader = " "

" Plugin setup
" ------------

" Startify

" Do not change to directory when opening a file from startify
let g:startify_change_to_dir = 0
let g:startify_change_to_vcs_root = 1

" Airline

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

" Custom Keybindings
" ------------------

" scroll up and down with Control+(k/j)
nnoremap <C-J> <C-d>
nnoremap <C-K> <C-u>

autocmd FileType c,cpp,java silent! nnoremap { {}<Left>

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


" Setup plugins via Vundle
set nocompatible
filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'chase/vim-ansible-yaml'
Plugin 'rodjek/vim-puppet'
Plugin 'tpope/vim-scriptease'
Plugin 'tpope/vim-sensible'
Plugin 'scrooloose/syntastic'
Plugin 'godlygeek/tabular'
Plugin 'flazz/vim-colorschemes'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tmux-plugins/tmux-resurrect'
Plugin 'fatih/vim-go'
Plugin 'majutsushi/tagbar'
Plugin 'garyburd/go-explorer'
Plugin 'vim-airline/vim-airline'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

filetype on
" Make Vim more useful
set nocompatible
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
"set clipboard=unnamed
" Enhance command-line completion
set wildmenu
" Allow cursor keys in insert mode
set esckeys
" Allow backspace in insert mode
set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
" Add the g flag to search/replace by default
set gdefault
" Use UTF-8 without BOM
set encoding=utf-8 nobomb
" Change mapleader
let mapleader=","
" Don’t add empty newlines at the end of files
set binary
set noeol
" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
	set undodir=~/.vim/undo
endif

 filetype plugin indent on

 let g:syntastic_always_populate_loc_list = 1
 let g:syntastic_auto_loc_list = 1
 let g:syntastic_check_on_open = 1
 let g:syntastic_check_on_wq = 0
" Fix for go-vim
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
let g:go_list_type = "quickfix"

 colorscheme obsidian

 set laststatus=2
 set statusline=
 set statusline +=%5*%{&ff}%*            "file format
 set statusline +=%3*%y%*                "file type
 set statusline +=\ %{fugitive#statusline()} "show git branch
 set statusline +=%*
 set statusline +=%4*\ %<%F%*            "full path
 set statusline +=%#warningmsg#
 set statusline +=\ %{SyntasticStatuslineFlag()}
 set statusline +=%*
 set statusline +=%1*%=%5l%*             "current line
 set statusline +=%2*/%L%*               "total lines
 set statusline +=%1*%4v\ %*             "virtual column number
 set statusline +=%2*0x%04B\ %*          "character under cursor
 set statusline +=%*


" Respect modeline in files
set modeline
set modelines=4
" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure
" Enable line numbers
"set number
" Enable syntax highlighting
syntax on
" Highlight current line
" set cursorline
" indent using two spaces
set shiftwidth=4
" Make tabs as wide as two spaces
set tabstop=4
" always expand tabs into spaces
set expandtab
set softtabstop=0
" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_,extends:>,precedes:<
" set list
" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase
" Highlight dynamically as pattern is typed
set incsearch
" Always show status line
set laststatus=2
" Disable mouse in all modes
set mouse=""
" Disable error bells
set noerrorbells
" Show visual bells
set visualbell
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler
" Don’t show the intro message when starting Vim
set shortmess=atI
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
set titleold=""
" Show the (partial) command as it’s being typed
set showcmd
" Don't use relative line numbers
if exists("&relativenumber")
	set norelativenumber
"	au BufReadPost * set relativenumber
endif
" Start scrolling three lines before the horizontal window border
set scrolloff=3
" Set key to toggle paste mode
set pastetoggle=<F11>

" Strip trailing whitespace (,ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>
" Save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

" Automatic commands
if has("autocmd")
	" Enable file type detection
	filetype on
	" Treat .json files as .js
	autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
	autocmd BufEnter * let &titlestring = $HOSTNAME . ":" . expand("%:p:~")
  autocmd FileType make setlocal noexpandtab
endif

" Colours
if has('gui_running')
  set background=light
else
  set background=dark
endif
" colorscheme solarized
set rtp+=/usr/lib/python2.7/site-packages/Powerline-beta-py2.7.egg/powerline/bindings/vim

if &term == "xterm" || &term == "vt220" || &term == "xterm-256color"
  " Let the title stuff work even if we don't open the DISPLAY
  set title
  set t_ts=]2;
  set t_fs=
endif

" Tab navigation like Firefox.
nnoremap <C-t>     :tabnew<CR>
inoremap <C-t>     <Esc>:tabnew<CR>

" go-vim highlighting
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"

" go-vim key-map
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)

" ------------------
"  VUNDLE CONFIG's
"  -----------------
"
set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

" -----------------
" Enabling plugins
" -----------------
"
" Plugin for folding code
Plugin 'tmhedberg/SimpylFold'

" Plugin for Auto-Indentation
" Autoindent will help, but in some cases (like when a function signature spans multiple lines),
" it doesn’t always do what you want, especially when it comes to conforming to PEP 8 standards. To fix that, you can use the indentpython.vim extension:
Plugin 'vim-scripts/indentpython.vim'

" Auto-Complete
" The best plugin for Python auto-complete is YouCompleteMe
" Under the hood, YouCompleteMe uses a few different auto-completers
" (including Jedi for Python), and it needs some C libraries to be installed for it to work correctly.
" Needs sudo apt install build-essential cmake python3-dev to work properly

Bundle 'Valloric/YouCompleteMe'
" Ensures that the auto-complete window goes away when you’re done with it,
" and the second defines a shortcut for goto definition.
let g:ycm_autoclose_preview_window_after_completion=1

" Syntax Checking/Highlighting
Plugin 'vim-syntastic/syntastic'

" Checking PEP 8 with this nifty little plugin:
Plugin 'nvie/vim-flake8'

" File Browsing
Plugin 'scrooloose/nerdtree'
" Show git info at nerdtree
Plugin 'Xuyuanp/nerdtree-git-plugin'

" Super Searching
" Want to search for basically anything from VIM? Check out ctrlP:
" As you might expect, pressing Ctrl+P will enable the search, so you can just start typing.
Plugin 'kien/ctrlp.vim'

" Powerline
" Powerline is a status bar that displays things like the current virtualenv,
" git branch, files being edited, and much more.
" It’s written in Python, and it supports a number of other environments
" like zsh, bash, tmux, and IPython:
"Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
"
" Powerline alternative, lightweight powerline.
" https://github.com/vim-airline/vim-airline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" The following to your vimrc to enable Smarter tab line
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'


"This plugin is used for handling column separated data with Vim.
"Usually those files are called csv
"https://github.com/chrisbra/csv.vim
Plugin 'chrisbra/csv.vim'

Plugin 'jeffkreeftmeijer/vim-numbertoggle'

" Color Schemes
Plugin 'arcticicestudio/nord-vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" -------------
" VIM CONFIG's
" -------------
"
" Line Numbering
" Turn on line numbers on the side of the screen with:
set nu

" split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Key combos:
" Ctrl+J move to the split below
" Ctrl+K move to the split above
" Ctrl+L move to the split to the right
" Ctrl+H move to the split to the left

" Enable plugin for folding and enabling folding with the spacebar instead of za
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

" To add the proper PEP 8 indentation
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

" This will give you the standard four spaces when you hit tab, 
" ensure your line length doesn’t go beyond 80 characters, and  store the
" file in a Unix format so you don’t get a bunch of conversion issues when
"  checking into GitHub and/or sharing with other users.

" For full stack development, you can use another au command for each filetype:

au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2
" This way, you can have different settings for different filetypes.
" There is also a plugin called ftypes that will allow you to have a separate
" file for each filetype you want to maintain settings for, so use that if you see fit.

" Open NerdTree with one key
nmap <F1> :NERDTreeToggle<CR>

" -----------------
" PYTHON CONFIG's
" -----------------
" Virtualenv Support
" One issue with the goto definition above is that VIM, by default, doesn’t know anything about virtualenv, so you have to make VIM and YouCompleteMe aware of your virtualenv by adding the following lines of code to .vimrc:

" Python with virtualenv support
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

" This determines if you are running inside a virtualenv, switches to that specific virtualenv, and then sets up your system path so that YouCompleteMe will find the appropriate site packages.

" Finally, make your code look pretty:
let python_highlight_all=1
syntax on

" Want to hide .pyc files? Then add the following line:
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" Set Nord colorscheme
colorscheme nord

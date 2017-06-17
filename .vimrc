" Based on:
" https://realpython.com/blog/python/vim-and-python-a-match-made-in-heaven/

set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
"
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
"
" Add all your plugins here (note older versions of Vundle used Bundle
" instead of Plugin)
"
"
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"----------------------------------------------------------------------------------------
" All plugins

" Auto-Indentation
Plugin 'vim-scripts/indentpython.vim'

"----------------------------------------------------------------------------------------
" Auto-complete
" The best plugin for Python auto-complete is YouCompleteMe. Again, use Vundle
" to install:
" Under the hood YouCompleteMe uses a few different auto-completers (including
" Jedi for Python), and it needs some C libraries to be installed for it to
" work correctly. The docs have very good installation instructions so I won’t
" repeat them here, but be sure you follow them.
Bundle 'Valloric/YouCompleteMe'

"----------------------------------------------------------------------------------------
" It works out of the box pretty well, but let’s add a few customizations:
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
" The former line ensures that the autocomplete window goes away when you’re done with it,
" and the latter defines a shortcut for goto definition.
" My leader key is mapped to space, so space-g will goto definition of whatever
" I’m currently on. Helpful when exploring new code.

" Syntax Checking/Highlighting
" You can have VIM check your slly, make your code look pretty:
"
" let python_highlight_all=1
" syntax onyntax on each save with the syntastic extension:
"
Plugin 'scrooloose/syntastic'

"----------------------------------------------------------------------------------------
" Also add PEP8 checking with this nifty little plugin:

Plugin 'nvie/vim-flake8'


"-------------------------------------------------------------------------------------
" Color Schemes
" Color schemes work in conjunction with the basic color scheme that you are using. Check out solarized for GUI mode, and Zenburn for terminal mode:

Plugin 'morhetz/gruvbox'
colorscheme gruvbox
set background=dark

"call togglebg#map("<F5>")
"
"-------------------------------------------------------------------------------------
" File Browsing
" If you want a proper file tree then NERDTree is the way to go.

Plugin 'scrooloose/nerdtree'
" And if you want to use tabs, utilize vim-nerdtree-tabs:

Plugin 'jistr/vim-nerdtree-tabs'
" Want to hide .pyc files? Then add the following line:

let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

"-------------------------------------------------------------------------------------
" Super Searching
" Want to search for basically anything from VIM? Check out ctrlP:

Plugin 'kien/ctrlp.vim'
" As expected, press Ctrl-P to enable the search and then just start typing. If your search matches anything close to the 
" file you’re looking for, it will find it. Oh – and it’s not just files; it will find tags as well! 
" For more, check out this http://www.youtube.com/watch?v=9XrHk3xjYsw

"-------------------------------------------------------------------------------------
" Git Integration
" Want to perform basic git commands without leaving the comfort of VIM? Then vim-fugitive is the way to go:

Plugin 'tpope/vim-fugitive'

"-------------------------------------------------------------------------------------
" Powerline
" Powerline is a status bar that displays things like the current virtualenv, git branch, files being edited, and much more.

Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}

"---------------------------------------------------------------------------------------
"Show spaces and other caractheres
Plugin 'Yggdroot/indentLine'

"----------------------------------------------------------------------------------------
"
" Splits Screen
"set splitbelow
"set splitright

" Pro Tip Want to move between the splits without using the mouse? Simply add the following to .vimrc
" and you can jump between splits with just one key combination:

" split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Key combo to move between screens
"
" Ctrl-j move to the split below
" Ctrl-k move to the split above
" Ctrl-l move to the split to the right
" Ctrl-h move to the split to the left

" Code Folding
set foldmethod=indent
set foldlevel=99

" Pro Tip: Want to see the docstrings for folded code?
let g:SimpylFold_docstring_preview=1

" PEP8
" To add the proper PEP8 indentation, add the following to your .vimrc:

"au BufNewFile,BufRead *.py
"    \ set tabstop=4
"    \ set softtabstop=4
"    \ set shiftwidth=4
"    \ set textwidth=79
"    \ set expandtab
"    \ set autoindent
"    \ set fileformat=unix
" This will give you the standard four spaces when you hit tab, ensure your line length doesn’t go beyond 80
" characters, and store the file in a unix format so you don’t get a bunch of conversion issues when checking into GitHub and/or sharing with other users.
" And for full stack development you can use another au command for each filetype:

au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2


" Flagging Unnecessary Whitespace
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" UTF8 Support
set encoding=utf-8

" Virtualenv Support
" One issue with the goto definition above is that VIM by default doesn’t know anything about virtualenv,
" so you have to make VIM and YouCompleteMe aware of your virtualenv by adding the following lines of code to .vimrc:

" Python with virtualenv support
"py << EOF
"import os
"import sys
"if 'VIRTUAL_ENV' in os.environ:
"	project_base_dir = os.environ['VIRTUAL_ENV']
"	activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"	execfile(activate_this, dict(__file__=activate_this))
"	EOF

"      This determines if you are running inside a virtualenv, and then
"      switches to that specific virtualenv and sets up your system path so
"      that YouCompleteMe will find the appropriate site packages.
"

" Finally, make your code look pretty:
let python_highlight_all=1
syntax on

" Line Numbering
" Turn on line numbers on the side of the screen with:
set nu

" System clipboard
set clipboard=unnamed

" Stop Using arrows keys
"noremap <Up> <NOP>
"noremap <Down> <NOP>
"noremap <Left> <NOP>
"noremap <Right> <NOP>
"
"Show commands while pressing the keys
set showcmd

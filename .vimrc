" This must be first, because it changes other options as side effect
set nocompatible
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Group dependencies, vim-snippets depends on ultisnips
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'junegunn/fzf.vim'

Plug 'vim-airline/vim-airline'

Plug 'scrooloose/syntastic'

Plug 'vim-airline/vim-airline'

Plug 'vim-scripts/indentpython.vim'

Plug 'tmhedberg/SimpylFold'

" Plug 'Valloric/YouCompleteMe'

Plug 'nvie/vim-flake8'

Plug 'jnurmine/Zenburn'

Plug 'altercation/vim-colors-solarized'

Plug 'jistr/vim-nerdtree-tabs'

Plug 'tpope/vim-fugitive'

Plug 'sjl/gundo.vim'

Plug 'scrooloose/nerdcommenter'

Plug 'mileszs/ack.vim'
" Add plugins to &runtimepath
call plug#end()

set hidden

filetype plugin on

" Syntastic section
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_signs=1

let g:syntastic_python_checkers=['pylama']
let g:syntastic_python_pylama_args = '-l pep8,pep257,mccabe,pyflakes,pylint'

" enable syntax highlighting
syntax enable
"
" " show line numbers
set number
"
" " set tabs to have 4 spaces
set ts=4
"
" " indent when moving to the next line while writing code
set autoindent
"
" " expand tabs into spaces
set expandtab
"
" " when using the >> or << commands, shift lines by 4 spaces
set shiftwidth=4
"
" " show a visual line under the cursor's current line
set cursorline
"
" " show the matching part of the pair for [] {} and ()
set showmatch
"
" " enable all Python syntax highlighting features
let python_highlight_all = 1

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding
" set foldmethod=indent
" set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2

" let g:ycm_autoclose_preview_window_after_completion=1
" map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"python with virtualenv support
"py << EOF
"import os
"import sys
"if 'VIRTUAL_ENV' in os.environ:
"  project_base_dir = os.environ['VIRTUAL_ENV']
"  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"  execfile(activate_this, dict(__file__=activate_this))
"EOF

if has('gui_running')
  set background=dark
  colorscheme solarized
else
  colorscheme zenburn
endif

nnoremap <F5> :GundoToggle<CR>

let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

map <C-n> :NERDTreeToggle<CR>

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" let g:NERDTreeDirArrowExpandable = '▸'
" let g:NERDTreeDirArrowCollapsible = '▾'

map <C-p> :Files<CR>

set ignorecase

" set autochdir
" set tags+=./tags;
"
augroup myvimrc
  au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

let g:ack_default_options = " -H --nocolor --nogroup --column"

" inoremap jk <ESC>

xnoremap p pgvy

set pastetoggle=<F2>

" inoremap <esc> <nop>
" inoremap  <Up>     <NOP>
" inoremap  <Down>   <NOP>
" inoremap  <Left>   <NOP>
" inoremap  <Right>  <NOP>
" inoremap  <Esc>    <NOP>
" noremap   <Up>     <NOP>
" noremap   <Down>   <NOP>
" noremap   <Left>   <NOP>
" noremap   <Right>  <NOP>
" noremap   <Esc>    <NOP>

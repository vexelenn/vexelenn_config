"  This must be first, because it changes other options as side effect
cmap w!! w !sudo tee % >/dev/null

set nocompatible
set nobackup
set nowritebackup
set noswapfile
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

Plug 'Shutnik/jshint2.vim'

" Plug 'vim-airline/vim-airline'

Plug 'scrooloose/syntastic'

Plug 'vim-airline/vim-airline'

Plug 'vim-scripts/indentpython.vim'

" Plug 'tmhedberg/SimpylFold'

Plug 'Valloric/YouCompleteMe'

" Plug 'nvie/vim-flake8'

Plug 'jnurmine/Zenburn'

Plug 'altercation/vim-colors-solarized'

Plug 'jistr/vim-nerdtree-tabs'

" Plug 'carlhuda/janus'

Plug 'tpope/vim-fugitive'

Plug 'sjl/gundo.vim'

Plug 'scrooloose/nerdcommenter'

Plug 'python-rope/ropevim'

Plug 'mileszs/ack.vim'

Plug 'easymotion/vim-easymotion'

Plug 'haya14busa/incsearch.vim'

Plug 'haya14busa/incsearch-fuzzy.vim'

Plug 'haya14busa/incsearch-easymotion.vim'

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
let g:syntastic_python_pylama_args = '-l pep257,mccabe,pyflakes,pylint'
let g:syntastic_python_pylint_post_args="--max-line-length=120"
let g:syntastic_python_flake8_args='--ignore=E501'

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

" set <Leader> key
let mapleader = ","
"
" More tmux like stuff & faster with two hands :D
" let mapleader = "A"

" force  eload config
noremap <Leader> r :so $MYVIMRC

" sort selected block
vnoremap <Leader>s :sort<CR>

" move code block < >
vnoremap < <gv
vnoremap > >gv

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding
" set foldmethod=indent
" set foldlevel=99

" Enable folding with the spacebar
" nnoremap <space> za

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

" Flagging Unnecessary Whitespace
" au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" UTF8 Support
set encoding=utf-8

" Auto-complete options
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" ropevim complete test:
let ropevim_vim_completion=1
let ropevim_extended_complete=1

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
  set background=light
  colorscheme solarized
else
  set background=dark
  " colorscheme zenburn
  " colorscheme blue
  colorscheme solarized
endif

nnoremap <F5> :GundoToggle<CR>

let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

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

if executable('ag')
    let g:ackprg = 'ag --column'
else
    let g:ack_default_options = " -H --nocolor --nogroup --column"
endif

" much faster than jj. 
inoremap jk <ESC>l
inoremap kj <ESC>l
" little alternative
inoremap <S-CR> <Esc>

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
"
" set tags=./tags,tags;$HOME
set tags=~/mytags
set ignorecase

" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

function! s:config_easyfuzzymotion(...) abort
    return extend(copy({
    \   'converters': [incsearch#config#fuzzyword#converter()],
    \   'modules': [incsearch#config#easymotion#module({'overwin': 1})],
    \   'keymap': {"\<CR>": '<Over>(easymotion)'},
    \   'is_expr': 0,
    \   'is_stay': 1
    \ }), get(a:, 1, {}))
    endfunction

noremap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion())

" tab stuff below
noremap <leader>n :tabnew<cr>
" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" Go to last active tab

au TabLeave * let g:lasttab = tabpagenr()
nnoremap <silent> <c-l> :exe "tabn ".g:lasttab<cr>
vnoremap <silent> <c-l> :exe "tabn ".g:lasttab<cr>

" tab moving
noremap <Leader>h :tabNext<CR>
noremap <Leader>l :tabnext<CR>
noremap <Leader>n :tabnew<CR>

" Jumps navigation mapped to leader-o
function! GotoJump()
  jumps
  let j = input("Please select your jump: ")
  if j != ''
    let pattern = '\v\c^\+'
    if j =~ pattern
      let j = substitute(j, pattern, '', 'g')
      execute "normal " . j . "\<c-i>"
    else
      execute "normal " . j . "\<c-o>"
    endif
  endif
endfunction

nmap <Leader>o :call GotoJump()<CR>

exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
set list

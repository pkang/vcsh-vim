"----------------------------------------------------------------------- Vundle
set nocompatible "force using vim, not vi
filetype off

" be sure to add paths to the runtime path if needed by vim
set rtp+=~/.vim/bundle/vundle
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tomtom/tcomment_vim'
Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'
Bundle 'Lokaltog/powerline'
Bundle 'mileszs/ack.vim'
Bundle 'Shougo/neocomplcache.vim'
Bundle 'godlygeek/tabular'
Bundle 'tpope/vim-fugitive'
Bundle 'airblade/vim-gitgutter'

Bundle 'nono/vim-handlebars'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'slim-template/vim-slim'
Bundle 'wavded/vim-stylus'

filetype plugin indent on "detect filetype automatically


"----------------------------------------------------------------------- Colors
set t_Co=256 " Explicitly tell vim that the terminal supports 256 colors
color solarized
set background=dark


"------------------------------------------------------------------------- Misc
set encoding=utf-8 "default character encoding
set exrc "enable per-directory .vimrc files
set secure "disable unsafe commands in local .vimrc files
set nobackup
set noswapfile
set hidden
set shell=$SHELL\ -l


"-------------------------------------------------------------------- Workspace
" set rnu "relative line numbers
set nu "absolute line numbers
set ruler "column and row position
set colorcolumn=80 "column guide on the right
set scrolloff=5 "when scrolling, stay this far from extremes of buffer
set list listchars=tab:\ \ ,trail:· "show trailing whitespace
set smartindent "indent wisely
set autoindent "auto-indent
set wrap "soft-wrap text
set textwidth=79 "wrap above at this amount
set wrapmargin=2 "wrap buffer
set backspace=indent,eol,start "lazy backspacing
set showcmd "show the current command
set laststatus=2 "always show the status line. Always!
" set showtabline=2 "show the tab line at the top, always

" line break without going into insert mode
" <S-CR> & <S-Enter> both don't seem to work... hmm
map <S-CR> O<Esc>
map <CR> o<Esc>


"----------------------------------------------------------------------- Syntax
syntax on "turn on syntax highlighting


"----------------------------------------------------------------------- Search
set incsearch "incremental searching
set ignorecase "case-insenitive searching
set smartcase "do a case-sensitive search if uppercase letters are present
set hlsearch "highlight search results


"--------------------------------------------------------------------- Wildmenu
set wildmenu "turn on wildmenu
set wildmode=list:longest,full "default to longest match first

" ignore directories
set wildignore=**/node_modules/**
set wildignore+=cookbooks/**
set wildignore+=tmp/**
set wildignore+=*.lock
set wildignore+=public/uploads/**
set wildignore+=bin/**


"------------------------------------------------------------------------- Tabs
set tabstop=2 "how wide is a tab?
set shiftwidth=2 "how much to reindent
set softtabstop=2 "use 2 spaces
set expandtab "we use spaces, not hard tabs
set formatoptions=qrn1 "I've forgotten what this does, but it helps...somehow


"---------------------------------------------------------------------- Windows
" easily move between windows with Ctrl+hjkl
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" easily resize windows with + and -
if bufwinnr(1)
  map <up>  <C-W>+
  map <down>    <C-W>-
  map <right> <C-W><
  map <left>  <C-W>>
end

if !&diff
  " window size management
  set winwidth=84
  " we have to have a winheight bigger than we want to set winminheight, but if
  " we set winheight to be huge before winminheight, winminheight set will
  " always fail
  set winheight=5
  set winminheight=5
  set winheight=999
endif

" super buffer splitting!
nmap <leader>sh :leftabove vnew<cr>
nmap <leader>sl :rightbelow vnew<cr>
nmap <leader>sk :leftabove new<cr>
nmap <leader>sj :rightbelow new<cr>


"--------------------------------------------------------------------- Mappings
" make it so that j and k jump visual lines instead of file lines
nnoremap j gj
nnoremap k gk

" use semi-colon instead of colon: saves keystrokes
noremap ; :

"quickly edit vimrc
nnoremap <leader>ev :e $MYVIMRC<cr>

" disable the arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

"kill recording; I don't care about it
nnoremap q <Nop>


"--------------------------------------------------------------------- Autocmds
" reload vimrc as soon as we're done editing it
autocmd! bufwritepost $MYVIMRC source $MYVIMRC


"-------------------------------------------------------------------- Filetypes
au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile *.thor set filetype=ruby
au BufRead,BufNewFile *.slim set filetype=slim
au BufRead,BufNewFile Gemfile set filetype=ruby
au BufRead,BufNewFile config.ru set filetype=ruby


"------------------------------------------------------------------------ CtrlP
" let g:ctrlp_user_command = 'find %s -type f'
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.yardoc\|public\/images\|public\/system\|bin\|log\|tmp$',
  \ 'file': '\.exe$\|\.so$\|\.dat$'
  \ }


"--------------------------------------------------------------------- NERDTree
" nmap <leader>n :NERDTree<cr>
nnoremap <C-g> :NERDTreeToggle<cr>


"---------------------------------------------------------------- NeoComplCache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_auto_select = 1


"--------------------------------------------------------------------- Fugitive
nmap <leader>gs :Gstatus<cr>
nmap <leader>gb :Gblame<cr>

"----------------------------------------------------------------------- Vundle
set nocompatible "force using vim, not vi
filetype off

" be sure to add paths to the runtime path if needed by vim
set rtp+=~/.vim/bundle/vundle

call vundle#rc()

" To setup Vundle:
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
Bundle 'gmarik/vundle'
Bundle 'tomtom/tcomment_vim'
Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'
Bundle 'bling/vim-airline'
Bundle 'mileszs/ack.vim'
Bundle 'Shougo/neocomplete.vim'
Bundle 'godlygeek/tabular'
Bundle 'airblade/vim-gitgutter'
Bundle 'vim-ruby/vim-ruby'
Bundle 'christoomey/vim-tmux-navigator'

" works with ruby-build rubies
Bundle 'tpope/vim-rbenv' 
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-endwise'

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
set shell=/bin/sh


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
let mapleader=","

" line break without going into insert mode
" <S-CR> & <S-Enter> both don't seem to work... hmm
map <S-CR> O<Esc>
map <CR> o<Esc>


"----------------------------------------------------------------------- Syntax
syntax on "turn on syntax highlighting


"----------------------------------------------------------------------- Search
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
let g:tmux_navigator_no_mappings = 1

" WARNING: specific to OS X 10.8 or greater!!
nnoremap <silent> j :TmuxNavigateDown<cr>
nnoremap <silent> k :TmuxNavigateUp<cr>
nnoremap <silent> h :TmuxNavigateLeft<cr>
nnoremap <silent> l :TmuxNavigateRight<cr>

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

map <leader> ,


"--------------------------------------------------------------------- Autocmds
" reload vimrc as soon as we're done editing it
" autocmd! bufwritepost $MYVIMRC source $MYVIMRC


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
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3


"-------------------------------------------------------------------- Gitgutter
let g:gitgutter_realtime = 0


"---------------------------------------------------------------------- Airline
let g:airline_powerline_fonts = 1


"---------------------------------------------------------- Rename current file
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <leader>n :call RenameFile()<cr>


"-------------------------------------------------------------------- Run tests
function! RunTestFile(...)
  if a:0
    let command_suffix = a:1
  else
    let command_suffix = ""
  endif

  let in_test_file = match(expand("%"), "_spec.rb$") != -1
  if in_test_file
    call SetTestFile()
  elseif !exists("t:grb_test_file")
    return
  end

  call RunTests(t:grb_test_file . command_suffix)
endfunction

function! SetTestFile()
  let t:grb_test_file=@%
endfunction

function! SetTestFileLineNumber()
  let t:grb_spec_line_number = line(".")
endfunction

" requires minitest-line
function! RunNearestTest()
  let in_test_file = match(expand("%"), "_spec.rb$") != -1
  if in_test_file
    call SetTestFileLineNumber()
  elseif !exists("t:grb_spec_line_number")
    return
  end

  call RunTestFile(" -l " . t:grb_spec_line_number)
endfunction

" TODO make smarter about deciding whether or not to run minitest or rspec
function! RunTests(filename)
  if expand("%") != ""
    :w
  end
  " exec ":!clear && tmux clear-history && ruby -Ispec " . a:filename
  exec ":!clear && tmux clear-history && rspec -Ispec " . a:filename
endfunction

nmap <leader>r :call RunTestFile()<cr>
nmap <leader>R :call RunNearestTest()<cr>
" map <leader>a :silent call RunTests('')<cr>


"--------------------------------- switch between test file and production file
function! OpenTestAlternate()
  let new_file = AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction

function! AlternateForCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_spec = match(current_file, '^spec/') != -1
  let going_to_spec = !in_spec
  let in_app = match(current_file, '\<controllers\>') != -1
             \ || match(current_file, '\<models\>') != -1
             \ || match(current_file, '\<views\>') != -1
             \ || match(current_file, '\<helpers\>') != -1
             \ || match(current_file, '\<daily_good\>') != -1
             \ || match(current_file, '\<decorators\>') != -1
  if going_to_spec
    if in_app
      let new_file = substitute(new_file, '^app/', '', '')
    end
    let new_file = substitute(new_file, '\.e\?rb$', '_spec.rb', '')
    let new_file = 'spec/' . new_file
  else
    let new_file = substitute(new_file, '_spec\.rb$', '.rb', '')
    let new_file = substitute(new_file, '^spec/', '', '')
    if in_app
      let new_file = 'app/' . new_file
    end
  endif
  return new_file
endfunction

nnoremap <leader>. :call OpenTestAlternate()<cr>

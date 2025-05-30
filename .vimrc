syntax on
set t_Co=256
set cursorline
set encoding=UTF-8
set nocompatible " Don’t try to be just Vi
filetype indent plugin on " Turn on file type detection
set autoindent " Keep current indent if no other indent rule
set autoread " Reload file if it’s changed on the file system
set backspace=indent,eol,start " Allow backspacing over everything
set complete=.,w,b,u,t " Scan all buffers and include tags
set display=lastline " Display as much as possible of a line
set encoding=utf-8 " UTF-8 encoding
set formatoptions=tcqj " Auto-wrap text, better comment formatting
set history=10000 " Maximum command and search history
set hlsearch " Highlight search results
set incsearch " Jump to results as you type
set langnoremap " 'langmap' doesn’t mess with mappings
set laststatus=2 " Status line is always shown
set listchars=tab:>\ ,trail:-,nbsp:+ " Default white space characters
set mouse=a " Enable mouse
set nrformats=hex " Recognize hexadecimal numbers
" For sessions, save & restore the following:
set sessionoptions=blank,buffers,curdir,folds,help,tabpages,winsize
set smarttab " Respect shiftwidth setting
set tabpagemax=50 " Maximum number of tabs to be opened
set tags=./tags;,tags " Default locations for tags files
set ttyfast " Assume a modern terminal, fast ‘connection’
set viminfo+=! " Keep all-caps global variables
" Quickly insert an empty new line without entering insert mode
nnoremap <Leader>o o<Esc>
nnoremap <Leader>O O<Esc>
set wildmode=longest,list,full " Tab autocompletion settings
set wildmenu " List possible completions on status line

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'vim-airline/vim-airline'
Plug 'dense-analysis/ale'
Plug 'ryanoasis/vim-devicons'
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py --all' }
Plug 'tpope/vim-fugitive'
Plug 'camspiers/animate.vim'
Plug 'prettier/vim-prettier', { 'do': 'npm install' }

" Themes
Plug 'drewtempelmeyer/palenight.vim'

call plug#end()

" Remap arrow keys and animate
nnoremap <silent> <Up>    :call animate#window_delta_height(10)<CR>
nnoremap <silent> <Down>  :call animate#window_delta_height(-10)<CR>
nnoremap <silent> <Left>  :call animate#window_delta_width(10)<CR>
nnoremap <silent> <Right> :call animate#window_delta_width(-10)<CR>
let g:animate#duration = 300.0
let g:animate#easing_func = 'animate#ease_linear'

" Color scheme
colorscheme palenight
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Force cursor styles for switching modes 
let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode

" Changes colour for the end of buffer to soften the ~
highlight EndOfBuffer ctermfg=bg


" Nerd Tree config
set number
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" Check if opening a dir, if so auto open NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" Force close of NERDTree if it's the only remaining window
function! s:QuitIfOnlyControlWinLeft()
  if winnr("$") != 1
    return
  endif
  if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1) || &buftype == 'quickfix'
    q
  endif
endfunction
augroup my_QuitIfOnlyControlWinLeft
  au!
  au BufEnter * nested call s:QuitIfOnlyControlWinLeft()
augroup END


" Vim dev icons
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1


" Airline config
let g:airline_powerline_fonts = 1
let g:airline_theme='palenight'


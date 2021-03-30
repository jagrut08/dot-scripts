colorscheme desert256

" Open where you left off
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

"" ============================================================================
""                            Editing and Moving
"" ============================================================================

syntax on
set autoindent
set cindent
set backspace=indent,eol,start

" Backup directory for swp files
set noswapfile
set directory=""

" Fixing tabs
set tabstop=4
set expandtab
set shiftwidth=4

" Autosave before :make and other commands; autoreload when file mod
set autowrite
set autoread

" Smart case sensitivity
set ignorecase
set smartcase

" Fix background color
set t_ut=

" When multiple completions are possible, show all
set wildmenu

" Complete only up to point of ambiguity, like the shell does
set wildmode=list:longest

" Ignoring files (see :help wildignore)
set wildignore+=*.o,*.d,00*,nohup.out,tags,.hs-tags,*.hi,*.gcno,*.gcda,*.fasl,*.pyc

" Number of lines to scroll past when the cursor scrolls off the screen
set scrolloff=2

" Tool to use for Grepper
set grepprg="git"

"" ============================================================================
""                                Appearances
"" ============================================================================
" Show line numbers
set number

" Show tab and trailing whitespace characters
set listchars=tab:>-,trail:-
set list!

" Incremental Search and Highlighting Results
set incsearch
set hlsearch

" Set the folding method
"set foldmethod=manual
"set foldnestmax=3
"set foldminlines=10
set statusline+=%F

set ruler

"" ============================================================================
""                               Auto Commands
"" ============================================================================
" Automatically open the QuickFix Window after a make
"autocmd QuickFixCmdPost *make* cwindow

" Make
autocmd FileType make setlocal noexpandtab shiftwidth=8

" XML
autocmd FileType xml setlocal equalprg=xmllint\ --format\ -

" Markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Black
:autocmd BufWritePost *.py !black  -l 90 -t py38 --fast <afile>

" Clang format
:autocmd BufWritePost *.{cpp,h} :silent !clang-format --style=Google -i <afile>
:autocmd BufWritePost *.{cpp,h} :redraw

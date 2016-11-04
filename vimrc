" Clear autocmds
" autocmd!

" Map the leader key to space
let mapleader = ' '

" Use Vim settings, rather then Vi settings
" This must be first, because it changes other options as a side effect.
set nocompatible

" Set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Little helpers
Plugin 'duggiefresh/vim-easydir'  " Easily create direcories and files
Plugin 'tpope/vim-fugitive'       " Git wrapper
Plugin 'tpope/vim-vinegar'        " Better file browser
" Plugin 'tpope/vim-speeddating'    " Add <C-A> and <C-X> helpers for dates. d<C-A> and d<C-X> for current timestamps
Plugin 'tpope/vim-commentary'     " Add comment via gcc and 9gcc or gloabl :g/PATTERN/Commentary
Plugin 'tpope/vim-endwise'        " Add end tags to if, def, ...
Plugin 'raimondi/delimitmate'     " Add pairs for brackets etc
Plugin 'bling/vim-airline'        " Better status line
Plugin 'tpope/vim-unimpaired'     " https://github.com/tpope/vim-unimpaired
Plugin 'tpope/vim-surround'       " Use cs to change surroundings. For example cs{[
Plugin 'tpope/vim-repeat'         " Make (some) Plugins work work with the . command

" Sublime / TextMate style Ctrl+P
Plugin 'kien/ctrlp.vim'            " For files with <C-p>
Plugin 'd11wtq/ctrlp_bdelete.vim'  " For buffers with <C-b> (Close with C-2 / Mark multiple with C-z)
" Plugin 'tacahiroy/ctrlp-funky'   " Could be used for definitions inside a file. Usefull?

" Sublime styile multiple cursors
Plugin 'terryma/vim-multiple-cursors' " Use <C-n> to set new cursors in visual in insert mode

" Autocomplete
Plugin 'valloric/youcompleteme'       " Autocomplete

" Ruby and Rails helpers
Plugin 'rorymckinley/vim-rubyhash'    " Change ruby hash syntax with <leader>rr / <leader>rs / <leader>rt
Plugin 'ecomba/vim-ruby-refactoring'  " Handy helpers to refactor ruby code.
Plugin 'tpope/vim-rails'              " Rails integration
Plugin 'thoughtbot/vim-rspec'         " Run specs with <leader>ta / <leader>tf / <leader>tt

" Syntax extensions
" Plugin 'jelera/vim-javascript-syntax'
" Plugin 'pangloss/vim-javascript'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-rake'
Plugin 'avakhov/vim-yaml'
Plugin 'pearofducks/ansible-vim'

" Open alternative file with :A / :AV / :AH
Plugin 'compactcode/open.vim'
Plugin 'compactcode/alternate.vim'

" Snippets
" See https://github.com/honza/vim-snippets/tree/master/snippets for snippets
" Plugin 'MarcWeber/vim-addon-mw-utils'
" Plugin 'tomtom/tlib_vim'
" Plugin 'garbas/vim-snipmate'


" Plugin 'junegunn/vim-easy-align'

" All of your Plugins must be added before the following line
call vundle#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Mixed stuff
set history=100      " Keep 100 commands in the history
set ruler            " show the cursor position all the time
set showcmd          " display incomplete commands
set relativenumber   " relative line numbers
set number           " show current line numver
set nowrap           " don't wrap lines
set vb               " disable alert sound
set autoread         " Auto-reload buffers when files are changed on disk
set linebreak        " break lines at word end
set splitbelow       " open the horizontal split below
set splitright       " open vertical splits on the right
set linespace=0      " number of pixels between the lines
set wildmenu         " show completion on the modeline
set ls=2             " show a status line even if there's only one window
set exrc             " enable per-project .vimrc files
set synmaxcol=1200   " Syntax coloring lines that are too long just slows down the world
set nostartofline    " Don't reset cursor to start of line when moving around
set nojoinspaces     " Use only 1 space after "." when joining lines instead of 2

" Searching
set incsearch        " do incremental searching
set hlsearch         " Highlight the search
set ignorecase       " Case insensitive search
set smartcase        " Case sensitive search if the string contains captible letters
nnoremap <leader>, :nohlsearch<CR>

" Enable file type detection and load plugin indent files as well as syntax
" highlighting
filetype plugin on
filetype indent on
syntax enable
syntax sync fromstart  " http://vim.wikia.com/wiki/Fix_syntax_highlighting

" Appereance
" set background=dark
set t_Co=256 " 256 colors
colorscheme molokai
highlight ColorColumn ctermbg=235 " Make it more obviouser when lines are too long
set list listchars=tab:»·,trail:· " Display extra whitespace

" Improve vim's scrolling speed
set ttyfast
set ttyscroll=3
set lazyredraw

" Indention
set autoindent      " indent on enter
set smartindent     " do smart indenting when starting a new line
set shiftround      " indent to the closest shiftwidth:w

" Folding
" See http://vimcasts.org/episodes/how-to-fold/ for examples
set foldmethod=indent    " Fold by indention by default
set foldnestmax=10       " Limit to 10 nested folds
" set nofoldenable       " Open all folds by default
set foldlevelstart=7     " Open most folds by default
" nnoremap <leader>. za            " Toogle folds with ,

" Undo stuff
set undofile                    " Save undo's after file closes
set undodir=~/.vim/undo         " where to save undo histories
set undolevels=1000             " How many undos
set undoreload=10000            " number of lines to save for undo


" Spaces & Tabs
set expandtab       " use spaces instead of tabs
set tabstop=2       " number of visual spaces per TAB
set softtabstop=2   " number of spaces in tab when editing
set shiftwidth=2    " how many columns text is indented with the reindent operations (<< and >>)

" Enable omnicompletion
set omnifunc=syntaxcomplete#Complete
" Inserts the longest common text of all matches; and the menu will come up even if there's only one match
set completeopt=longest,menuone

" Filetype specific settings
augroup myfiletypes
  " Clear old autocmds in group
  autocmd!

  " autoindent with two spaces, always expand tabs
  autocmd FileType ruby,eruby,yaml setlocal ai sw=2 sts=2 et

  autocmd FileType ruby,eruby,yaml setlocal path+=lib

  autocmd FileType ruby,eruby,yaml setlocal colorcolumn=115

  " Make ?s part of words
  autocmd FileType ruby,eruby,yaml setlocal iskeyword+=?

  " Autocomplete ids and classes in CSS
  autocmd FileType css,scss set iskeyword=@,48-57,_,-,?,!,192-255

  " Add the '-' as a keyword in erb files
  autocmd FileType eruby set iskeyword=@,48-57,_,192-255,$,-

  " Ruby autocomplete
  autocmd FileType ruby set omnifunc=rubycomplete#Complete
  autocmd FileType ruby let g:rubycomplete_buffer_loading=1
  autocmd FileType ruby let g:rubycomplete_classes_in_global=1
  autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
augroup END

" Encoding
set fileencoding=utf-8
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,gb2312,cp936

" Ignored files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem          " Disable output and VCS files
set wildignore+=*.gif,*.jpg,*.png                                            " Ignore images
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz                      " Disable archive files
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/* " Ignore bundler and sass cache
set wildignore+=*/tmp/cache/assets/*/sprockets/*,*/tmp/cache/assets/*/sass/* " Ignore rails temporary asset caches
set wildignore+=*.swp,*~,._*                                                 " Disable temp and backup files
set wildignore+=.DS_Store                                                    " Disable osx index files

" CtrlP Settings
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git\|node_modules\|bin\|\.hg\|\.svn\|build\|log\|resources\|coverage\|doc\|tmp\|public/assets\|vendor\|Android',
  \ 'file': '\.jpg$\|\.exe$\|\.so$\|tags$\|\.dll$'
  \ }
nnoremap <C-b> :CtrlPBuffer<cr>
nnoremap <leader>b :CtrlPBuffer<cr>
nnoremap <leader>p :CtrlP<cr>
call ctrlp_bdelete#init()
let g:ctrlp_max_files=0

" rspec
map <Leader>tf :call RunCurrentSpecFile()<CR>
map <Leader>tt :call RunNearestSpec()<CR>
map <Leader>tl :call RunLastSpec()<CR>
map <Leader>ta :call RunAllSpecs()<CR>

" Disable Arrow keys in Escape mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Disable Arrow keys in Insert mode
" imap <up> <nop>
" imap <down> <nop>
" imap <left> <nop>
" imap <right> <nop>

" noremap <A-Up> <NOP>
" noremap <A-Down> <NOP>
" noremap <A-Left> <NOP>
" noremap <A-Right> <NOP>

" provide hjkl movements in Insert mode <Alt> key
imap <A-h> <C-o>h
imap <A-j> <C-o>j
imap <A-k> <C-o>k
imap <A-l> <C-o>l

" Use C-h/j/k/l to move between splits
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Airline apperance
let g:airline_branch_prefix = '⎇ '

" Setup open compactcode/alternate.vim file (alternate)
:command A Open(alternate#FindAlternate())
:command AH OpenHorizontal(alternate#FindAlternate())
:command AV OpenVertical(alternate#FindAlternate())

" Project wide search with vimgrep and git ls-files
nnoremap <leader>/ :vimgrep  `git ls-files`<C-left><C-left><C-left>

" Git shortcuts
nnoremap <leader>gca :Git add -A<CR>:Git commit<CR>
nnoremap <leader>gcw :Git add -A<CR>:Git commit -m "WIP"<CR>
nnoremap <leader>gcc :Git commit<CR>
nnoremap <leader>gc% :Git add %<CR>:Git commit %<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gaf :Gwrite<CR>
nnoremap <leader>ga. :Git add .<CR>:Gstatus<CR>
nnoremap <leader>ga% :Git add %<CR>:Gstatus<CR>
nnoremap <leader>gaa :Git add -A<CR>:Gstatus<CR>
nnoremap <leader>gap :Git add -A -p<CR>:Gstatus<CR>
nnoremap <leader>gp :Git push<CR>

" Make C-c send Esc in insert mode
inoremap <C-c> <Esc>

" Ansible settings
let g:ansible_attribute_highlight = 'od'
let g:ansible_name_highlight = 'b'
let g:ansible_extra_keywords_highlight = 1

" Setup vim-vinegar (netrw) to display line numbers
let g:netrw_bufsettings = 'noma nomod nu nowrap ro nobl'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE (thanks Gary Bernhardt)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <Leader>n :call RenameFile()<cr>

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

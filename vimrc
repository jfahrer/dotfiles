" Clear autocmds
" autocmd!

" Map the leader key
let mapleader = ' '

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Little helpers
Plugin 'duggiefresh/vim-easydir'  " Easily create direcories and files
Plugin 'tpope/vim-fugitive'       " Git wrapper
Plugin 'tpope/vim-vinegar'        " Better file browser
Plugin 'tpope/vim-speeddating'    " Add <C-A> and <C-X> helpers for dates. d<C-A> and d<C-X> for current timestamps
Plugin 'tpope/vim-commentary'     " Add comment via <leader>gcc and <leader>9gcc 
Plugin 'tpope/vim-endwise'        " Add end tags to if, def, ...
Plugin 'jiangmiao/auto-pairs'     " Add pairs for brackets etc
Plugin 'bling/vim-airline'        " Better status line
Plugin 'tpope/vim-unimpaired'     " https://github.com/tpope/vim-unimpaired

" Sublime / TextMate style Ctrl+P
Plugin 'kien/ctrlp.vim'
Plugin 'd11wtq/ctrlp_bdelete.vim'
Plugin 'tacahiroy/ctrlp-funky'

" Buffer and file management
Plugin 'Shougo/unite.vim' " See https://coderwall.com/p/pwh5jg/ignoring-gitignore-files-in-unite-vim for performance
Plugin 'Shougo/vimproc.vim' " Run make inside ~/.vim/bundle/vimproc.vim after installation!
 
" Ruby and Rails helpers
Plugin 'rorymckinley/vim-rubyhash'
Plugin 'ecomba/vim-ruby-refactoring'
Plugin 'tmhedberg/matchit'
Plugin 'tpope/vim-rails'

" Rspec
Plugin 'thoughtbot/vim-rspec'

" Syntax extensions
Plugin 'jelera/vim-javascript-syntax'
Plugin 'kchmck/vim-coffee-script'
Plugin 'pangloss/vim-javascript'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-rake'
Plugin 'avakhov/vim-yaml'

" Open alternative file
Plugin 'compactcode/open.vim'
Plugin 'compactcode/alternate.vim'

" Snippets
" See https://github.com/honza/vim-snippets/tree/master/snippets for snippets
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'

" Autocompletion
" Also see
" http://vertuxeltes.blogspot.de/2013/05/powerful-insert-mode-completion.html
Plugin 'ervandew/supertab'
Plugin 'vim-scripts/AutoComplPop'

" Helpers for ",' and tag sourindings
" See https://github.com/tpope/vim-surround
Plugin 'tpope/vim-surround'

" TODO
" Plugin 'junegunn/vim-easy-align'
" https://github.com/gabrielelana/vim-markdown
" lugin 'gabrielelana/vim-markdown'
" Vielleicht nützlich?
" https://github.com/vim-ruby/vim-ruby/wiki/VimRubySupport
" Bundle 'vim-ruby/vim-ruby'

" All of your Plugins must be added before the following line
call vundle#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Mixed stuff
set history=100
set ruler            " show the cursor position all the time
set showcmd          " display incomplete commands
set incsearch        " do incremental searching
set relativenumber   " relative line numbers
set nowrap           " don't wrap lines
set vb               " disable alert sound
set autoread         " Auto-reload buffers when files are changed on disk
set linebreak        " break lines at word end
set splitbelow       " open the horizontal split below
set splitright       " open vertical splits on the right
set linespace=0      " number of pixels between the lines
set wildmenu         " show completion on the modeline
" set hlsearch       " Highlight the search
set ls=2             " show a status line even if there's only one window
set exrc             " enable per-project .vimrc files


" Enable file type detection and load plugin indent files
filetype plugin on
filetype indent on

syntax enable
syntax sync fromstart

" Appereance
set t_Co=256 " 256 colors
set background=dark
colorscheme molokai

" Make C-c send Esc in insert mode
inoremap <C-c> <Esc>

" Improve vim's scrolling speed
set ttyfast
set ttyscroll=3
set lazyredraw

" Indention
set autoindent                  " indent on enter
set smartindent                 " do smart indenting when starting a new line
set shiftround                  " indent to the closest shiftwidth

" Folding
set foldmethod=indent
set foldlevel=1
set foldnestmax=10
set nofoldenable       " Open all folds by default

" Undo stuff
set undofile                    " Save undo's after file closes
set undodir=~/.vim/undo         " where to save undo histories
set undolevels=1000             " How many undos
set undoreload=10000            " number of lines to save for undo


" set tabstop value and shift width
set ts=2
set sw=2
set expandtab

augroup myfiletypes
  " Clear old autocmds in group
  autocmd!
  " autoindent with two spaces, always expand tabs
  autocmd FileType ruby,eruby,yaml setlocal ai sw=2 sts=2 et
  autocmd FileType ruby,eruby,yaml setlocal path+=lib
  autocmd FileType ruby,eruby,yaml setlocal colorcolumn=115
  " Make ?s part of words
  autocmd FileType ruby,eruby,yaml setlocal iskeyword+=?
augroup END

" Case insensitive search
set ignorecase
set smartcase

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

" Autocompletion settings - see http://vim.wikia.com/wiki/VimTip1386
set omnifunc=syntaxcomplete#Complete " Enable omnicompletion
set completeopt=longest,menuone
" See http://vim.wikia.com/wiki/VimTip1486
let g:SuperTabDefaultCompletionType = "context"
" Autocomplete ids and classes in CSS
autocmd FileType css,scss set iskeyword=@,48-57,_,-,?,!,192-255
" Add the '-' as a keyword in erb files
autocmd FileType eruby set iskeyword=@,48-57,_,192-255,$,-

" Invisible characters
" set listchars=tab:▸\ ,trail:·,eol:¬,nbsp:_,extends:❯,precedes:❮

" Syntax coloring lines that are too long just slows down the world
set synmaxcol=1200

" Don't reset cursor to start of line when moving around
set nostartofline


" " CtrlP Settings
" hi def link CtrlPMatch CursorLine
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_switch_buffer = 'Et'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git\|node_modules\|bin\|\.hg\|\.svn\|build\|log\|resources\|coverage\|doc\|tmp\|public/assets\|vendor\|Android',
  \ 'file': '\.jpg$\|\.exe$\|\.so$\|tags$\|\.dll$'
  \ }
nnoremap <C-b> :CtrlPBuffer<cr>
" CtrlP Delete
call ctrlp_bdelete#init()
" CtrlP Funky
let g:ctrlp_extensions = ['funky']
let g:ctrlp_funky_multi_buffers = 1
let g:ctrlp_max_files=0

" unite.vim settings
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#custom#source('file_rec/async', 'ignore_pattern', '.git/')
call unite#custom#source('file_rec/async', 'ignore_pattern', 'tmp/')
nnoremap <leader>b :<C-u>Unite -buffer-name=buffer buffer<cr>
autocmd FileType unite call s:unite_my_settings()
" Make dd available to delete buffers (to get around waiting for d due to
" vim-sourroundings
function! s:unite_my_settings()
  nnoremap <silent><buffer><expr> dd unite#do_action('delete')
endfunction


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
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" noremap <A-Up> <NOP>
" noremap <A-Down> <NOP>
" noremap <A-Left> <NOP>
" noremap <A-Right> <NOP>
 
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l


" Use only 1 space after "." when joining lines instead of 2
set nojoinspaces

" Airline apperance
let g:airline_branch_prefix = '⎇ '

" Setup open alternative file (alternate)
:command A Open(alternate#FindAlternate())
:command AH OpenHorizontal(alternate#FindAlternate())
:command AV OpenVertical(alternate#FindAlternate())

" Project wide search with vimgrep and git ls-files
:nnoremap <leader>/ :vimgrep  `git ls-files`<C-left><C-left><C-left>

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
nnoremap <leader>gp :Git push<CR>

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Make it more obviouser when lines are too long
highlight ColorColumn ctermbg=235

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

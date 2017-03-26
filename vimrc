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
Plugin 'duggiefresh/vim-easydir'     " Easily create direcories and files
Plugin 'tpope/vim-fugitive'          " Git wrapper
Plugin 'tpope/vim-vinegar'           " Better file browser
Plugin 'tpope/vim-commentary'        " Add comment via gcc and 9gcc or gloabl :g/PATTERN/Commentary
Plugin 'tpope/vim-endwise'           " Add end tags to if, def, ...
Plugin 'raimondi/delimitmate'        " Add pairs for brackets etc
Plugin 'bling/vim-airline'           " Better status line
Plugin 'tpope/vim-unimpaired'        " https://github.com/tpope/vim-unimpaired
Plugin 'tpope/vim-surround'          " Use cs to change surroundings. For example cs{[
Plugin 'tpope/vim-repeat'            " Make (some) Plugins work work with the . command
Plugin 'christoomey/vim-system-copy' " Copy / paste from the system clipboard

" Sublime / TextMate style Ctrl+P
Plugin 'kien/ctrlp.vim'            " For files with <C-p>
Plugin 'd11wtq/ctrlp_bdelete.vim'  " For buffers with <leader>b (Close with C-2 / Mark multiple with C-z)
Plugin 'tacahiroy/ctrlp-funky'     " Fuzzy find definitions in current buffer with <leader>fu

" Sublime styile multiple cursors
Plugin 'terryma/vim-multiple-cursors' " Use <C-n> to set new cursors in visual in insert mode

" Autocomplete
" Needs to be recompiled after an upgrade:
" cd ~/.vim/bundle/youcompleteme
" ./install.py
Plugin 'valloric/youcompleteme'

" Ruby and Rails helpers
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-rails'              " Rails integration
Plugin 'thoughtbot/vim-rspec'         " Run specs with <leader>ta / <leader>tf / <leader>tt
Plugin 'ecomba/vim-ruby-refactoring'  " Handy helpers to refactor ruby code.
" Plugin 'rorymckinley/vim-rubyhash'    " Change ruby hash syntax with <leader>rr / <leader>rs / <leader>rt

" More VIm  text objects
Plugin 'kana/vim-textobj-user'
Plugin 'kana/vim-textobj-entire'
Plugin 'kana/vim-textobj-indent'
Plugin 'kana/vim-textobj-line'
Plugin 'nelstrom/vim-textobj-rubyblock' " Provides ruby movements for inner / around block and methods: ar, ir, am, im

" Syntax extensions
Plugin 'pangloss/vim-javascript'
Plugin 'elzr/vim-json'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-haml'
Plugin 'avakhov/vim-yaml'
Plugin 'pearofducks/ansible-vim'
Plugin 'moll/vim-node'

" Searching
Plugin 'mileszs/ack.vim'

" Open alternative file with :A / :AV / :AH
Plugin 'compactcode/open.vim'
Plugin 'compactcode/alternate.vim'

" tmux integration
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'christoomey/vim-tmux-runner'

" Snippets
" Track the engine.
Plugin 'SirVer/ultisnips'

" All Plugins must be added before the following line
call vundle#end()

runtime macros/matchit.vim

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

  " Make ? part of keywords
  autocmd FileType ruby,eruby,yaml setlocal iskeyword+=\?

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

" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<C-Space>"
let g:UltiSnipsJumpForwardTrigger="<C-f>"
let g:UltiSnipsJumpBackwardTrigger="<C-b>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" CtrlP Settings
let g:ctrlp_mruf_max = 250
let g:ctrlp_mruf_relative = 1
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:25,results:25'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git\|node_modules\|bin\|\.hg\|\.svn\|build\|log\|resources\|coverage\|doc\|tmp\|public/assets\|vendor\|Android',
  \ 'file': '\.jpg$\|\.exe$\|\.so$\|tags$\|\.dll$'
  \ }
"nnoremap <C-b> :CtrlPBuffer<cr>
nnoremap <leader><leader> :CtrlPMixed<cr>
nnoremap <leader>b :CtrlPBuffer<cr>
nnoremap <leader>ft :CtrlPTag<cr>   " Use CtrlP to navigate tags
nnoremap <leader>fd :CtrlPFunky<cr> " Use CtrlP to navigate definitions in current buffer
call ctrlp_bdelete#init()
let g:ctrlp_max_files=0
if executable('ag')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag --path-to-ignore ~/.vim/ctrlp_ignore %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
nnoremap <leader>pm :CtrlP app/models/<CR>
nnoremap <leader>pc :CtrlP app/controllers/<CR>
nnoremap <leader>pv :CtrlP app/views/<CR>
nnoremap <leader>po :CtrlP app/operations/<CR>
nnoremap <leader>ps :CtrlP app/services/<CR>


" vim-surround
" Map it it to gs (instead of ys)
map gs <Plug>Ysurround
map gss <Plug>Yssurround
vmap gs <Plug>VSurround
vmap gS <Plug>VgSurround

" rspec
map <Leader>tf :call SpecRunner('f', 'tmux')<CR>
map <Leader>tt :call SpecRunner('t', 'vim')<CR>
map <Leader>ta :call SpecRunner('a', 'tmux')<CR>
map <Leader>tl :call SpecRunner('l', 'tmux')<CR>
map <Leader>tc :call CreateSpec()<CR>

function! SpecRunner(type, runner)
  if a:runner == 'vim'
    let g:rspec_command = "!rspec {spec}"
  elseif a:runner == 'tmux'
    let g:rspec_command = "call VtrSendCommand('rspec {spec}')"
  endif

  if a:type=='t'
    call RunNearestSpec()
  elseif a:type=='f'
    call RunCurrentSpecFile()
  elseif a:type == 'l'
    call RunLastSpec()
  elseif a:type == 'a'
    call RunAllSpecs()
  endif
endfunction

function! CreateSpec()
  let suggested_spec_name = 'spec/' . substitute(expand('%'), "app/", "", "")
  let suggested_spec_name = substitute(suggested_spec_name, ".rb$", "_spec.rb", "")
  let spec_name = input('Spec file name: ', suggested_spec_name, 'file')
  exec ':e ' . spec_name
endfunction

" tmux integration
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <C-j> :TmuxNavigateDown<CR>
nnoremap <silent> <C-k> :TmuxNavigateUp<CR>
nnoremap <silent> <C-l> :TmuxNavigateRight<CR>
" nnoremap <silent> <C-\> :TmuxNavigatePrevious<CR>
nnoremap <silent> <C-\> :VtrFocusRunner<CR>
" map <leader>\ :VtrFocusRunner<CR>
map <leader>ro :VtrOpenRunner<CR>
map <leader>ra :VtrAttachToPane<CR>
" map <leader>rr :VtrFocusRunner<CR>
map <leader>rf :VtrSendFile<CR>
map <leader>rd :VtrSendCtrlD<CR>
map <leader>rc :VtrClearRunner<CR>
map <leader>rs :VtrSendLinesToRunner<CR>
map <leader>rl :VtrOpenRunner<CR>:VtrSendCommandToRunner !!<CR>
map <leader>rri :VtrOpenRunner<CR>:VtrSendCommandToRunner irb<CR>
map <leader>rrc :VtrOpenRunner<CR>:VtrSendCommandToRunner rails c<CR>
" let g:VtrStripLeadingWhitespace = 0
" let g:VtrClearEmptyLines = 0
" let g:VtrAppendNewline = 1


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

" " provide hjkl movements in Insert
" imap <C-h> <C-o>h
" imap <C-j> <C-o>j
" imap <C-k> <C-o>k
" imap <C-l> <C-o>l

" Use C-h/j/k/l to move between splits
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-h> <C-w>h
" nnoremap <C-l> <C-w>l
" provided by christoomey/vim-tmux-runner

" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" Airline apperance
" let g:airline_branch_prefix = ' sss '

" Setup open compactcode/alternate.vim file (alternate)
:command A Open(alternate#FindAlternate())
:command AH OpenHorizontal(alternate#FindAlternate())
:command AV OpenVertical(alternate#FindAlternate())

" Searching with ag/ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case --path-to-ignore ~/.agignore'
  set grepprg=ag\ --nogroup\ --nocolor
endif

" Projetc wide search
nnoremap <leader>/ :Ack<SPACE>
" Search current word in project
nnoremap <leader>? :Ack! "\b<C-R><C-W>\b"<CR>:cw<CR>
" Search current word in file
nnoremap <leader>* :Ack! "\b<C-R><C-W>\b" %<CR>:cw<CR>

" Setting up tags
" Generate tags witch :tc (project) or :tb (gems)
command TagsGenerate !ctags -R -f ./tags .
command TagsGenerateGems !rbenv ctags && gem ctags
cnoreabbrev tg TagsGenerate
cnoreabbrev tgg TagsGenerateGems

" List tags for the word under the curser
nnoremap <leader>] :ts <C-R><C-W><CR>
" Add gems.tags for the tags
" command TagsExcludeGems :set tags-=gems.tags
" command TagsIncludeGems :set tags+=gems.tags
" cnoreabbrev te TagsExcludeGems
" cnoreabbrev ti TagsIncludeGems

" Git shortcuts
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gca :Git add -A<CR>:Git commit<CR>
nnoremap <leader>gcw :Git add -A<CR>:Git commit -m "WIP"<CR>
nnoremap <leader>gcc :Git commit<CR>
nnoremap <leader>gc% :Git add %<CR>:Git commit %<CR>
nnoremap <leader>ga. :Git add .<CR>:Gstatus<CR>
nnoremap <leader>ga% :Git add %<CR>:Gstatus<CR>
nnoremap <leader>gaa :Git add -A<CR>:Gstatus<CR>
nnoremap <leader>gap :Git add -A -p<CR>:Gstatus<CR>
nnoremap <leader>gps :Git push<CR>
nnoremap <leader>gpl :Git pull<CR>
nnoremap <leader>gpr :Git pull --rebase<CR>
nnoremap <leader>gpp :Git pull --rebase<CR>:Git push<CR>

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

" Clear autocmds
" autocmd!

" Map the leader key to space
let mapleader = ' '

" Use Vim settings, rather then Vi settings
" This must be first, because it changes other options as a side effect.
set nocompatible

if filereadable($HOME . "/.vim/plug")
  source ~/.vim/plug
endif

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
set cursorline       " Display a cursor line

" Searching
set incsearch        " do incremental searching
" set hlsearch         " Highlight the search
set ignorecase       " Case insensitive search
set smartcase        " Case sensitive search if the string contains captible letters

" Turn pasting on / off
nnoremap cop :setlocal paste!<CR>

" Enable file type detection and load plugin indent files as well as syntax
" highlighting
filetype plugin on
filetype indent on
syntax enable
syntax sync fromstart  " http://vim.wikia.com/wiki/Fix_syntax_highlighting

" Encoding
set fileencoding=utf-8
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,gb2312,cp936

" Appereance
set background=dark
set t_Co=256 " 256 colors
colorscheme solarized
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

  " Autocomplete ids and classes in CSS
  autocmd FileType css,scss set iskeyword=@,48-57,_,-,?,!,192-255

  " Add the '-' as a keyword in erb files
  autocmd FileType eruby set iskeyword=@,48-57,_,192-255,$,-

  " Ruby autocomplete
  autocmd FileType ruby set omnifunc=rubycomplete#Complete
  autocmd FileType ruby let g:rubycomplete_buffer_loading=1
  autocmd FileType ruby let g:rubycomplete_classes_in_global=1
  autocmd FileType ruby,eruby let g:rubycomplete_rails = 1

  autocmd FileType git set foldlevel=0

  autocmd BufWritePost *.rb,*.coffee,*.js exe ":UpdateTags"

  " automatically rebalance windows on vim resize
  autocmd VimResized * :wincmd =
augroup END

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
let g:UltiSnipsExpandTrigger="<C-d>"
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
let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlP'
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>d :CtrlPFunky<CR> " Use CtrlP to navigate definitions in current buffer
nnoremap <leader>D :CtrlPTag<CR>   " Use CtrlP to navigate tags
call ctrlp_bdelete#init()
let g:ctrlp_max_files=0
if executable('ag')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag --path-to-ignore ~/.vim/ctrlp_ignore %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
nnoremap <leader>pm :CtrlP app/models/<CR>
nnoremap <leader>pf :CtrlP spec/support/factories/<CR>
nnoremap <leader>pc :CtrlP app/controllers/<CR>
nnoremap <leader>pv :CtrlP app/views/<CR>
nnoremap <leader>po :CtrlP app/operations/<CR>
nnoremap <leader>ps :CtrlP app/services/<CR>
nnoremap <leader><leader> :CtrlP<CR>

" vim-surround
" Map it to gs (instead of ys)
nmap gs <Plug>Ysurround
nmap gS <Plug>Yssurround
vmap gs <Plug>VSurround
vmap gS <Plug>VgSurround

" Transform shell commands to use docker-compose if applicable
function! TransformCommandToUseDockerCompose(cmd) abort
  if filereadable(".test_with_compose")
    " return "docker-compose run --rm app " . a:cmd
    return "docker-compose exec app " . a:cmd
  else
    return a:cmd
  endif
endfunction

" Tests
nnoremap <leader>f :TestFile<CR>
nnoremap <leader>t :TestNearest<CR>
nnoremap <leader>T :TestNearest -strategy=simple_vtr<CR>
nnoremap <leader>A :TestSuite<CR>
nnoremap <leader>l :TestLast<CR>

function! SimpleVtrStrategy(cmd) abort
  call VtrSendCommand(a:cmd)
endfunction

let g:test#custom_strategies = {'simple_vtr': function('SimpleVtrStrategy')}
let g:test#custom_transformations = {'docker_compose': function('TransformCommandToUseDockerCompose')}
let g:test#transformation = 'docker_compose'
let test#strategy = {
  \ 'nearest': 'basic',
  \ 'file':    'simple_vtr',
  \ 'suite':   'simple_vtr',
\}

function! RunInVtr(cmd) abort
  execute ":VtrOpenRunner"
  call VtrSendCommand(TransformCommandToUseDockerCompose(a:cmd))
endfunction


" tmux integration
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <C-j> :TmuxNavigateDown<CR>
nnoremap <silent> <C-k> :TmuxNavigateUp<CR>
nnoremap <silent> <C-l> :TmuxNavigateRight<CR>
" nnoremap <silent> <C-\> :TmuxNavigatePrevious<CR>
nnoremap <silent> <C-\> :VtrFocusRunner<CR>
nnoremap <leader>ro :VtrOpenRunner<CR>
nnoremap <leader>a :VtrAttachToPane<CR>
nnoremap <leader>F :VtrSendFile<CR>
nnoremap <leader>D :VtrSendCtrlD<CR>
nnoremap <leader>C :VtrClearRunner<CR>
nnoremap <leader>s mm:VtrSendLinesToRunner<CR>`m
vnoremap <leader>s mm:VtrSendLinesToRunner<CR>`m
nnoremap <leader>S mmggVG:VtrSendLinesToRunner<CR>`m
vnoremap <leader>S mm<C-c>ggVG:VtrSendLinesToRunner<CR>`m
nnoremap <leader>L :VtrOpenRunner<CR>:VtrSendCommandToRunner !!<CR>
nnoremap <leader>rri :call RunInVtr('irb')
nnoremap <leader>rrc :call RunInVtr('rails c')<CR>
nnoremap <leader>rrs :call RunInVtr('spring stop')<CR>
nnoremap <leader>rrm :call RunInVtr('rake db:migrate db:test:prepare')<CR>
" let g:VtrStripLeadingWhitespace = 0
" let g:VtrClearEmptyLines = 0
" let g:VtrAppendNewline = 1

" Other helpers
" Add a shortcut to add a description to Rake tasks
" this should go in a ftplugin
nnoremap <leader>rad $?^\s*task<CR>:nohlsearch<CR>Odesc ""<ESC>i

nnoremap <leader>w :w<CR>
nnoremap <leader>W ZZ
nnoremap <leader>x :q<CR>

nnoremap j gj
nnoremap k gk

nnoremap <leader>j <C-w>w

" Tabs and editing
nnoremap gb gT
nnoremap <leader>E :tabe<CR>:e 
let g:markdown_mapping_switch_status = '<leader>c'

" List toggles
let g:lt_location_list_toggle_map = '<leader>Q'
let g:lt_quickfix_list_toggle_map = '<leader>q'

" Disable Arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Disable Arrow keys in Insert mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" Allow movement in insert mode via <C-...>
imap <C-j> <C-o>j
imap <C-k> <C-o>k
imap <C-l> <C-o>l
imap <C-h> <C-o>h

" Use C-h/j/k/l to move between splits
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-h> <C-w>h
" nnoremap <C-l> <C-w>l
" provided by christoomey/vim-tmux-runner

" Zoom / rebalance splits
nnoremap <leader>- :wincmd _<CR>:wincmd \|<CR>
nnoremap <leader>= :wincmd =<CR>

" Resize splits
nnoremap <silent> <Leader><Up> :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader><Down> :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent> <Leader><Right> :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent> <Leader><Left> :exe "vertical resize " . (winwidth(0) * 2/3)<CR>

" Setup open compactcode/alternate.vim file (alternate)
command! A Open(alternate#FindAlternate())
command! AH OpenHorizontal(alternate#FindAlternate())
command! AV OpenVertical(alternate#FindAlternate())
command! CA Open(suggest_alternate#FileName())
command! CAH OpenHorizontal(suggest_alternate#FileName())
command! CAV OpenVertical(suggest_alternate#FileName())

nnoremap <leader>O <C-w><C-o>
nnoremap <leader>o <C-w><C-o>:AV<CR>
nnoremap <leader>c :CAV<CR>
nnoremap <leader>C :CA<CR>

" Copying
let g:system_copy#copy_command='reattach-to-user-namespace pbcopy'

" Searching with ag/ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case --path-to-ignore ~/.agignore'
  set grepprg=ag\ --nogroup\ --nocolor
endif

" Projetc wide search

function! ExtractVisualSelectionForAck()
    let old = @"
    norm! gvy
    let pattern = shellescape(substitute(@", '\n\+$', '', ''))
    let @" = old
    return pattern
endfunction

nnoremap <leader>/ :Ack!<SPACE>
" This requires nmap. Otherwise the iskeyword is not interpreted properly
nmap <leader>? :Ack! "<C-r><C-w>" -Q<CR>:cw<CR>
nmap <leader>* :Ack! "<C-r><C-w>" % -Q<CR>:cw<CR>
vnoremap <Leader>? :<C-u>execute "Ack! " . ExtractVisualSelectionForAck() . " -Q"<CR>:cw<CR>
vnoremap <Leader>* :<C-u>execute "Ack! " . ExtractVisualSelectionForAck() . " -Q %"<CR>:cw<CR>

nnoremap [c :colder<CR>
nnoremap ]c :cnewer<CR>

" Setting up tags
" Generate tags witch :tg (project) or :tgg (gems)
function! UpdateTags()
  let fullpath = expand("%:p")
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  if filereadable(tagfilename)
    let f = substitute(fullpath, cwd . "/", "", "")
    let f = escape(f, './')
    let cmd = 'sed -i.bkp "/' . f . '/d" "' . tagfilename . '"'
    let resp = system(cmd)
    let cmd = 'ctags -a -f ' . tagfilename . ' ' . f
    let resp = system(cmd)
  endif
endfunction

command! GenerateTags !ctags -R -f ./tags .
command! GenerateGemTags !rbenv ctags && gem ctags
command! UpdateTags call UpdateTags()
cnoreabbrev tg GenerateTags
cnoreabbrev tgg GenerateGemTags
cnoreabbrev tu UpdateTags

" Open tags in a vertical split / tab
nmap <leader>] :vsp<CR><C-]>
nmap <leader><C-]> <C-w><C-]><C-w>T

" Git shortcuts
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gdc :Gdiff --cached<CR>
nnoremap <leader>gca :Git add -A<CR>:Git commit<CR>
nnoremap <leader>gcw :Git add -A<CR>:Git commit -m "WIP"<CR>
nnoremap <leader>gci :Git commit<CR>
nnoremap <leader>gc% :Git add %<CR>:Git commit %<CR>
nnoremap <leader>ga. :Git add -p .<CR>:Gstatus<CR>
nnoremap <leader>ga% :Git add -p %<CR>:Gstatus<CR>
nnoremap <leader>gaa :Git add -A<CR>:Gstatus<CR>
nnoremap <leader>gap :Git add -p -A -p<CR>:Gstatus<CR>
nnoremap <leader>gps :Git push<CR>
nnoremap <leader>gpl :Git pull<CR>
nnoremap <leader>gpr :Git pull --rebase<CR>
nnoremap <leader>gsp :Git stash<CR>:Git pull --rebase<CR>:Git stash pop<CR>
nnoremap <leader>gpp :Git pull --rebase<CR>:Git push<CR>

" Make C-c send Esc in insert mode
inoremap <C-c> <Esc>
inoremap jk <Esc>

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
nnoremap <leader>R :call RenameFile()<CR>

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

nnoremap <leader>V :source ~/.vimrc<CR>

let g:rails_projections = {
      \ "app/operations/*.rb": {
      \   "command": "operation",
      \   "template":
      \     ["class {camelcase|capitalize|colons}", "  include Callable", "end"],
      \   "test": [
      \     "test/operations/{}_test.rb",
      \     "spec/operations/{}_spec.rb"
      \   ]
      \ }}

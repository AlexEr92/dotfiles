" ----- Vim-Plug core -----
let vimplug_exists=expand('~/.vim/autoload/plug.vim')
let curl_exists=expand('curl')

if !filereadable(vimplug_exists)
  if !executable(curl_exists)
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!"curl_exists" -fLo " . shellescape(vimplug_exists) . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

call plug#begin(expand('~/.vim/plugged'))

" Plug install packages

" Comments
Plug 'tpope/vim-commentary'

" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb' " required by fugitive to :GBrowse
Plug 'airblade/vim-gitgutter'

" Colorscheme
Plug 'morhetz/gruvbox'

" Fuzzy Finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Tags
Plug 'majutsushi/tagbar'

" Tmux integration
Plug 'christoomey/vim-tmux-navigator'

" Grepper
Plug 'mhinz/vim-grepper'

" Easymotion
Plug 'easymotion/vim-easymotion'

" vim-unimpared
Plug 'tpope/vim-unimpaired'

call plug#end()

" ----- General Settings -----

" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set ttyfast

" Disable compatibility with vi
set nocompatible

" Filetype detection
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Add numbers
set number

" Turn syntax highlighting on
syntax on

" Highlight current line
set cursorline

" Colorscheme
if has("gui_running")
  set background=light
  colorscheme solarized
else
  set background=dark
  colorscheme gruvbox
endif

" Mouse support
set mouse=a

" While searching though a file incrementally highlight matching characters as you type.
set hlsearch
set incsearch

" Ignore capital letters during search.
set ignorecase

" Set the commands to save in history (default number is 20).
set history=1000

" Enable auto completion menu after pressing TAB.
set wildmenu

" Setting the split window
set splitbelow splitright

" Statusline
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\
if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif

" ----- Plugins Settings -----
" Grepper
let g:grepper = {}
let g:grepper.tools = [ 'grep', 'git', 'rg' ]

" Tagbar
let g:tagbar_autofocus = 1

" ----- Keybindings -----

let mapleader = " "

map <leader>e :Lex<CR>

" Navigation between panes
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Tabs
nnoremap <leader>te :tabedit<CR>
nnoremap <leader>tn :tabnext<CR>
nnoremap <leader>tp :tabprev<CR>
nnoremap <leader>tc :tabclose<CR>

" Comments
nnoremap <leader>/ gcc

" Terminal
nnoremap <silent> <leader>sh :terminal<CR>

" Git
noremap <leader>gs :Git<CR>

" FZF
nnoremap <silent> <leader>fb :Buffers<CR>
nnoremap <silent> <leader>ff :FZF -m<CR>

" Buffers
noremap <silent> <leader>bp :bprevious<CR>
noremap <silent> <leader>bn :bnext<CR>
noremap <silent> <leader>bd :bdelete<CR>

" Tags
nnoremap <silent> <leader>tg :TagbarToggle<CR>

" Grepper
nnoremap <leader>* :Grepper -cword -noprompt<CR>
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Clean search (highlight)
nnoremap <silent> <leader>nh :noh<cr>

" ----- Commands -----

" Remove trailing whitespaces
command! FixWhitespace :%s/\s\+$//e

" Ripgrep
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
endif

" ----- Autocommands -----

" Disable comment after enter
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Highlight trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
  match ExtraWhitespace /\s\+$/


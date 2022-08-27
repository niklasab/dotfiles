" VIM can be compiled with both python2 and python3 support
" This forces python3
" (https://robertbasic.com/blog/force-python-version-in-vim/)
if has('python3')
endif

" Plugins
call plug#begin('~/.config/nvim/autoload/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Base plugin for FZF
Plug 'junegunn/fzf.vim'  " Fuzzy find
Plug 'psliwka/vim-smoothie' " Smooth scroll
Plug 'mhinz/vim-startify' " Session manager
Plug 'tpope/vim-fugitive', " Work with git
Plug 'airblade/vim-gitgutter' " Show git markers in sign column
Plug 'rhysd/vim-clang-format', " Clang format code
Plug 'itchyny/lightline.vim', " Better statusbar
Plug 'kyazdani42/nvim-web-devicons' " Icons
Plug 'kyazdani42/nvim-tree.lua' " File browser
Plug 'akinsho/bufferline.nvim' " Show buffers as tabs
Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intellisense
Plug 'nanotech/jellybeans.vim' " Colorscheme
Plug 'honza/vim-snippets' " Snippets collection
Plug 'nvim-lua/plenary.nvim' " Required by diffview
Plug 'sindrets/diffview.nvim' " Cycle through git diffs easily
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General

" This is typically set by default, but set it just in case
set nocompatible

" Might not be required anymore (keep it just in case)
filetype off

" How close to the border when moving the cursor up and down
" before scrolling
set so=7

" Sets how many lines of history VIM has to remember
set history=700

" Line numbering
set number

" Enables command line completion
set wildmenu

"Always show current position
set ruler

" Only case sensitive search when you use capital letters
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers (jumps to
" next match automatically)
set incsearch

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" Always show the status line
set laststatus=2

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Be smart when using tabs
set smarttab

" Tab width is 4 spaces
set tabstop=4

" Indent also with 4 spaces
set shiftwidth=4

" Use spaces instead of tabs
set expandtab

" Use indentation of previous line
set autoindent

" Use intelligent indentation for C like programs
set smartindent

"Wrap lines (this is default)
set wrap

" Enable syntax highlighting
syntax enable

" Hide end of buffer tilde (~)
set fillchars=eob:\ 

" Highlight current line
set cursorline

" Always show the signcolumn (for gitgutter and coc)
set signcolumn=yes:1
"set signcolumn=number (to replace number instead)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General bindings

" Leader key
noremap <Space> <Nop>
let mapleader = "\<Space>"

" Fast saving and closing (normal mode map)
nmap <leader>w :w!<cr>
nmap <leader>q :q<cr>

" Remove annoying binding
map q <Nop>

" Moving between windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Make enter in visual act as enter in edit
nmap <CR> o<Esc>

" Make j and k act the same for wrapped lines
map j gj
map k gk

" Personal cheatsheet for vim
nnoremap <silent> <F2> :split ~/.config/nvim/cheatsheet.md<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings per file type
autocmd Filetype html setlocal sts=2 sw=2 expandtab
autocmd Filetype ruby setlocal sts=2 sw=2 expandtab
autocmd Filetype eruby setlocal sts=2 sw=2 expandtab
autocmd Filetype html.erb setlocal sts=2 sw=2 expandtab
autocmd Filetype javascript setlocal sts=2 sw=2 expandtab
autocmd Filetype erb setlocal sts=2 sw=2 expandtab
autocmd Filetype css setlocal sts=2 sw=2 expandtab
autocmd Filetype scss setlocal sts=2 sw=2 expandtab
autocmd Filetype yml setlocal sts=2 sw=2 expandtab
autocmd Filetype en.yml setlocal sts=2 sw=2 expandtab
autocmd Filetype sv.yml setlocal sts=2 sw=2 expandtab
autocmd Filetype markdown setlocal sts=4 sw=4 expandtab

" Enable nested folding for markdown
let g:markdown_fold_style = 'nested'
let g:markdown_folding = 1

" Remember fold state on close/open
" https://vi.stackexchange.com/questions/5488/can-i-save-folds?rq=1
augroup SaveManualFolds
    autocmd!
    autocmd BufWinLeave, BufLeave ?* silent! mkview | filetype detect
    autocmd BufWinEnter ?* silent! loadview | filetype detect
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Theme

" Full color support
set termguicolors

" Colorscheme
" Two sites to find other themes:
" http://bytefluent.com/vivify/
" https://vimcolorschemes.com/
" Old scheme:
"    colorscheme hipster
" TODO: Might need another theme to show full semantic highlighting

let MainColor = "111111"
let SubColor = "222222"

" Override Jellybean colors
let g:jellybeans_overrides = {
\    'background': { 'guibg': MainColor },
\}

colorscheme jellybeans

" Use the dark colors of the colorscheme
set background=dark

" Override some colorscheme settings
" Tip: run :hi to list all current colors
" TODO: Match cterm colors with gui colors
hi clear Search
execute 'hi Search ctermbg=Gray guibg=#' . SubColor
hi ErrorMsg guibg=black guifg=#ea5252
execute 'hi Pmenu ctermfg=0 ctermbg=13 guifg=#ffffff guibg=#' . SubColor
hi PmenuSel ctermfg=0 ctermbg=13 guifg=black guibg=#b8cc52
hi SignColumn ctermfg=14 ctermbg=242 guifg=#777777 guibg=NONE
hi clear CursorLine
hi clear NonText
hi StatusLine guifg=#ffffff guibg=NONE
execute 'hi Visual guibg=#' . SubColor
execute 'hi Folded guibg=#' . SubColor
execute 'hi ErrorMsg guibg=#' . MainColor

" Pad to left by using fold column
set foldcolumn=1
hi clear FoldColumn

" Minimal vertical split
hi VertSplit ctermbg=NONE guibg=NONE

" GitGutter signs
" Note: GitGutter has a good README for more config
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Nice-to-haves

" Auto resize window splits when main window size changes
autocmd VimResized * wincmd =

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=#ea5252
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Auto trim trailing whitespace (and keep cursor position)
" A bit problematic, so not enabled for now
" TODO: Keybind it
"function! TrimWhiteSpace()
    "let l = line(".")
    "let c = col(".")
    "keepp %s/\s\+$//e
    "call cursor(l, c)
"endfunction
"autocmd BufWritePre * :call TrimWhiteSpace()

" This makes yy work across vim instances and with ctrl-c/ctrl-p
" in other programs
set clipboard=unnamedplus

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NvimTree (Plugin)
nnoremap <C-n> :NvimTreeToggle<CR>

" Hide status line in nvim tree
au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if bufname('%') =~ "NvimTree*" | set laststatus=0 | else | set laststatus=2 | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Lightline (Plugin)

source ~/.config/nvim/colors/ayu_dark_custom.vim
let g:lightline = {
      \ 'colorscheme': 'ayu_dark_custom',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Startify (Plugin)

let g:startify_session_dir = '~/.config/vim-sessions/'
" Save session
nnoremap <leader>ss :SSave<CR>

" Close session
nnoremap <leader>sc :SClose<CR>

" Load session
nnoremap <leader>sl :SLoad<CR>

" How many recent files to show
let g:startify_files_number           = 0

" Session should be updated if you exit vim
let g:startify_session_persistence    = 1

" Show simple list instead of the default one
let g:startify_lists = [
  \ { 'type': 'sessions',  'header': ['   Saved sessions'] },
  \ ]

" Fancy custom header
let g:startify_custom_header = [
  \ "  ",
  \ ]

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF (plugin)

" Fuzzy find files
nnoremap <silent> <C-p> :Files<CR>
" Fuzzy find buffers
nnoremap <silent> <C-b> :Buffers<CR>
" Fuzzy find lines in loaded buffers
nnoremap <silent> <C-_> :Lines<CR>
" Grep in working directory
nnoremap <C-f> :Rg!<Space>

" Search word under cursor
" TODO: Add a way to also search selection under cursor
command! -bang -nargs=* RgExact
  \ call fzf#vim#grep(
  \   'rg -F --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)
nmap <C-g> :execute 'RgExact ' . expand('<cword>') <Cr>

" Use FZF to quickly change PWD to any directory in ~./.bookmarks_fzf
function! s:ChangeDirectory(path)
    " Also set env so that a new terminal in i3 spawns in this directory
    let $PWD=a:path
    exec "cd ".a:path
endfunction
function! ListFavorites(path)
    call fzf#run({
        \   'source': 'cat ~/.bookmarks_fzf',
        \   'sink': function(a:path)
        \ })
endfunction
command BMChangeDirectory execute "call ListFavorites('s:ChangeDirectory')"
nmap <C-e> :execute 'BMChangeDirectory' <Cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ctags (as fallback when there is no compile_commands.json for CoC)

" Go to definition
"nnoremap <silent> <C-o> <C-]>
nnoremap <silent> <C-i> <C-]>

" Look for an rtags file by traversing upward until found
set tags=tags;/

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Clang format

" Code format on save
" TODO: Don't enable this globally, find a way to enable it per project
"let g:clang_format#auto_format=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Coc (Plugin)
" Note: See coc-settings.json for more settings (e.g. icons)
" Most settings stolen from Coc README

set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c

" Plugins
let g:coc_global_extensions = ['coc-clangd', 'coc-snippets']

" Use tab for trigger completion with characters ahead and navigate. (also for
" snippets)
inoremap <silent><expr> <TAB>
      \ pumvisible() ?
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Navigate snippet
let g:coc_snippet_next = '<tab>'

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GitGutter (Plugin)
nmap <leader>hs <Plug>(GitGutterStageHunk)
nmap gu <Plug>(GitGutterUndoHunk)
nmap gn <Plug>(GitGutterNextHunk)
nmap gp <Plug>(GitGutterPrevHunk)
nmap ghp <Plug>(GitGutterPreviewHunk)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Includes

" Include lua code in separate file (TODO: Translate everything to lua)
source ~/.config/nvim/lua.vim

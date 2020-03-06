" Author: Rohan McLure

"
"   General VIM Settings
"

syntax on
set termguicolors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
set t_Co=256
let &t_8f='[38;2;%lu;%lu;%lum'
let &t_8b='[48;2;%lu;%lu;%lum'
set t_AB=^[[48;5;%dm
set t_AF=^[[38;5;%dm]]]]
if &term =~ '256color'
    " disable background color erase
    set t_ut=
endif

" highlight Normal ctermbg=black ctermfg=white

filetype plugin indent on
set nocompatible
set noswapfile
set autoindent
set autoread
set updatetime=100

" Line numbers
set number
set numberwidth=2

" Highlight current line
set cursorline

" Searching
set incsearch hlsearch ignorecase smartcase

" Persistent Undo
set undofile

" Just to get tabs to work
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Remove the Vim thingo
set noshowmode

" Spelling 
set spell spelllang=en_au

" Always use horizontal split
set splitbelow splitright

" System clipboard
set clipboard=unnamedplus

" Use tall cmdheight for debugging
set cmdheight=1

" Also overrides TMUX mouse capture (what I want) 
set mouse=a

"
"   Package Setup
"

call plug#begin('~/.vim/autoload/')

" Better dev experience
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'godlygeek/tabular'
Plug 'scrooloose/nerdtree', { 'off' : 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'mileszs/ack.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dbeecham/ctrlp-commandpalette.vim'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'

" Plug 'ycm-core/YouCompleteMe'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }


" Language server
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}

" Visuals
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons'
Plug 'severin-lemaignan/vim-minimap'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Latex
Plug 'lervag/vimtex'

" Better concealing for Latex
Plug 'PietroPate/vim-tex-conceal'

" Markdown
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } } " Autoinstall w/o invoking nodejs
autocmd Filetype pandoc setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

" Julia
Plug 'JuliaEditorSupport/julia-vim'
autocmd Filetype julia setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

" JavaCC
autocmd Filetype javacc setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

call plug#end()

"
"   a e s t h e t i c s
"

" Gruvbox
let g:gruvbox_bold = 1
let g:gruvbox_italic = 1
let g:gruvbox_underline = 1
let g:gruvbox_undercurl = 1
colorscheme gruvbox
set background=light
let g:gruvbox_contrast_light = "high"
let g:gruvbox_termcolors = 256
let g:gruvbox_number_column = 'fg'

"
"   Vim Lightline - or how I learned to stop worrying and love buffers
"

let g:lightline = {
      \    'enable' : {
      \        'statusline': 1,
      \        'tabline': 1
      \    },
      \    'statusline' : {
      \        'left' : [ [ 'buffers' ] ]
      \    },
      \    'tabline' : {
      \        'left'  :  [ [ 'gitbranch' ] ],
      \        'right' :  [ [ ] ]
      \    },
      \    'colorscheme': 'gruvbox',
      \    'component_expand' : {
      \        'buffers' : 'lightline#bufferline#buffers'
      \    },
      \    'component' : { 'null' : ' ' },
      \    'component_type' : {
      \        'buffers' : 'tabsel'
      \    },
      \    'active': {
      \        'left': [ [ 'mode', 'paste'],
      \                  [ 'readonly'],
      \                  [ 'buffers' ]
      \                ],
      \        'right': [ [ 'lineinfo'  ],
      \                   [ 'percent'   ],
      \                   [ 'filetype' ],
      \                 ]
      \    },
      \    'component_function' : {
      \        'gitbranch' : 'FugitiveHead'
      \    }
      \ }

" function! ShowTabLineIfBranch!()
"     if (FugitiveHead() !=
" endfunction

" Force tabline
if has('gui_running')
    set guioptions-=e
endif

set showtabline=1

" Buffers in the tabline - but in the statusline :P
let g:lightline#bufferline#filename_modifier=':t'
let g:lightline#bufferline#enable_devicons=1
autocmd BufWritePost,TextChanged,TextChangedI * call lightline#update()

" Git line number annotations
highlight link GitGutterChangeLineNr DiffAdd
highlight link GitGutterAddLineNr DiffChange
highlight link GitGutterDeleteLineNr DiffDelete
highlight link GitGutterChangeDeleteLineNr DiffChange

set hidden

"
"   Key Bindings
"

let mapleader=";"

" Quicker Spelling correction
nmap <leader>z 1z=

" Window Navigation
autocmd VimEnter * nmap <leader>H <C-w>H
autocmd VimEnter * nmap <leader>J <C-w>J
autocmd VimEnter * nmap <leader>K <C-w>K
autocmd VimEnter * nmap <leader>L <C-w>L
autocmd VimEnter * nmap <leader>h <C-w>h
autocmd VimEnter * nmap <leader>j <C-w>j
autocmd VimEnter * nmap <leader>k <C-w>k
autocmd VimEnter * nmap <leader>l <C-w>l
autocmd VimEnter * nmap <leader>Q <C-w>q

" Buffer navigation
autocmd VimEnter * nmap <leader>p :bp<CR>
autocmd VimEnter * nmap <leader>n :bn<CR>
" nmap <leader>q :bp <BAR> bd #<CR>
autocmd VimEnter * nmap <leader>q :bd <CR>
" autocmd VimEnter * nmap <leader>l :ls<CR>

" Do a cheekii make
autocmd VimEnter * nmap <leader>M :! make <CR>

"
"   Making (Neo)Vim an IDE
"

" Allow me to write LaTeX + Emoji
" call LaTeXtoUnicode#Init()
let g:latex_to_unicode = 1

" Toggle sign column
" Toggle signcolumn. Works only on vim>=8.0 or NeoVim
function! ToggleSignColumn()
    if !exists("b:signcolumn_on") || b:signcolumn_on
        set signcolumn=no
        let b:signcolumn_on=0
    else
        set signcolumn=auto
        let b:signcolumn_on=1
    endif
endfunction
nmap <Leader>s :call ToggleSignColumn()<CR>

" Git indicators 
let g:gitgutter_enabled=1
let g:gitgutter_signs=0
let g:gitgutter_highlight_lines=0
let g:gitgutter_highlight_linenrs=1
let g:gitgutter_async=1
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1

" Remove <leader>h prefixed boiis
let g:gitgutter_map_keys = 0
nmap <Leader>g :GitGutterSignsToggle<CR> :GitGutterLineNrHighlightsToggle<CR>

" Completions
" let g:deoplete#enable_at_startup = 1
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect

" Files fuzzy finder
let g:ctrlp_show_hidden = 1
nmap <Leader>f <C-p>

" Hide Number Gutter
nmap <Leader>m :set invnumber<CR>

" Commands fuzzy finder
nmap <Leader>t :CtrlPCommandPalette<cr>

" Project view
nmap <Leader>d :NERDTreeToggle<CR>
" autocmd BufEnter * silent NERDTreeMirror

" Global search
" Not an actual command, just cause vim to type out the prefix
nmap <Leader>a :Ack!<Space>

" Julia
let g:default_julia_version = '1.3.0'

" That Markdown life
" Remove Pandoc column on left-hand-side
let g:pandoc#folding#fdc = 0
" Markdown Preview
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0 " Don't permit use in other files
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_echo_preview_url = 0
let g:mkdp_browser = "google-chrome"

" Language Server
let g:LanguageClient_autoStart = 0
let g:LanguageClient_serverCommands = {
\   'julia': ['julia', '--startup-file=no', '--history-file=no', '-e', '
\       using LanguageServer;
\       using Pkg;
\       import StaticLint;
\       import SymbolServer;
\       env_path = dirname(Pkg.Types.Context().env.project_file);
\       debug = true; 
\       
\       server = LanguageServer.LanguageServerInstance(stdin, stdout, debug, env_path, "", Dict());
\       server.runlinter = true;
\       run(server);
\   '],
\   'rust': ['rustup', 'run', 'nightly', 'rls']
\ }

nmap <silent> K :call LanguageClient_textDocument_hover()<CR>
nmap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nmap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

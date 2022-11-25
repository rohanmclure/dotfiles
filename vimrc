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

" Global statusline if supported
if has('nvim-0.8.0')
  set laststatus=3
endif

set secure exrc

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
set tabstop=2
set shiftwidth=2
set softtabstop=2
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

call plug#begin('~/.vim/plugged/')

function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [], 'do': [], 'branch': [] })
endfunction

Plug 'zyedidia/vim-snake'

" Better dev experience
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-dotenv'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'godlygeek/tabular'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'airblade/vim-gitgutter'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'preservim/tagbar'
Plug 'sainnhe/tmuxline.vim'
Plug 'junegunn/goyo.vim'
Plug 'zenbro/mirror.vim'

" Org Mode (?!)
Plug 'jceb/vim-orgmode',                  Cond(!exists('g:vscode'))

" Language server
Plug 'neoclide/coc.nvim',                 Cond(!exists('g:vscode'),    {'branch': 'release'})
Plug 'josa42/vim-lightline-coc' 
Plug 'OmniSharp/omnisharp-vim'

" Multi-entry selection UI. FZF
Plug 'junegunn/fzf',                      Cond(!exists('g:vscode'), { 'do': { -> fzf#install() } }),
Plug 'junegunn/fzf.vim',                  Cond(!exists('g:vscode'))
Plug 'antoinemadec/coc-fzf',              Cond(!exists('g:vscode'))
Plug 'zackhsi/fzf-tags',                  Cond(!exists('g:vscode'))
Plug 'jZhangTk/vim-agriculture',          Cond(!exists('g:vscode'))

" Visuals
Plug 'itchyny/lightline.vim',             Cond(!exists('g:vscode'))
Plug 'mengelbrecht/lightline-bufferline', Cond(!exists('g:vscode'))
Plug 'srcery-colors/srcery-vim',          Cond(!exists('g:vscode'))
Plug 'morhetz/gruvbox',                   Cond(!exists('g:vscode'))
Plug 'kyazdani42/nvim-web-devicons',      Cond(!exists('g:vscode'))
Plug 'wfxr/minimap.vim',                  Cond(!exists('g:vscode'))

" Latex
Plug 'lervag/vimtex'

" Rust
Plug 'rust-lang/rust.vim'

" Better concealing for Latex
Plug 'PietroPate/vim-tex-conceal'

" Markdown
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'iamcco/markdown-preview.nvim',                                    { 'do': { -> mkdp#util#install() } } " Autoinstall w/o invoking nodejs

" Isabelle
Plug 'ThreeFx/isabelle.vim',                                            {'branch': 'main'}
Plug 'ThreeFx/coc-isabelle',                                            {'branch': 'main', 'do': 'yarn install --frozen-lockfile'}

" Julia
Plug 'JuliaEditorSupport/julia-vim'

call plug#end()

"
" File-Triggered formatting, XDG support etc.
"

autocmd Filetype pandoc setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype julia setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

" PaRSEC
au BufRead,BufNewFile *.jdf set filetype=cpp

" JavaCC
autocmd Filetype javacc setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

" Open Files with GUI app
au BufRead *.jpg sil exe "!xdg-open " . shellescape(expand("%:p")) | bd | let &ft=&ft | redraw!
au BufRead *.png sil exe "!xdg-open " . shellescape(expand("%:p")) | bd | let &ft=&ft | redraw!
au BufRead *.docx sil exe "!xdg-open " . shellescape(expand("%:p")) | bd | let &ft=&ft | redraw!
au BufRead *.doc sil exe "!xdg-open " . shellescape(expand("%:p")) | bd | let &ft=&ft | redraw!
au BufRead *.xlsx sil exe "!xdg-open " . shellescape(expand("%:p")) | bd | let &ft=&ft | redraw!
au BufRead *.xls sil exe "!xdg-open " . shellescape(expand("%:p")) | bd | let &ft=&ft | redraw!
au BufRead *.pdf sil exe "!xdg-open " . shellescape(expand("%:p")) | bd | let &ft=&ft | redraw!
au BufRead *.dvi sil exe "!xdg-open " . shellescape(expand("%:p")) | bd | let &ft=&ft | redraw!

"
"   LSP Language Server
"

set completeopt=menuone,noinsert,noselect

"
"   a e s t h e t i c s
"

if !exists('g:vscode')
" Gruvbox
let g:gruvbox_bold = 1
let g:gruvbox_italic = 1
let g:gruvbox_underline = 1
let g:gruvbox_undercurl = 1
let g:gruvbox_contrast_light = "soft"
colorscheme gruvbox
set background=light
let g:gruvbox_termcolors = 256
let g:gruvbox_number_column = 'fg'

" Lightline
function! GitGlobal() abort "{{{
    if exists('*FugitiveHead')
        let branch = FugitiveHead()
        if branch ==# ''
            return ' ' . fnamemodify(getcwd(), ':t')
        else
            return ' ' . branch
        endif
    endif
    return ''
endfunction "}}}

let g:lightline = {
      \    'enable' : {
      \        'statusline': 1,
      \        'tabline': 1
      \    },
      \    'statusline' : {
      \        'left' : [  ]
      \    },
      \    'tabline' : {
      \        'left'  :  [ [ 'buffers' ] ],
      \        'right' :  [ ]
      \    },
      \    'colorscheme': 'gruvbox',
      \    'component_expand' : {
      \        'buffers' : 'lightline#bufferline#buffers'
      \    },
      \    'component' : { 'null' : ' ' },
      \    'component_raw' : { 'buffers' : 1 },
      \    'component_type' : {
      \        'buffers' : 'tabsel'
      \    },
      \    'active': {
      \        'left': [ [ 'mode', 'paste' ],
      \                  [ 'git_status', 'readonly' ],
      \                  [ 'relativepath' ]
      \                ],
      \        'right': [ [ 'lineinfo', 'coc_info', 'coc_hints', 'coc_errors', 'coc_warnings'  ],
      \                   [ 'percent'   ],
      \                   [ 'filetype', 'obsession_status'],
      \                 ]
      \    },
      \    'inactive': {
      \        'left': [ [ 'relativepath' ] ]
      \    },
      \    'component_function' : {
      \        'git_status' : 'GitGlobal',
      \        'obsession_status' : 'ObsessionStatus'
      \    },
      \    'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
      \    'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" },
      \ }
call lightline#coc#register()

" Buffers in the tabline - but in the statusline :P
" let g:lightline#bufferline#filename_modifier=':t'
let g:lightline#bufferline#enable_devicons=1
let g:lightline#bufferline#more_buffers = 1
let g:lightline#bufferline#shorten_path = 0
let g:lightline#bufferline#smart_path = 1
let g:lightline#bufferline#clickable = 1
let g:lightline#bufferline#show_number = 2 " Give me ordinal numbers
autocmd BufWritePost,TextChanged,TextChangedI * call lightline#update()

" Tabline
if has('gui_running')
    set guioptions-=e
endif

set showtabline=2

" Buffers in the tabline - but in the statusline :P
" let g:lightline#bufferline#filename_modifier=':t'
let g:lightline#bufferline#enable_devicons=1
let g:lightline#bufferline#more_buffers = 1
let g:lightline#bufferline#shorten_path = 0
let g:lightline#bufferline#smart_path = 1
let g:lightline#bufferline#clickable = 1
let g:lightline#bufferline#show_number = 2 " Give me ordinal numbers
autocmd BufWritePost,TextChanged,TextChangedI * call lightline#update()

" Minimap
let g:minimap_highlight_range = 1
let g:minimap_git_colors = 1

"
"   File Navigator
"

lua << EOF
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
EOF

endif " !exists('g:vscode')

"
"   Key Bindings
"

let mapleader=";"

" Zen Mode
if !exists('g:vscode')
  autocmd VimEnter * nmap <Leader>Z :Goyo <CR>
else
  autocmd VimEnter * nmap <Leader>Z <Cmd>call VSCodeNotify('workbench.action.toggleZenMode')<CR>
endif

" Terminal Mode -> Not working yet
autocmd VimEnter * nmap <Leader>E <C-\><C-n>

" Vim Debugger
autocmd VimEnter * :packadd termdebug <CR>
autocmd VimEnter * nmap <Leader>D :Termdebug<Space>
autocmd VimEnter * nmap <Leader>Db :Break <CR>
autocmd VimEnter * nmap <Leader>Dn :Next <CR>
autocmd VimEnter * nmap <Leader>Ds :Step <CR>
autocmd VimEnter * nmap <Leader>Dc :Continue <CR>

autocmd VimEnter * nmap <Leader>1 <Plug>lightline#bufferline#go(1)
autocmd VimEnter * nmap <Leader>2 <Plug>lightline#bufferline#go(2)
autocmd VimEnter * nmap <Leader>3 <Plug>lightline#bufferline#go(3)
autocmd VimEnter * nmap <Leader>4 <Plug>lightline#bufferline#go(4)
autocmd VimEnter * nmap <Leader>5 <Plug>lightline#bufferline#go(5)
autocmd VimEnter * nmap <Leader>6 <Plug>lightline#bufferline#go(6)
autocmd VimEnter * nmap <Leader>7 <Plug>lightline#bufferline#go(7)
autocmd VimEnter * nmap <Leader>8 <Plug>lightline#bufferline#go(8)
autocmd VimEnter * nmap <Leader>9 <Plug>lightline#bufferline#go(9)
autocmd VimEnter * nmap <Leader>0 <Plug>lightline#bufferline#go(10)

" Git line number annotations
highlight link GitGutterChangeLineNr DiffAdd
highlight link GitGutterAddLineNr DiffChange
highlight link GitGutterDeleteLineNr DiffDelete
highlight link GitGutterChangeDeleteLineNr DiffChange

" Search Settings
let g:agriculture#disable_smart_quoting = 1

set hidden

"
"   Key Bindings
"

let mapleader=";"

" Asynchronous Jobs
nmap <Leader>a :copen \| :AsyncRun 

" Toggle relative line number
nmap <Leader>r :set number! relativenumber! <CR>

" Quicker spelling correction
nmap <Leader>z 1z=

" Snappy vertical / horizontal splits
nmap <Leader>v :vsp <CR>
nmap <Leader>V :sp <CR>
nmap <Leader>_ <C-w>_
nmap <Leader>\| <C-w>\|

" Resize all splits to equal size
nmap <Leader>= <C-w>=

" Window navigation
autocmd VimEnter * nmap <Leader>H <C-w>H
autocmd VimEnter * nmap <Leader>J <C-w>J
autocmd VimEnter * nmap <Leader>K <C-w>K
autocmd VimEnter * nmap <Leader>L <C-w>L
autocmd VimEnter * nmap <Leader>h <C-w>h
autocmd VimEnter * nmap <Leader>j <C-w>j
autocmd VimEnter * nmap <Leader>k <C-w>k
autocmd VimEnter * nmap <Leader>l <C-w>l
if !exists('g:vscode')
  autocmd VimEnter * nmap <Leader>Q <C-w>q
else
  autocmd VimEnter * nmap <Leader>Q <Cmd> call VSCodeNotify('workbench.action.closeEditorsInGroup')<CR>
endif

" Buffer navigation
autocmd VimEnter * nmap <Leader>p :bp<CR>
autocmd VimEnter * nmap <Leader>n :bn<CR>
autocmd VimEnter * nmap <Leader>q :bp <BAR> bd # <BAR> bn <CR>
" autocmd VimEnter * nmap <Leader>l :ls<CR>

" Tag navigation
autocmd VimEnter * nmap <Leader>C :Tags<CR>
autocmd VimEnter * nmap <Leader>t <Plug>(fzf_tags)
autocmd VimEnter * nmap <Leader>P <C-t>
noreabbrev <expr> ts getcmdtype() == ":" && getcmdline() == 'ts' ? 'FZFTselect' : 'ts'

" Command panel
if !exists('g:vscode')
  autocmd VimEnter * nmap <Leader>c :Commands<CR>
else
  autocmd VimEnter * nmap <Leader>c <Cmd> call VSCodeNotify('workbench.action.showCommands')<CR>
endif

" View tags for this file
autocmd VimEnter * nmap <Leader>B :TagbarToggle<CR>

" Minimap
if !exists('g:vscode')
  autocmd VimEnter * nmap <Leader>M :MinimapToggle<CR>
else
  autocmd VimEnter * nmap <Leader>M <Cmd> call VSCodeNotify('editor.action.toggleMinimap')<CR>

endif

"
"   Making (Neo)Vim an IDE
"

" Allow me to write LaTeX + Emoji
" call LaTeXtoUnicode#Init()
let g:latex_to_unicode = 0
let g:latex_to_unicode_keymap = 1
autocmd VimEnter * nmap <Leader>u <C-x><C-o><CR>

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

" Toggle tabline
if !exists('g:vscode')
  nmap <Leader>T :execute 'set showtabline=' . (&showtabline ==# 2 ? 0 : 2)<CR>
else
  nmap <Leader>T <Cmd> call VSCodeNotify('workbench.action.toggleTabsVisibility')<CR>
endif

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

" Fugitive Configuration
set diffopt+=vertical

" Tmuxline
let g:airline#extensions#tmuxline#enabled = 0
let g:tmuxline_powerline_separators = 0

" Files fuzzy finder
if !exists('g:vscode')
  nmap <Leader>f :FZF<CR>
else
  nmap <Leader>f <Cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>
endif

" LSP fuzzy finder
nmap <Leader>F :CocFzfList<CR>
if !exists('g:vscode')
  nmap <Leader>S :CocFzfList symbols<CR>
  nmap <Leader>A :CocFzfList actions<CR>
else
  nmap <Leader>S <Cmd>call VSCodeNotify('workbench.action.showAllSymbols')<CR>
  nmap <Leader>A <Cmd>call VSCodeNotify('editor.action.quickFix')<CR>
endif

if !exists('g:vscode')
  nmap <Leader>b :Buffers<CR>
endif

" Hide Number Gutter
nmap <Leader>m :set invnumber<CR>

" Project view
if !exists('g:vscode')
  nmap <Leader>d :NvimTreeToggle<CR>
else
  nmap <Leader>d <Cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>
endif

" Global search
vmap / y/\V<C-R>=escape(@",'/\')<CR><CR>
if !exists('g:vscode')
  nmap <Leader>/ <Plug>RgRawSearch
  vmap <Leader>/ <Plug>RgRawVisualSelection
  nmap <Leader>* <Plug>RgRawWordUnderCursor
else
  nmap <Leader>/ <Cmd>call VSCodeNotify('workbench.action.findInFiles')<CR>
  vmap <Leader>/ <Cmd>call VSCodeNotifyVisual('workbench.action.findInFiles', 1)<CR>
  nmap <Leader>* <Cmd>call VSCodeNotify('workbench.action.findInFiles', { 'query': expand('<cword>') })<CR>
endif

" Julia
let g:default_julia_version = '1.5.3'

" OmniSharp C#
let g:OmniSharp_server_use_mono = 1
let g:OmniSharp_loglevel = 'debug'

" GDB script files
au BufEnter *.gdb set filetype=gdb

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
let g:mkdp_browser = "firefox"

"
"    Coc.nvim setup
"

" Semantic Highlighting
let g:coc_default_semantic_highlight_groups = 1

" GoTo code navigation.
nmap <silent> gp <C-o>
if !exists('g:vscode')
  nmap <silent> ga :CocAction<CR>
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gs :call CocActionAsync('showSignatureHelp')<CR>
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
  nnoremap <silent><nowait> gS  :<C-u>CocList -I symbols<cr>
  nnoremap <silent> K :call <SID>show_documentation()<CR>
else
  nmap <silent> ga <Cmd>call VSCodeNotify('editor.action.autoFix')<CR>
  nmap <silent> gd <Cmd> call VSCodeNotify('editor.action.revealDefinition')<CR>
  nmap <silent> gy <Cmd> call VSCodeNotify('editor.action.goToTypeDefinition')<CR>
  nmap <silent> gi <Cmd> call VSCodeNotify('editor.action.goToImplementation')<CR>
  nmap <silent> gr <Cmd> call VSCodeNotify('editor.action.goToReferences')<CR>
  nnoremap <silent><nowait> gS <Cmd> call VSCodeNotify('editor.action.showAllSymbols')<CR>
endif

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

"
"   FZF setup
"

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

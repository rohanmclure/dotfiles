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

" Allow per-project vimrc
set exrc

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

" Better dev experience
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-dotenv'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'godlygeek/tabular'
Plug 'scrooloose/nerdtree', { 'off' : 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'ludovicchabant/vim-gutentags'
Plug 'mileszs/ack.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dbeecham/ctrlp-commandpalette.vim'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'preservim/tagbar'
Plug 'sainnhe/tmuxline.vim'
Plug 'junegunn/goyo.vim'
" Plug 'vimpostor/vim-tpipeline'
Plug 'zenbro/mirror.vim'

" Language server
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'josa42/vim-lightline-coc' 
Plug 'OmniSharp/omnisharp-vim'

" Plug 'neovim/nvim-lspconfig'
" Plug 'hrsh7th/cmp-nvim-lsp'
" Plug 'hrsh7th/cmp-buffer'
" Plug 'hrsh7th/cmp-path'
" Plug 'hrsh7th/cmp-cmdline'
" Plug 'hrsh7th/nvim-cmp'
" Plug 'hrsh7th/cmp-vsnip'
" Plug 'hrsh7th/vim-vsnip'

" Multi-entry selection UI. FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Visuals
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'srcery-colors/srcery-vim'
Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons'
Plug 'wfxr/minimap.vim'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Latex
Plug 'lervag/vimtex'

" Email with Himalaya
Plug 'soywood/himalaya', {'rtp': 'vim'}

" Better concealing for Latex
Plug 'PietroPate/vim-tex-conceal'

" Markdown
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } } " Autoinstall w/o invoking nodejs

" Isabelle
Plug 'ThreeFx/isabelle.vim', {'branch': 'main'}
Plug 'ThreeFx/coc-isabelle', {'branch': 'main', 'do': 'yarn install --frozen-lockfile'}

call plug#end()

autocmd Filetype pandoc setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

" Julia
Plug 'JuliaEditorSupport/julia-vim'
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

" lua <<EOF
"   -- Setup nvim-cmp.
"   local cmp = require'cmp'

"   cmp.setup({
"     snippet = {
"       expand = function(args)
"         vim.fn["vsnip#anonymous"](args.body) -- Use `vsnip'
"       end,
"     },
"     mapping = {
"       ['<C-p>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
"       ['<C-n>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
"       ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
"       ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
"       ['<C-e>'] = cmp.mapping({
"         i = cmp.mapping.abort(),
"         c = cmp.mapping.close(),
"       }),
"       ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
"     },
"     sources = cmp.config.sources({
"       { name = 'nvim_lsp' },
"       { name = 'vsnip' }
"     }, {
"       { name = 'buffer' },
"     })
"   })

"   -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
"   cmp.setup.cmdline('/', {
"     sources = {
"       { name = 'buffer' }
"     }
"   })

"   -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
"   cmp.setup.cmdline(':', {
"     sources = cmp.config.sources({
"       { name = 'path' }
"     }, {
"       { name = 'cmdline' }
"     })
"   })

"   -- Setup lspconfig.
"   local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
"   require('lspconfig')['pyright'].setup{
"     capabilities = capabilities 
"   }
"   require('lspconfig')['rust_analyzer'].setup{
"     capabilities = capabilities 
"   }
"   require('lspconfig')['tsserver'].setup{
"     capabilities = capabilities 
"   }
"   require('lspconfig')[''].setup{
"     capabilities = capabilities 
"   }
" EOF

"
"   a e s t h e t i c s
"

" Gruvbox
let g:gruvbox_bold = 1
let g:gruvbox_italic = 1
let g:gruvbox_underline = 1
let g:gruvbox_undercurl = 1
let g:gruvbox_contrast_dark = "soft"
colorscheme gruvbox
let g:gruvbox_termcolors = 256
let g:gruvbox_number_column = 'fg'

" Zen Mode
autocmd VimEnter * nmap <leader>Z :Goyo <CR>

" Terminal Mode -> Not working yet
autocmd VimEnter * nmap <leader>E <C-\><C-n>

" Disable background
autocmd VimEnter * nmap <leader>B :hi Normal guibg=NONE ctermbg=NONE<CR>

" Mailbox picker
let g:himalaya_mailbox_picker = 'fzf'

" Minimap
let g:minimap_highlight_range = 1
let g:minimap_git_colors = 1

" Vim Debugger
autocmd VimEnter * :packadd termdebug <CR>
autocmd VimEnter * nmap <leader>D :Termdebug<Space>
autocmd VimEnter * nmap <leader>Db :Break <CR>
autocmd VimEnter * nmap <leader>Dn :Next <CR>
autocmd VimEnter * nmap <leader>Ds :Step <CR>
autocmd VimEnter * nmap <leader>Dc :Continue <CR>

"
"   Vim Lightline - or how I learned to stop worrying and love buffers
"

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
      \        'left': [ [ 'mode', 'paste'],
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

"
" tpipeline setup
"

let g:tpipeline_split = 1

" Force tabline
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

" Ctrl+P Scrolling + more results
let g:ctrlp_match_window = 'results:100'

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

" Toggle relative line number
nmap <leader>r :set number! relativenumber! <CR>

" Quicker spelling correction
nmap <leader>z 1z=

" Snappy vertical / horizontal splits
nmap <leader>v :vsp <CR>
nmap <leader>V :sp <CR>
nmap <leader>_ <C-w>_
nmap <leader>\| <C-w>\|

" Resize all splits to equal size
nmap <leader>= <C-w>=

" Window navigation
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
autocmd VimEnter * nmap <leader>q :bp <BAR> bd # <BAR> bn <CR>
" autocmd VimEnter * nmap <leader>l :ls<CR>

" Tag navigation
autocmd VimEnter * nmap <leader>t g]
autocmd VimEnter * nmap <leader>P <C-t>

" View tags for this file
autocmd VimEnter * nmap <leader>b :TagbarToggle<CR>

" Minimap
autocmd VimEnter * nmap <leader>M :MinimapToggle<CR>

"
"   Making (Neo)Vim an IDE
"

" Allow me to write LaTeX + Emoji
" call LaTeXtoUnicode#Init()
let g:latex_to_unicode = 0
let g:latex_to_unicode_keymap = 1
autocmd VimEnter * nmap <leader>u <C-x><C-o><CR>

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
nmap <Leader>T :execute 'set showtabline=' . (&showtabline ==# 2 ? 0 : 2)<CR>

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

" Tmuxline
let g:airline#extensions#tmuxline#enabled = 0
let g:tmuxline_powerline_separators = 0

" Completions
" let g:deoplete#enable_at_startup = 1
" autocmd BufEnter * call ncm2#enable_for_buffer()
" set completeopt=noinsert,menuone,noselect

" Files fuzzy finder
let g:ctrlp_show_hidden = 1
nmap <Leader>f :CtrlPMixed<CR>

" Tags fuzzy finder
nmap <Leader>F :CtrlPTag<CR>

" Hide Number Gutter
nmap <Leader>m :set invnumber<CR>

" Commands fuzzy finder
nmap <Leader>c :CtrlPCommandPalette<cr>

" Project view
nmap <Leader>d :NERDTreeToggle<CR>
" autocmd BufEnter * silent NERDTreeMirror

" Global search
" Not an actual command, just cause vim to type out the prefix
nmap <Leader>a :Ack!<Space>

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

" Command Palette
let g:commandPalette = {
\   'Coc Diagnostics': ':CocDiagnostics<CR>',
\   'Vim-Obsession record session': ':Obsess<CR>',
\   'Source environment [file]': ':Dotenv ',
\   'Make clean': ':make clean<CR>',
\   'View full path to buffer': '<C-G>',
\   'VimTeX Table of Contents': ':VimtexTocToggle<CR>'
\ }

" Coc.nvim setup

" GoTo code navigation.
nmap <silent> ga :CocAction<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gp <C-o>
nmap <silent> gs :call CocActionAsync('showSignatureHelp')<CR>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent><nowait> gS  :<C-u>CocList -I symbols<cr>

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

" Disallow unsafe vimrc commands
set secure
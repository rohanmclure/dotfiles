vim.opt.termguicolors = true

-- Gruvbox theme
vim.g.gruvbox_bold = 1
vim.g.gruvbox_italic = 1
vim.g.gruvbox_underline = 1
vim.g.gruvbox_undercurl = 1
vim.g.gruvbox_contrast_dark = "hard"
vim.g.gruvbox_contrast_light = "soft"
vim.api.nvim_command("colorscheme gruvbox")
vim.opt.background = "dark"

-- Transparent Everything
vim.cmd [[
  hi Normal guibg=NONE ctermbg=NONE
  hi VertSplit guibg=NONE ctermbg=NONE
  hi SignColumn  guibg=NONE ctermbg=NONE
  hi GitSignsAdd guifg='#b8bb26' gui=bold guibg=NONE ctermbg=NONE
  hi GitSignsChange guifg=#8ec07c gui=bold guibg=NONE ctermbg=NONE
  hi GitSignsDelete guifg='#fb4934' gui=bold guibg=NONE ctermbg=NONE
  autocmd BufEnter * set fillchars=eob:\ 
]]

-- Only colour the cursor's line number - not the line
vim.cmd [[
  hi CursorLineNr guibg=NONE ctermbg=NONE
  set cursorline
  set cursorlineopt=number
]]

vim.g.minimap_width = 10
vim.g.minimap_auto_start = 0
vim.g.minimap_auto_start_win_enter = 0

require('ui.fuzzyfinder')
require('ui.diagnostics')
require('ui.tabline')
require('ui.statusline')
require('ui.explorer')
require('ui.signs')
require('ui.zen')

require('ibl').setup () -- indent-blankline

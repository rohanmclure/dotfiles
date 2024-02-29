vim.opt.termguicolors = true

-- Gruvbox theme
require"gruvbox".setup {
  terminal_colors = true,
  undercurl = true,
  underline = true,
  bold      = true,
  italic = {
    strings = true,
    emphasis = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = false, -- invert background for search, diffs, statuslines and errors
  contrast = "hard", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = true,
}

vim.api.nvim_command("colorscheme gruvbox")
vim.opt.background = "dark"

-- Get rid of pescy EOB characters (~'s)
vim.cmd [[ autocmd BufEnter * set fillchars=eob:\  ]]

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

require"ibl".setup {} -- indent-blankline

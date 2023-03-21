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
vim.cmd("hi Normal guibg=NONE ctermbg=NONE")

require("indent_blankline").setup {
  show_current_context = false,
  show_current_context_start = false,
}

vim.g.minimap_width = 10
vim.g.minimap_auto_start = 0
vim.g.minimap_auto_start_win_enter = 0

require('ui.tabline')
require('ui.statusline')
require('ui.explorer')
require('ui.signs')
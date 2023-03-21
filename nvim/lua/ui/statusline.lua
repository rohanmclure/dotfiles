-- Patch the lualine theme to be mostly transparent
local custom_gruvbox = require('lualine.themes.gruvbox_dark')
local c_fg = custom_gruvbox.normal.c.fg
custom_gruvbox.normal.c.bg = 'NONE'
custom_gruvbox.visual.c.fg = c_fg
custom_gruvbox.visual.c.bg = 'NONE'
custom_gruvbox.insert.c.fg = c_fg
custom_gruvbox.insert.c.bg = 'NONE'
custom_gruvbox.command.c.fg = c_fg
custom_gruvbox.command.c.bg = 'NONE'

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = custom_gruvbox,
    component_separators = { left = '|', right = '|'},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

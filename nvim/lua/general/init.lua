vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true

vim.opt.number = true
vim.opt.relativenumber = false

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

require('general.parser')
require('general.git')

-- Use its default bindings as well
require('nvim_comment').setup()

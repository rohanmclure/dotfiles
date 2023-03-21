vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true

vim.opt.showmode = false
vim.opt.swapfile = false
vim.opt.cursorline = false

vim.opt.number = true
vim.opt.relativenumber = false

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

if vim.g.vscode ~= nil then
  return
end

require('general.parser')
require('general.git')

-- Use its default bindings as well
require('nvim_comment').setup()

vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true

vim.opt.showmode = false
vim.opt.swapfile = false
vim.opt.cursorline = false

vim.opt.number = true
vim.opt.relativenumber = false

if vim.g.vscode ~= nil then
  return
end

require('general.snippets')
require('general.parser')
require('general.git')
require('general.commands')

-- Use its default bindings as well
require('nvim_comment').setup()

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

require('general.folds')
require('general.snippets')
require('general.parser')
require('general.git')
require('general.commands')

-- Use its default bindings as well
require('config-local').setup {
  -- Default configuration (optional)
  config_files = { ".nvim.lua", ".nvimrc" },            -- Config file patterns to load (lua supported)
  hashfile = vim.fn.stdpath("data") .. "/config-local", -- Where the plugin keeps files data
  autocommands_create = true,                           -- Create autocommands (VimEnter, DirectoryChanged)
  commands_create = true,                               -- Create commands (ConfigSource, ConfigEdit, ConfigTrust, ConfigIgnore)
  silent = false,                                       -- Disable plugin messages (Config loaded/ignored)
  lookup_parents = false,                               -- Lookup config files in parent directories
}
require('nvim_comment').setup()

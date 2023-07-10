require('pkg')
require('general')

if vim.g.vscode == nil then
  require('ui')
  require('lsp')
  require('mappings')
  require('sessions')
else
  require('vscode')
end

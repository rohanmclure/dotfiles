require('pkg')
require('general')

if vim.g.vscode == nil then
  require('ui')
  require('lsp')
  require('mappings')
else
  require('vscode')
end

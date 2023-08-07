vim.opt.foldlevel = 99
vim.opt.foldlevelstart = -1
vim.opt.foldenable = true

-- Wire up to use ufo's definition for close/open all
vim.keymap.set('n', 'zR', require'ufo'.openAllFolds)
vim.keymap.set('n', 'zM', require'ufo'.closeAllFolds)

-- Patch all of our server's configurations to notify them of folding support
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}
local language_servers = require("lspconfig").util.available_servers()
for _, ls in ipairs(language_servers) do
    require('lspconfig')[ls].setup({
        capabilities = capabilities
    })
end

local ft_map = {
  -- c   = { 'lsp', 'indent' },
  -- cpp = { 'lsp', 'indent' }
}

require'ufo'.setup {
  provider_selector = function(bufnr, filetype, buftype)
    if ft_map[filetype] then
      return ft_map[filetype]
    else
      return { 'treesitter', 'indent' }
    end
  end,
  close_fold_kinds = { }
}


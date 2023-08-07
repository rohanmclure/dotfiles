vim.opt.foldlevel = 20
vim.opt.foldenable = true

-- Wire up to use ufo's definition for close/open all
vim.keymap.set('n', 'zR', require'ufo'.openAllFolds)
vim.keymap.set('n', 'zM', require'ufo'.closeAllFolds)

require'ufo'.setup {
  provider_selector = function(bufnr, filetype, buftype)
    return { 'lsp', 'treesitter' }
  end,
  close_fold_kinds = { }
}


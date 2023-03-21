local utils = {}

utils.get_diagnostic_count = function(bufnr, severity)
  return vim.tbl_count(vim.diagnostic.get(bufnr, {
    severity = severity,
  }))
end

return utils

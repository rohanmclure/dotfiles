vim.opt.sessionoptions = {
  "blank",
  "buffers",
  "curdir",
  "folds",
  "help",
  "tabpages",
  "winsize",
  "winpos",
  "terminal",
  "localoptions",
  "globals"
}

require('auto-session').setup {
  save_extra_cmds = {
    function()
      return [[ScopeSaveState]]
    end,
  },
  post_restore_cmds = {
    function()
      return [[ScopeLoadState]]
    end,
  },
}

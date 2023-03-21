vim.g.mapleader = ';'

require("nest").applyKeymaps {
  { "<leader>", {
    { "Q", "<cmd>call VSCodeNotify('workbench.action.closeEditorsInGroup')<CR>" },
    { "h", "<cmd>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>" },
    { "j", "<cmd>call VSCodeNotify('workbench.action.focusBelowGroup')<CR>" },
    { "k", "<cmd>call VSCodeNotify('workbench.action.focusAboveGroup')<CR>" },
    { "l", "<cmd>call VSCodeNotify('workbench.action.focusRightGroup')<CR>" },
    { "v", "<cmd>call VSCodeNotify('workbench.action.splitEditorRight')<CR>" },
    { "V", "<cmd>call VSCodeNotify('workbench.action.splitEditorDown')<CR>" },
    { "p", "<cmd>call VSCodeNotify('workbench.action.previousEditorInGroup')<CR>" },
    { "n", "<cmd>call VSCodeNotify('workbench.action.nextEditorInGroup')<CR>" },
    { "q", "<cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>" },
    { "c", "<cmd>call VSCodeNotify('workbench.action.showCommands')<CR>" },
    { "M", "<cmd>call VSCodeNotify('editor.action.toggleMinimap')<CR>" },
    { "T", "<cmd>call VSCodeNotify('workbench.action.toggleTabsVisibility')<CR>" },
    { "f", "<cmd>call VSCodeNotify('workbench.action.quickOpen')<CR>" },
    { "S", "<cmd>call VSCodeNotify('workbench.action.showAllSymbols')<CR>" },
    { "A", "<cmd>call VSCodeNotify('editor.action.quickFix')<CR>" },
    { "d", "<cmd>call VSCodeNotify('workbench.action.toggleSidebarVisibility')<CR>" },
    { "/", "<cmd>call VSCodeNotify('workbench.action.findInFiles')<CR>" },
    { "/", "<cmd>call VSCodeNotifyVisual('workbench.action.findInFiles', 1)<CR>", mode="v" },
  }},
  { "g", {
    { "a", "<cmd>call VSCodeNotify('editor.action.autoFix')<CR>" },
    { "d", "<cmd>call VSCodeNotify('editor.action.revealDefinition')<CR>" },
    { "y", "<cmd>call VSCodeNotify('editor.action.goToTypeDefinition')<CR>" },
    { "i", "<cmd>call VSCodeNotify('editor.action.goToImplementation')<CR>" },
    { "r", "<cmd>call VSCodeNotify('editor.action.goToReferences')<CR>" },
    { "S", "<cmd>call VSCodeNotify('editor.action.showAllSymbols')<CR>" },
  }}
}

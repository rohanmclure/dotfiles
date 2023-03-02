doom.core.treesitter.settings.show_compiler_warning_message = false

doom.leader_key = ";"

-- doom_config - Doom Nvim user configurations file
--
-- This file contains the user-defined configurations for Doom nvim.
-- Just override stuff in the `doom` global table (it's injected into scope
-- automatically).

-- ADDING A PACKAGE
--
-- doom.use_package("EdenEast/nightfox.nvim", "sainnhe/sonokai")
-- doom.use_package({
--   "ur4ltz/surround.nvim",
--   config = function()
--     require("surround").setup({mappings_style = "sandwich"})
--   end
-- })

-- ADDING A KEYBIND

doom.use_keybind({
  -- The `name` field will add the keybind to whichkey
  {"<leader>", name='+most cmds', {
    {
      { "f", '<cmd>Telescope find_files<CR>', name = '+files' },
      { "b", '<cmd>Telescope buffers<CR>', name = '+buffers' },
      { "d", '<cmd>NvimTreeToggle<CR>', name = '+directory' },
      { "c", '<cmd>Telescope commands<CR>', name = '+commands' },
      { "n", '<cmd>BufferLineCycleNext<CR>', name = '+bn' },
      { "p", '<cmd>BufferLineCyclePrev<CR>', name = '+bp' },
      { "q", function() vim.cmd(":bd") end, name = '+bd' },
      { "Q", function() vim.cmd("<C-w>q") end, name = '+split-quit' },
      { "h", function() vim.cmd("<C-w>h") end, name = '+split-left' },
      { "j", function() vim.cmd("<C-w>j") end, name = '+split-down' },
      { "k", function() vim.cmd("<C-w>k") end, name = '+split-up' },
      { "l", function() vim.cmd("<C-w>l") end, name = '+split-right' },
      { "v", function() vim.cmd(":vsp") end, name = '+vsplit' },
      { "V", function() vim.cmd(":split") end, name = '+hsplit' },
    }
  }}
})

-- ADDING A COMMAND

doom.use_cmd({
  {"CustomCommand2", function() print("Trigger my custom command 2") end}
})

-- ADDING AN AUTOCOMMAND
--
-- doom.use_autocmd({
--   { "FileType", "javascript", function() print('This is a javascript file') end }
-- })

-- vim: sw=2 sts=2 ts=2 expandtab

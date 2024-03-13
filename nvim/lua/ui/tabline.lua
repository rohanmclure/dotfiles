local utils = require("utils")


require('bufferline').setup {
  highlights = {
    indicator_selected = {
      sp = "red",
      underline = true
    }
  },
  options = {
    mode = "buffers",
    themable = true,
    numbers = "none",
    buffer_close_icon = "",
    modified_icon = "●",
    close_icon = "",
    left_trunc_marker = "",
    right_trunc_marker = "",
    indicator = {
        style = 'underline'
    },
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    truncate_names = true,
    tab_size = 18,
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(_, _, diagnostics_dict, _)
      local s = " "
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and "  " or (e == "warning" and "  " or " 󰌶 ")
        s = s .. n .. sym
      end
      return s
    end,
    -- NOTE: this will be called a lot so don't do any heavy processing here
    custom_filter = function(buf_number)
      if vim.bo[buf_number].filetype ~= "dashboard" then
        return true
      end
    end,
    groups = {
      options = {
        toggle_hidden_on_enter = true, -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
      },
      items = {
        require('bufferline.groups').builtin.pinned:with({ icon = "" })
        -- {
        --   name = "Tests",
        --   auto_close = true,
        --   matcher = function(buf)
        --     return buf.filename:match("%_test") or buf.filename:match("%_spec")
        --   end,
        -- },
        -- {
        --   name = "Docs",
        --   auto_close = true,
        --   matcher = function(buf)
        --     return buf.filename:match("%.md") or buf.filename:match("%.txt")
        --   end,
        -- },
      },
    },
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "center",
      },
      {
        filetype = "netrw",
        text = "File Explorer",
        text_align = "center",
      },
      {
        filetype = "minimap",
        text = "Minimap",
        text_align = "center",
      },
      {
        filetype = "Outline",
        text = "Symbols",
        text_align = "center",
      },
      {
        filetype = "packer",
        text = "Plugins manager",
        text_align = "center",
      },
    },
    show_buffer_icons = true,
    show_buffer_close_icons = false,
    show_close_icon = false,
    show_tab_indicators = true,
    persist_buffer_sort = true,
    separator_style = { " ", " " },
    enforce_regular_tabs = false,
    always_show_bufferline = true,
    -- sort_by = "directory",
    custom_areas = {
      right = function()
        local result = {}
        local error = utils.get_diagnostic_count(0, [[Error]])
        local warning = utils.get_diagnostic_count(0, [[Warning]])
        local info = utils.get_diagnostic_count(0, [[Information]])
        local hint = utils.get_diagnostic_count(0, [[Hint]])

        if error ~= 0 then
          result[1] = {
            text = "  " .. error,
            guifg = "#ff6c6b",
          }
        end

        if warning ~= 0 then
          result[2] = {
            text = "  " .. warning,
            guifg = "#ECBE7B",
          }
        end

        if hint ~= 0 then
          result[3] = {
            text = "  " .. hint,
            guifg = "#98be65",
          }
        end

        if info ~= 0 then
          result[4] = {
            text = " 󰌶 " .. info,
            guifg = "#51afef",
          }
        end
        return result
      end,
    },
  },
}

vim.cmd([[
augroup qf
  autocmd!
  autocmd FileType qf set nobuflisted
augroup END
]])

-- Scope buffers by the tab they belong to
require"scope".setup {}
require"telescope".load_extension('scope')

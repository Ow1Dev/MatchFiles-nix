local icons = require "user.icons"
local diff = {
  "diff",
  colored = false,
  symbols = { added = icons.git.LineAdded, modified = icons.git.LineModified, removed = icons.git.LineRemoved }, -- Changes the symbols used by the diff.
}

local diagnostics = {
  "diagnostics",
  sections = { "error", "warn" },
  colored = false, -- Displays diagnostics status in color if set to true.
  always_visible = true, -- Show diagnostics even if there are none.
}

local filetype = {
  function()
    local filetype = vim.bo.filetype
    local upper_case_filetypes = {
      "json",
      "jsonc",
      "yaml",
      "toml",
      "css",
      "scss",
      "html",
      "xml",
    }

    if vim.tbl_contains(upper_case_filetypes, filetype) then
      return filetype:upper()
    end

    return filetype
  end,
}

require("lualine").setup {
  options = {
    -- component_separators = { left = "", right = "" },
    -- section_separators = { left = "", right = "" },
    -- component_separators = { left = "", right = "" },
    -- section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },

    ignore_focus = { "NvimTree" },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = { diagnostics },
    lualine_y = { "progress" },
    lualine_z = {},
  },
  -- extensions = { "quickfix", "man", "fugitive", "oil" },
  extensions = { "quickfix", "man", "fugitive" },
}

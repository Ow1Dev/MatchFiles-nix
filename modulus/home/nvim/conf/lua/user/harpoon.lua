local M = {}

function M.mark_file()
  require("harpoon.mark").add_file()
  vim.notify "󱡅  marked file"
end

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "<s-m>", "<cmd>lua require('user.harpoon').mark_file()<cr>", opts)
keymap("n", "<TAB>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", opts)

return M 

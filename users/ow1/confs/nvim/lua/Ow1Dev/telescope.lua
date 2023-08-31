local telescope = require 'telescope'
local builtin = require('telescope.builtin')

local function init()
    telescope.setup {
        defaults = {
            file_ignore_patterns = {
                "node_modules/.*",
                "secret.d/.*",
                "%.pem"
            }
        }
    }

    local options = { noremap = true }

    -- Builtin
    vim.keymap.set('n', '<C-p>', builtin.git_files, options)
    vim.keymap.set('n', '<leader>ff', builtin.find_files, options)
    vim.keymap.set('n', '<leader>fl', builtin.live_grep, options)
    vim.keymap.set('n', '<leader>fb', builtin.buffers, options)
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, options)
    vim.keymap.set('n', '<leader>fd', builtin.diagnostics, options)
    vim.keymap.set('n', '<leader>fr', builtin.registers, options)

    -- Language Servers
    vim.keymap.set('n', '<leader>lsd', builtin.lsp_definitions, options)
    vim.keymap.set('n', '<leader>lsi', builtin.lsp_implementations, options)
    vim.keymap.set('n', '<leader>lsl', vim.lsp.buf.code_action, options)

end

return {
    init = init,
}

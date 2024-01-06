local null_ls = require "null-ls"

local formatting = null_ls.builtins.formatting

null_ls.setup {
  debug = true,
  sources = {
    formatting.stylua,
    formatting.nixpkgs_fmt,
    null_ls.builtins.completion.spell,
  },
}

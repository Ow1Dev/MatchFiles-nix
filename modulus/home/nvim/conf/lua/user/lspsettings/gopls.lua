return {
  filetypes = { "go", "gomod", "gowork", "gotmpl", "gohtmltmpl", "gotexttmpl" },
  settings = {
    gopls = {
      experimentalPostfixCompletions = true,
      analyses = {
        unusedparams = true,
        shadow = true,
        fieldalignment = true,
      },
      staticcheck = true,
      ["build.templateExtensions"] = { "gohtml", "html", "gotmpl", "tmpl" },
    },
  },
}

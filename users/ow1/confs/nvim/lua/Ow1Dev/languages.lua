local lspconfig = require 'lspconfig'
local rust_tools = require 'rust-tools'
local treesitter = require 'nvim-treesitter.configs'
local treesitter_context = require 'treesitter-context'
local cmp = require('cmp')

local cmp_select_opts = { behavior = cmp.SelectBehavior.Select }

local function autocmd(args)
    local event = args[1]
    local group = args[2]
    local callback = args[3]

    vim.api.nvim_create_autocmd(event, {
        group = group,
        buffer = args[4],
        callback = function()
            callback()
        end,
        once = args.once,
    })
end

local function on_attach(client, buffer)
    local augroup_highlight = vim.api.nvim_create_augroup("custom-lsp-references", { clear = true })
    local autocmd_clear = vim.api.nvim_clear_autocmds

    local opts = { buffer = buffer, remap = false }

    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, opts)

    if client.server_capabilities.documentHighlightProvider then
        autocmd_clear { group = augroup_highlight, buffer = buffer }
        autocmd { "CursorHold", augroup_highlight, vim.lsp.buf.document_highlight, buffer }
        autocmd { "CursorMoved", augroup_highlight, vim.lsp.buf.clear_references, buffer }
    end
end

local function init()
    -- Rust specific setup
    rust_tools.setup {
        server = {
            settings = {
                ['rust-analyzer'] = {
                    diagnostics = {
                        enable = false,
                    },
                    files = {
                        excludeDirs = { ".direnv", ".git" },
                        watcherExclude = { ".direnv", ".git" },
                    },
                },
            },
            on_attach = on_attach,
        },
    }

    local language_servers = {
        html = {},
        lua_ls = {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { 'vim' }
                    },
                    runtime = {
                        version = 'LuaJIT',
                    },
                    telemetry = {
                        enable = false,
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                },
            }
        },
        nil_ls = {
            settings = {
                ['nil'] = {
                    formatting = { command = { "nixpkgs-fmt" } },
                },
            }
        },
        tsserver = {},
        yamlls = {
            settings = {
                yaml = {
                    keyOrdering = false,
                },
            },
        },
    }

    -- Initialize servers
    for server, server_config in pairs(language_servers) do
        local config = { on_attach = on_attach }

        if server_config then
            for k, v in pairs(server_config) do
                config[k] = v
            end
        end

        lspconfig[server].setup(config)
    end

    -- Global mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

    treesitter.setup {
        highlight = { enable = true },
        indent = { enable = true },
        rainbow = { enable = true },
    }

    treesitter_context.setup()


    cmp.setup({
        sources = {
            { name = 'nvim_lsp' },
        },
        mapping = {
            ['<C-y>'] = cmp.mapping.confirm({ select = true }),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<C-u>'] = cmp.mapping.scroll_docs(-4),
            ['<C-d>'] = cmp.mapping.scroll_docs(4),
            ['<C-p>'] = cmp.mapping(function()
                if cmp.visible() then
                    cmp.select_prev_item(cmp_select_opts)
                else
                    cmp.complete()
                end
            end),
            ['<C-n>'] = cmp.mapping(function()
                if cmp.visible() then
                    cmp.select_next_item(cmp_select_opts)
                else
                    cmp.complete()
                end
            end),
        },
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end,
        },
        window = {
            documentation = {
                max_height = 15,
                max_width = 60,
            }
        },
        formatting = {
            fields = { 'abbr', 'menu', 'kind' },
            format = function(entry, item)
                local short_name = {
                    nvim_lsp = 'LSP',
                    nvim_lua = 'nvim'
                }

                local menu_name = short_name[entry.source.name] or entry.source.name

                item.menu = string.format('[%s]', menu_name)
                return item
            end,
        },
    })
end

return {
    init = init,
}

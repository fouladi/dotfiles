return {
    {
        lazy = false,
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        opts = {
            auto_install = true,
        },
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")

            -- Neovim v0.7.2 or lower you'll need to create a function
            -- and add it to the on_attach option of each language server
            -- NOTE: install each of following tools on your machine and
            -- Install through Mason
            -- For Python we use: 'ruff-lsp.lua'
            lspconfig.lua_ls.setup({
                settings = {
                    Lua = {
                        hint = {
                            enable = true,
                        },
                    },
                },
                capabilities = capabilities,
            })

            lspconfig.gopls.setup({
                capabilities = capabilities,
                filetypes = { "go", "gomod", "gowork", "gotmpl" },
                settings = {
                    gopls = {
                        completeUnimported = true,
                        usePlaceholders = true,
                        analyses = {
                            unusedparams = true,
                        },
                    },
                },
            })

            -- Adding 'pyenv virtualenv' for Pyright
            vim.env.PYENV_VERSION = vim.fn.system('pyenv version'):match('(%S+)%s+%(.-%)')
            -- Keymaps for doc, definition, reference and code-action
            vim.keymap.set("n", "<leader>doc", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "<leader>def", vim.lsp.buf.definition, {})
            vim.keymap.set("n", "<leader>ref", vim.lsp.buf.references, {})
            vim.keymap.set("n", "<leader>act", vim.lsp.buf.code_action, {})
        end,
    },
}

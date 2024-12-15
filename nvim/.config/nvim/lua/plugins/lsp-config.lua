return {
    {
        lazy = false,
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
        },
        config = function()
            require("mason").setup()
            -- import mason
            local mason = require("mason")
            -- import mason-lspconfig
            local mason_lspconfig = require("mason-lspconfig")
            local mason_tool_installer = require("mason-tool-installer")
            -- enable mason and configure icons
            mason.setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })

            mason_lspconfig.setup({
                -- list of servers for mason to install
                ensure_installed = {
                    "lua_ls",
                    "ruff",
                    "pyright",
                },
            })

            mason_tool_installer.setup({
                ensure_installed = {
                    "prettier", -- prettier (JavaScript,html,css ) formatter
                    "stylua", -- lua formatter
                    "ruff", -- python formatter
                    "shfmt", -- bash/zsh formatter
                    "shellcheck", -- bash/zsh formatter
                    "google-java-format", -- Java formatter
                },
            })
        end,
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
            vim.env.PYENV_VERSION = vim.fn.system("pyenv version"):match("(%S+)%s+%(.-%)")
            -- Keymaps for doc, definition, reference and code-action
            vim.keymap.set("n", "<leader>cl", "<cmd>LspInfo<cr>", { desc = "Lsp Info" })
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
            vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })
            vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Goto Definition" })
            vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "References" })
            vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { desc = "Goto Implementation" })
        end,
    },
}

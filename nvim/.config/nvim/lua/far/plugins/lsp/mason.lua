return {
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            -- list of servers for mason to install
            ensure_installed = {
                "ts_ls",
                "html",
                "lua_ls",
                "ruff",
                "ty",
            },
        },
        dependencies = {
            {
                "williamboman/mason.nvim",
                opts = {
                    ui = {
                        icons = {
                            package_installed = "✓",
                            package_pending = "➜",
                            package_uninstalled = "✗",
                        },
                    },
                },
            },
            "neovim/nvim-lspconfig",
        },
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = {
            ensure_installed = {
                "prettier", -- prettier (JavaScript,html,css ) formatter
                "stylua", -- lua formatter
                "ruff", -- python formatter
                "shfmt", -- bash/zsh formatter
                "shellcheck", -- bash/zsh formatter
                "google-java-format", -- Java formatter
            },
        },
        dependencies = {
            "williamboman/mason.nvim",
        },
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            -- Adding 'pyenv virtualenv' for fixing "import pytest" - import could not be resolved!
            vim.env.PYENV_VERSION = vim.fn.system("pyenv version"):match("(%S+)%s+%(.-%)")
        end,
    },
}

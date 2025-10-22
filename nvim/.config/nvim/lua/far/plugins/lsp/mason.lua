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
}

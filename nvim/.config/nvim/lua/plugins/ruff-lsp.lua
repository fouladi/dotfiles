return {
    "neovim/nvim-lspconfig",
    vim.lsp.config("ruff", {
        init_options = {
            settings = {
                -- Any extra CLI arguments for `ruff` go here.
                args = {},
                logLevel = "info",
            },
        },
    }),
    -- To use Ruff exclusively for linting, code-formatting, and organizing
    -- imports (code-transforming), you can disable those capabilities for Pyright:
    vim.lsp.config("pyright", {
        settings = {
            pyright = {
                -- Using Ruff's import organizer
                disableOrganizeImports = true,
            },
            python = {
                analysis = {
                    -- Ignore all files for analysis to exclusively use Ruff for linting
                    ignore = { "*" },
                },
            },
        },
    }),
    vim.lsp.enable("ruff"),
}

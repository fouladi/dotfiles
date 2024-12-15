return {
    "stevearc/conform.nvim",
    -- This is so that we lazy load conform.nvim when we open a buffer
    -- either for an 'already existing' file or for a 'new file' as we only
    -- need formatting when working in a buffer.
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")
        -- get list of all Formatters from:
        --          https://github.com/stevearc/conform.nvim/tree/master/lua/conform/formatters
        -- Ensure they are also installed, see: lsp-config.lua
        conform.setup({
            formatters_by_ft = {
                lua = { "stylua" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                svelte = { "prettier" },
                css = { "prettier" },
                html = { "prettier" },
                json = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
                graphql = { "prettier" },
                liquid = { "prettier" },
                xml = { "xmllint" },
                java = { "google-java-format" },
                sh = { "shfmt", "shellcheck" },
                -- Conform will run multiple formatters sequentially
                python = {
                    -- To fix auto-fixable lint errors.
                    "ruff_fix",
                    -- To run the Ruff formatter.
                    "ruff_format",
                    -- To organize the imports.
                    "ruff_organize_imports",
                },
            },
            -- Add a format_on_save field to apply formatting when saving a file.
            format_on_save = {
                lsp_fallback = true, -- use the lsp if no formatter is available.
                async = false, -- not do asynchronous formatting
                timeout_ms = 1000, -- timeout after 1sec=1000ms if formatting isn't finished
            },
        })
        -- In normal mode it will apply to the whole file, in visual
        -- mode it will apply to the current selection.
        vim.keymap.set({ "n", "v" }, "<leader>ft", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            })
        end, { desc = "Format file or range (in visual mode)" })
    end,
}

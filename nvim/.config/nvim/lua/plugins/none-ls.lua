return {
    "nvimtools/none-ls.nvim",
    dependencies = {
        "gbprod/none-ls-shellcheck.nvim", -- shellcheck
    },
    config = function()
        local null_ls = require("null-ls")

        null_ls.setup({
            sources = { -- formatting install each of them on your machine
                -- Lua
                null_ls.builtins.formatting.stylua,
                -- Go
                null_ls.builtins.formatting.gofmt,
                null_ls.builtins.formatting.goimports,
                null_ls.builtins.formatting.golines,
                -- Java # sudo apt install checkstyle
                --      # install google-java-format_linux-x86-64 in bin/
                null_ls.builtins.formatting.google_java_format,
                -- Bash # sudo apt install shellcheck
                null_ls.builtins.formatting.shfmt,
                require("none-ls-shellcheck.diagnostics"),
                require("none-ls-shellcheck.code_actions"),
                -- XML # sudo apt install tidy
                null_ls.builtins.formatting.tidy.with({
                    filetypes = { "xml" },
                }),
                null_ls.builtins.diagnostics.tidy.with({
                    filetypes = { "xml" },
                }),
            },
        })

        vim.keymap.set("n", "<leader>ft", vim.lsp.buf.format, {})
    end,
}

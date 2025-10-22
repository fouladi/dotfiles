return {
    "mfussenegger/nvim-lint",
    -- 'Linting' is the automated checking of your source code for
    -- programmatic and stylistic errors.
    --
    -- This is so that we load nvim-lint.nvim when we open a buffer
    -- either for an 'already existing' file or for a 'new file' as we only
    -- need formatting when working in a buffer.
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lint = require("lint")
        -- get list of all Linters from:
        --          https://github.com/mfussenegger/nvim-lint/tree/master/lua/lint/linters
        lint.linters_by_ft = {
            python = { "ruff" },
            bash = { "shellcheck" },
        }
        -- Now add a Neovim autocommand group and autocommand to execute
        -- linting on a set of Neovim events.
        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
        -- Only some linters support linting from stdin and don't require you
        -- to save to the file.
        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = lint_augroup,
            callback = function()
                lint.try_lint()
            end,
        })

        vim.keymap.set("n", "<leader>lt", function()
            lint.try_lint()
        end, { desc = "Trigger linting for current file" })
    end,
}

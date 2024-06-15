return {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    config = function()
        require("ibl").setup({
            enabled = false, -- disables indent-blankline at file opening
            scope = {
                show_start = false,
                show_end = false,
            },
            exclude = {
                filetypes = {
                    "help",
                    "git",
                    "markdown",
                    "snippets",
                    "text",
                    "gitconfig",
                    "alpha",
                    "dashboard",
                    "", -- for all buffers without a file type
                },
                buftypes = { "terminal" },
            },
            indent = {
                tab_char = "▎",
                -- char = "┊", -- One char for all
                char = { "|", "¦", "┆", "┊" },
                smart_indent_cap = true,
            },
            whitespace = {
                remove_blankline_trail = true,
            },
        })
        vim.api.nvim_set_keymap("n", "<leader>it", ":IBLToggle<CR>", { silent = true })
    end,
}

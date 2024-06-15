return {
    {
        "tpope/vim-fugitive",
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({ signcolumn = false })
            -- toggle Gitsigns (version control)
            vim.api.nvim_set_keymap("n", "<leader>gg", ":Gitsigns toggle_signs<CR>", { silent = true })
            vim.api.nvim_set_keymap("n", "<leader>gb", ":Gitsigns toggle_current_line_blame<CR>", { silent = true })
            vim.api.nvim_set_keymap("n", "<leader>gd", ":Gitsigns preview_hunk<CR>", { silent = true })
        end,
    },
}

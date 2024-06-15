return {
    "tpope/vim-fugitive", -- A Git wrapper
    config = function()
        vim.api.nvim_set_keymap("n", "<leader>gv", ":Gdiff<CR>", { silent = true })
        vim.api.nvim_set_keymap("n", "<leader>gm", ":Gvdiffsplit!<CR>", { silent = true })
    end,
}

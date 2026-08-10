return {
    "tpope/vim-fugitive", -- A Git wrapper
    cmd = { "Git", "Gdiff", "Gvdiffsplit" },
    keys = {
        { "<leader>gd", "<cmd>Gdiff<CR>", desc = "Git diff" },
        { "<leader>gm", "<cmd>Gvdiffsplit!<CR>", desc = "Git merge diff (3-way)" },
    },
}

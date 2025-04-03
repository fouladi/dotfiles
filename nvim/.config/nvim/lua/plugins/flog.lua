return {
    "rbong/vim-flog",
    lazy = true,
    cmd = { "Flog", "Flogsplit", "Floggit" },
    dependencies = {
        "tpope/vim-fugitive",
    },
    vim.api.nvim_set_keymap("n", "<leader>gl", ":Flog<CR>", { silent = true }),
}

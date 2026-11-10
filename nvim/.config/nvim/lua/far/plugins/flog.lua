return {
    -- Git branch viewer
    "rbong/vim-flog",
    lazy = true,
    cmd = { "Flog", "Flogsplit", "Floggit" },
    dependencies = {
        "tpope/vim-fugitive",
    },
    keys = {
        { "<leader>gl", "<cmd>Flog<CR>", desc = "Git log graph (Flog)" },
    },
}

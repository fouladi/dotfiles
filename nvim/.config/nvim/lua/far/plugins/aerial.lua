return {
    -- A code outline window for skimming and quick navigation
    "stevearc/aerial.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    opts = {},
    cmd = { "AerialToggle", "AerialOpen", "AerialNext", "AerialPrev" },
    keys = {
        { "<leader>a", "<cmd>AerialToggle!<CR>", desc = "[A]erial toggle", mode = "n" },
        { "<F8>", "<cmd>AerialToggle!<CR>", desc = "[A]erial toggle", mode = "n" },
        { "<leader>A", "<cmd>AerialNavToggle<CR>", desc = "[A]erial nav toggle", mode = "n" },
    },
}

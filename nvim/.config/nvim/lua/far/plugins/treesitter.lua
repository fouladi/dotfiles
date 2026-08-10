return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        main = "nvim-treesitter",
        opts = {
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },
        },
    },
}

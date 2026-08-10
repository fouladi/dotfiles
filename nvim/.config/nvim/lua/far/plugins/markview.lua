return {
    "OXY2DEV/markview.nvim",
    ft = "markdown",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        preview = {
            enable = false,
        },
        experimental = { check_rtp_message = false },
    },
    keys = {
        { "<leader>md", "<cmd>Markview toggle<CR>", desc = "Toggle Markview" },
    },
}

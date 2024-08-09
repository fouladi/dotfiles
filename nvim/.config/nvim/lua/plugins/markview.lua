return {
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("markview").setup({})
        vim.api.nvim_set_keymap("n", "<leader>md", ":Markview<CR>", { silent = true })
    end,
}

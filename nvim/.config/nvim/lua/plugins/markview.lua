return {
    "OXY2DEV/markview.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("markview").setup({})
        vim.api.nvim_set_keymap("n", "<leader>v", ":Markview<CR>", { silent = true })
    end,
}

return {
    "OXY2DEV/markview.nvim",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("markview").setup({
            preview = {
                enable = false, -- don't show preview
            },
        })
        vim.api.nvim_set_keymap("n", "<leader>md", ":Markview toggle<CR>", { silent = true })
    end,
}

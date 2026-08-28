return {
    "fouladi/toggle-overlength.nvim",
    config = function()
        require("toggle-overlength").setup({
            keymap = "<leader>th",
        })
    end,
}

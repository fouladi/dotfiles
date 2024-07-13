return {
    "smjonas/inc-rename.nvim",
    config = function()
        require("inc_rename").setup({})
        vim.api.nvim_set_keymap("n", "<leader>rn", ":IncRename ", { silent = true })
    end,
}

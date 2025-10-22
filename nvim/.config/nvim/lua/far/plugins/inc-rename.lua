return {
    "smjonas/inc-rename.nvim",
    config = function()
        require("inc_rename").setup({
            presets = { inc_rename = true },
        })
        vim.api.nvim_set_keymap("n", "<leader>rn", ":IncRename ", { silent = true })
    end,
}

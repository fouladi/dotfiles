return {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    keys = {
        { "<leader>rn", ":IncRename ", desc = "Incremental rename" },
    },
    opts = {
        presets = { inc_rename = true },
    },
}

return {
    -- Integration for Git
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = { signcolumn = false },
    keys = {
        { "<leader>gg", "<cmd>Gitsigns toggle_signs<CR>", desc = "Toggle git signs" },
        { "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<CR>", desc = "Toggle git line blame" },
        { "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", desc = "Preview git hunk" },
    },
}

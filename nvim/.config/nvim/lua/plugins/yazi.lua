return {
    {
        "mikavilpas/yazi.nvim",
        event = "VeryLazy",
        keys = {
            { "<leader>y", "<cmd>Yazi<cr>", desc = "Yazi - current dir" },
            { "<leader>Y", "<cmd>Yazi cwd<cr>", desc = "Yazi - root dir" },
            { "<c-y>", "<cmd>Yazi toggle<cr>", desc = "Yazi - resume last session" },
        },
        opts = {
            -- if you want to open yazi instead of netrw:
            open_for_directories = true,
            floating_window_scaling_factor = 0.8,
            yazi_floating_window_border = "none",
            keymaps = { show_help = "<f1>" },
        },
    },
}

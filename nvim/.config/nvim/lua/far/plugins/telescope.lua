return {
    {
        "nvim-telescope/telescope-ui-select.nvim",
    },
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
            { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Find buffers" },
            { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
            { "<leader><leader>", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },
        },
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })
            require("telescope").load_extension("ui-select")
            require("telescope").load_extension("fzf")
        end,
    },
}

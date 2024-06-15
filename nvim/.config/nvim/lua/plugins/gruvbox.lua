return {
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        name = "gruvbox",
        priority = 1000,
        palette_overrides = { bright_green = "#b8bb26" },
        config = function()
            vim.cmd.colorscheme("gruvbox") -- Comment in order to deactivate "gruvbox"!
        end,
    },
}

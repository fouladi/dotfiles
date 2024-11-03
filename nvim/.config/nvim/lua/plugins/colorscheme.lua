return {
    {
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        name = "gruvbox",
        priority = 1000,
        config = function()
            require("gruvbox").setup({
                contrast = "dark",
                palette_overrides = { bright_green = "#b8bb26" },
                overrides = {
                    Comment = { fg = "#81878f", italic = true, bold = false },
                    -- fold
                    Folded = { fg = "#fe8019", bg = "#0E1018", italic = true },
                    -- new git colors
                    DiffAdd = {
                        bold = true,
                        reverse = false,
                        fg = "",
                        bg = "#2a4333",
                    },
                    DiffChange = {
                        bold = true,
                        reverse = false,
                        fg = "",
                        bg = "#333841",
                    },
                    DiffDelete = {
                        bold = true,
                        reverse = false,
                        fg = "#442d30",
                        bg = "#442d30",
                    },
                    DiffText = {
                        bold = true,
                        reverse = true,
                        fg = "",
                        bg = "#213352",
                    },
                },
            })
            vim.cmd.colorscheme("gruvbox") -- Comment in order to deactivate "gruvbox"!
        end,
    },
}

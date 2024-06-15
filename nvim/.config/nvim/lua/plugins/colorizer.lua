local M = { -- color highlighter #Gold #00FF11 #234 Red
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPost", "BufNewFile" },
}

function M.config()
    require("colorizer").setup({
        filetypes = {
            "typescript",
            "typescriptreact",
            "javascript",
            "javascriptreact",
            "css",
            "html",
            "astro",
            "lua",
            "python",
            "markdown",
        },
        user_default_options = {
            names = true,  -- Green
            rgb_fn = true, -- CSS rgb() and rgba() functions
            hsl_fn = true, -- CSS hsl() and hsla() functions
            tailwind = "both",
        },
        buftypes = {},
    })
end

return M

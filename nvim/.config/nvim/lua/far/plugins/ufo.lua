return {
    -- Ultra Fold for nvim
    "kevinhwang91/nvim-ufo",
    event = "BufReadPost",
    dependencies = {
        "kevinhwang91/promise-async",
        "nvim-treesitter/nvim-treesitter",
    },
    init = function()
        vim.o.foldcolumn = "0"
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true
    end,
    opts = {
        provider_selector = function(bufnr, filetype, buftype)
            return { "treesitter", "indent" }
        end,
    },
}

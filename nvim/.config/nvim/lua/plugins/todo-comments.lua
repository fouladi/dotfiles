return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim", lazy = true },
    opts = {
        -- TODO: do something
        -- FIX: this should be fixed
        -- HACK: weird code warning
        -- NOTE: A note
        -- WARNING: Achtung
        -- PERF: fully optimised
        -- DONE: erldeigt
        keywords = {
            DONE = { icon = "✓", color = "hint", alt = { "FIXED" } },
        },
        highlight = { comments_only = false },
    },
}

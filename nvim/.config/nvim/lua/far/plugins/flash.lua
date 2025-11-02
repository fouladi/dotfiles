return {
    -- It lets you navigate your code with search labels, enhanced character motions, and Treesitter integration.
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@diagnostic disable-next-line: undefined-doc-name
    ---@type Flash.Config
    --- Make flash enabled in regular search.
    opts = {
        modes = {
            search = { enabled = true },
        },
    },
    -- stylua: ignore
    -- n: Normal mode.
    -- x: Visual mode.
    -- o: Operator-pending.
    -- c: Command-Line mode
    keys = {
        { "m",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
        { "M",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
        { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
        { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
}

return {
    {
        "sainnhe/gruvbox-material",
        lazy = false, -- make sure we load this during startup if it is the main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        opacity = 0.92,
        init = function(spec)
            vim.g.gruvbox_material_background = "medium" -- soft|medium|hard
            vim.g.gruvbox_material_foreground = "original" -- material|mix|original
            vim.g.gruvbox_material_ui_contrast = "low" -- low|high
            vim.g.gruvbox_material_better_performance = 1
            vim.g.gruvbox_material_enable_italic = 1
            vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
            vim.g.gruvbox_material_inlay_hints_background = "dimmed"

            local name = vim.fs.basename(spec[1])
            vim.api.nvim_create_autocmd("ColorScheme", {
                desc = "User: Highlights for " .. name,
                pattern = name,
                callback = function()
                    local setHl = function(...)
                        vim.api.nvim_set_hl(0, ...)
                    end
                    local hlCmd = vim.cmd.highlight

                    -- NOTE: MISSING HIGHLIGHTS
                    -- stop globals like `vim` in lua or `Objc` in JXA from being overwritten
                    setHl("@lsp.type.variable", {})
                    -- placeholders like the `%s` in `string.format("foo %s bar")`
                    setHl("@character.printf", { link = "Purple" })

                    -- NOTE: selection hardly visible in DressingInput
                    -- (keep it for the scrollbar though)
                    setHl("Visual", { bg = "#385055" })
                    setHl("SatelliteBar", { bg = "#45403d" })

                    -- General
                    setHl("TSParameter", { fg = "#679bbf" })
                    setHl("TSConstant", { fg = "#948ecb" })
                    setHl("@string.documentation.python", { link = "Comment" })
                    setHl("@keyword.return", { bold = true, fg = "#f6843a" })
                    setHl("TSPunctBracket", { fg = "#af7e5d" })
                    vim.defer_fn(function()
                        setHl("@constructor.lua", { fg = "#9b97a8" })
                    end, 1)

                    -- md `inline` code in comments
                    setHl("@markup.raw", { fg = "#a9b665", bg = "#3c3836" })

                    -- cursorword
                    setHl("LspReferenceWrite", { underdashed = true })
                    setHl("LspReferenceRead", { underdotted = true })
                    setHl("LspReferenceText", {})

                    -- no undercurls
                    hlCmd("DiagnosticUnderlineError gui=underline")
                    hlCmd("DiagnosticUnderlineWarn gui=underline")
                    hlCmd("DiagnosticUnderlineInfo gui=underline")
                    hlCmd("DiagnosticUnderlineHint gui=underline")
                    hlCmd("SpellBad gui=underdotted")
                    hlCmd("SpellError gui=underdotted")
                    hlCmd("SpellCap gui=underdotted")
                    hlCmd("SpellLocal gui=underdotted")

                    -- no overly excessive underlines/bold
                    hlCmd("ErrorMsg gui=none")
                    hlCmd("WarningMsg gui=none")

                    -- FIX missing snacks.nvim highlights for trace
                    setHl("SnacksNotifierTitleTrace", { link = "NotifyTraceTitle" })
                    setHl("SnacksNotifierTitleIcon", { link = "NotifyTraceIcon" })
                    setHl("SnacksNotifierTitleBorder", { link = "NotifyTraceBorder" })
                    setHl("SnacksNotifierTitleFooter", { link = "NotifyTraceBorder" })

                    -- NOTE: lazy.nvim,
                    setHl("Bold", { bold = true })
                    setHl("LazyReasonRequire", { link = "@variable.parameter" })
                end,
            })
            vim.cmd.colorscheme("gruvbox-material") -- Comment in order to deactivate "gruvbox-material"!
        end,
    },
}

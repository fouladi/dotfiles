-- replaces the UI for messages, cmdline and the popupmenu
return {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            messages = { enabled = false },
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
                    ["vim.lsp.util.stylize_markdown"] = false,
                    ["cmp.entry.get_documentation"] = true,
                },
                progress = {
                    enabled = false,
                },
                hover = {
                    enabled = false,
                },
            },
            -- you can enable a preset for easier configuration
            presets = {
                bottom_search = false,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = false,
                lsp_doc_border = false,
            },
        },
    },
}

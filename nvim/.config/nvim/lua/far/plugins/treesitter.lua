-- nvim-treesitter `main` branch: it only installs parsers/queries. Highlighting
-- and indentation are NOT enabled via setup() options anymore; they have to be
-- started per buffer (see the FileType autocmd below).
local parsers = {
    "bash",
    "css",
    "html",
    "java",
    "javascript",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
    "python",
    "query",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "xml",
    "yaml",
}

return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false, -- the main branch does not support lazy-loading
        build = ":TSUpdate",
        config = function()
            local ts = require("nvim-treesitter")
            ts.install(parsers) -- async, no-op for parsers already installed

            -- Start highlighting (and experimental indentation) for a buffer.
            local function attach(buf, lang)
                if not pcall(vim.treesitter.start, buf, lang) then
                    return false
                end
                if vim.treesitter.query.get(lang, "indents") then
                    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end
                return true
            end

            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true }),
                callback = function(args)
                    local lang = vim.treesitter.language.get_lang(args.match)
                    if not lang or attach(args.buf, lang) then
                        return
                    end
                    -- Replacement for the old `auto_install = true`.
                    if vim.tbl_contains(ts.get_available(), lang) then
                        ts.install(lang):await(function()
                            vim.schedule(function()
                                if vim.api.nvim_buf_is_valid(args.buf) then
                                    attach(args.buf, lang)
                                end
                            end)
                        end)
                    end
                end,
            })
        end,
    },
}

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup("UserAutocmds", { clear = true })

--
-- Code formatters for languages NOT covered by conform.nvim
--
autocmd("FileType", {
    group = augroup,
    pattern = { "text" },
    callback = function()
        vim.keymap.set("n", "<leader>p", ":%!fmt -75 -s -<CR>", { buffer = true, silent = true, desc = "Format text" })
    end,
})
autocmd("FileType", {
    group = augroup,
    pattern = { "proto" },
    callback = function()
        vim.keymap.set("n", "<leader>p", ":%!prototool format %<CR>", { buffer = true, silent = true, desc = "Format proto" })
    end,
})
autocmd("FileType", {
    group = augroup,
    pattern = { "toml" },
    callback = function()
        vim.keymap.set("n", "<leader>p", ":%!toml-fmt %<CR>", { buffer = true, silent = true, desc = "Format toml" })
    end,
})

-- spellcheck in md
autocmd("FileType", {
    group = augroup,
    pattern = "markdown",
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.wrap = true
    end,
})

-- disable automatic comment on newline
autocmd("FileType", {
    group = augroup,
    pattern = "*",
    callback = function()
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
})

-- highlight text on yank
autocmd("TextYankPost", {
    group = augroup,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ timeout = 300 })
    end,
})

-- restore cursor pos on file open
autocmd("BufReadPost", {
    group = augroup,
    pattern = "*",
    callback = function()
        local line = vim.fn.line("'\"")
        if line > 1 and line <= vim.fn.line("$") then
            vim.cmd("normal! g'\"")
        end
    end,
})

-- Copy/Paste --
-- Remove the paste function of 'OSC 52' and rely on wezterm/gohstty's
-- paste from clipboard instead.
vim.o.clipboard = "unnamedplus"

local function paste()
    return {
        vim.fn.split(vim.fn.getreg(""), "\n"),
        vim.fn.getregtype(""),
    }
end

vim.g.clipboard = {
    name = "OSC 52",
    copy = {
        ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
        ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
        ["+"] = paste,
        ["*"] = paste,
    },
}

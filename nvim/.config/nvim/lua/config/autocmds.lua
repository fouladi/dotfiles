local autocmd = vim.api.nvim_create_autocmd
--
-- code prettifier for some programming languages (xml, python, sql, rust, ...)
--
autocmd("FileType", { pattern = { "xml", "xslt" }, command = ":nnoremap <buffer> <leader>p :%!xmllint --format -<CR>" })
autocmd("FileType", { pattern = { "python" }, command = ":nnoremap <buffer> <leader>p :%!ruff format -<CR>" })
autocmd("FileType", {
    pattern = { "sql" },
    command = ":nnoremap <buffer> <leader>p :%!pg_format --spaces 2 --function-case 2<CR>",
})
autocmd("FileType", { pattern = { "rust" }, command = ":nnoremap <buffer> <leader>p :%!rustfmt<CR>" })
autocmd("FileType", { pattern = { "text" }, command = ":nnoremap <buffer> <leader>p :%!fmt -75 -s -<CR>" })
autocmd("FileType", { pattern = { "go" }, command = ":nnoremap <buffer> <leader>p :%!gofmt<CR>" })
autocmd("FileType", { pattern = { "json" }, command = ":nnoremap <buffer>  <leader>p :%!python -m json.tool<CR>" })
autocmd("FileType", { pattern = { "proto" }, command = ":nnoremap <buffer>  <leader>p :%!prototool format %<CR>" })
autocmd("FileType", { pattern = { "toml" }, command = ":nnoremap <buffer>  <leader>p :%!toml-fmt %<CR>" })
autocmd("FileType", { pattern = { "xslt" }, command = "" })
-- shfmt: https://github.com/mvdan/sh
autocmd("FileType", { pattern = { "sh" }, command = ":nnoremap <buffer> <leader>p :%!shfmt -i 4 -ln bash -ci<CR>" })
-- LaTeX
autocmd("FileType", {
    pattern = "tex",
    callback = function(args)
        vim.treesitter.start(args.buf, "latex")
        vim.bo[args.buf].syntax = "on" -- only if additional legacy syntax is needed
    end,
})

-- spellcheck in md
autocmd("FileType", {
    pattern = "markdown",
    command = "setlocal spell wrap",
})

-- disable automatic comment on newline
autocmd("FileType", {
    pattern = "*",
    callback = function()
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
})

-- highlight text on yank
autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ timeout = 300 })
    end,
})

-- restore cursor pos on file open
autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        local line = vim.fn.line("'\"")
        if line > 1 and line <= vim.fn.line("$") then
            vim.cmd("normal! g'\"")
        end
    end,
})

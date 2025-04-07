local opt = vim.opt
local keymap = vim.keymap
local cmd = vim.cmd
local autocmd = vim.api.nvim_create_autocmd

vim.g.mapleader = "," -- NOTE: Set leader to comma -  reverse char search
keymap.set("n", "\\", ",", { noremap = true })

opt.shortmess = "aTIF" -- No welcome-message, silent
opt.smartindent = true -- smart autoindenting when starting a new line
opt.wrap = false -- turn-off wrapping - for XML necessary
opt.undofile = true -- saves undo history to an undo file
opt.spelllang = "en,de" -- spelling English and German
opt.spellsuggest = "5" -- maximum number of suggestions
opt.tabstop = 4 -- indentation levels every four columns
opt.expandtab = true -- convert all tabs typed to spaces
opt.shiftwidth = 4 -- indent/outdent by four columns
opt.shiftround = true -- indent/outdent to nearest tabstop
opt.ignorecase = true -- if search term has at least one capital letter
opt.smartcase = true --          then case-insensitiv else case-sensitive
opt.number = false -- shows absolute line number on cursor line

-- n: Normal mode.
-- i: Insert mode.
-- x: Visual mode.
-- s: Selection mode.
-- v: Visual + Selection.
-- t: Terminal mode.
-- o: Operator-pending.
-- c: Command-Line mode
-- ca: command mode abbreviation
-- '': Yes, an empty string. Is the equivalent of n + v + o.
--
-- Keyboard mistyping
keymap.set("ca", "W!", "w!")
keymap.set("ca", "Q!", "q!")
keymap.set("ca", "Wq", "wq")
keymap.set("ca", "Wa", "wa")
keymap.set("ca", "wQ", "wq")
keymap.set("ca", "WQ", "wq")
keymap.set("ca", "W", "w")
keymap.set("ca", "Q", "q")
keymap.set("n", "<leader>hn", ":nohlsearch<CR>")
-- toggle line numbers
keymap.set("n", "<leader>nn", ":set number! number?<CR>")
keymap.set("n", "<leader>nr", ":set relativenumber! relativenumber?<CR>")
-- Text formatting
keymap.set("n", "<leader>tt", "!Gperl -MText::Autoformat -e'autoformat'<CR>", { silent = true })
keymap.set("n", "<leader>T", "!}fmt -75 -s <CR>", { silent = true })
keymap.set("x", "<leader>T", "!fmt -75 -s <CR>", { silent = true })
keymap.set("n", "<leader>tp", "{!}par T4 B=. 75qr<CR>", { silent = true })
-- rapidly flicking through opening files
keymap.set("n", "<C-right>", ":bn<CR>")
keymap.set("n", "<C-left>", ":bp<CR>")
-- Use ALT and arrow keys for switching between split buffers
keymap.set("n", "<A-Left>", "<C-w>h")
keymap.set("n", "<A-Down>", "<C-w>j")
keymap.set("n", "<A-Up>", "<C-w>k")
keymap.set("n", "<A-Right>", "<C-w>l")
-- Highlight Yank
cmd([[au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}]])
-- ,S - remove all trailing spaces
keymap.set("n", "<leader>S", ":%s/\\s\\+$//e <CR>")
-- ,M - remove those bloody ^M's at the end of lines
keymap.set("n", "<leader>M", ":%s/\\r//g <CR>")
-- Toggle spell checking
keymap.set("n", "<leader>ss", ":setlocal spell!<CR>")
keymap.set("n", "<leader>sd", ":setlocal spelllang=de<CR>")
keymap.set("n", "<leader>se", ":setlocal spelllang=en_us<CR>")
-- Toggle Inlay Hints - it must be enables for specific language
keymap.set("n", "<leader>ht", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end)
-- TagbarToggle
keymap.set("n", "<F4>", ":TagbarToggle<CR>", { silent = true })
--
-- Bubble Lines -----------------------------
keymap.set("n", "<C-Down>", ":m .+1<CR>==", { silent = true })
keymap.set("n", "<C-Up>", ":m .-2<CR>==", { silent = true })
-- Bubble multiple lines
keymap.set("v", "<C-Down>", ":m '>+1<CR>gv=gv", { silent = true })
keymap.set("v", "<C-Up>", ":m '<-2<CR>gv=gv", { silent = true })
-- Navigate to source tree of file whose buffer I was just editing
keymap.set("n", "<leader>.", ":tabedit %:p:h<CR>", { silent = true })
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
autocmd("FileType", { pattern = { "json" }, command = " :nnoremap <buffer>  <leader>p :%!python -m json.tool<CR>" })
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
-- Used with nvim >= 0.11
vim.diagnostic.config({
    virtual_lines = {
        -- Only show virtual line diagnostics for the current cursor line
        current_line = true,
    },
})

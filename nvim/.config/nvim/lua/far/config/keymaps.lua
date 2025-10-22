local keymap = vim.keymap
keymap.set("n", "\\", ",", { noremap = true })

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
keymap.set("", "<leader>bl", function()
    vim.diagnostic.config({
        virtual_lines = not vim.diagnostic.config().virtual_lines,
        virtual_text = not vim.diagnostic.config().virtual_text,
    })
end, { desc = "Toggle diagnostic [l]ines" })

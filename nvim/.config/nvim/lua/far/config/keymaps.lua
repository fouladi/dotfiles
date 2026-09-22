local keymap = vim.keymap

-- Target line width used by the text-formatting mappings below
local TEXTWIDTH = 100

keymap.set("n", "\\", ",", { noremap = true, desc = "Reverse char search (since leader is comma)" })

-- Keyboard mistyping
keymap.set("ca", "W!", "w!")
keymap.set("ca", "Q!", "q!")
keymap.set("ca", "Wq", "wq")
keymap.set("ca", "Wa", "wa")
keymap.set("ca", "wQ", "wq")
keymap.set("ca", "WQ", "wq")
keymap.set("ca", "W", "w")
keymap.set("ca", "Q", "q")

keymap.set("n", "<leader>hn", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
-- toggle line numbers
keymap.set("n", "<leader>nn", "<cmd>set number! number?<CR>", { desc = "Toggle line numbers" })
keymap.set("n", "<leader>nr", "<cmd>set relativenumber! relativenumber?<CR>", { desc = "Toggle relative numbers" })
-- Text formatting
--
-- Dot-repeat (`.`) support without any plugin dependency, using Neovim's
-- built-in `operatorfunc` + `g@` mechanism:
--   * The <leader> mapping is an <expr> map that sets `operatorfunc` to the
--     formatter's callback and returns "g@l" (operate on a single cell,
--     keeping the cursor in place).
--   * `g@l` invokes the callback, which filters the inner paragraph.
--   * Pressing `.` re-runs `g@l`, re-calling the same callback directly.
--
-- Callbacks are exposed on a global table so they are reachable via v:lua.
_G.FarFormat = _G.FarFormat or {}

local function filter_paragraph(cmd)
    -- Filter the whole inner paragraph through the external command.
    -- Select the inner paragraph and pipe it through the filter in a single
    -- normal-mode sequence, so the visual range is live when `!` runs.
    vim.cmd(("noautocmd keepjumps normal! vip:!%s\r"):format(cmd))
end

local formatters = {
    {
        name = "autofmt",
        lhs = "<leader>tt",
        cmd = ("perl -MText::Autoformat -e'autoformat({right=>%d})'"):format(TEXTWIDTH),
        desc = "Autoformat text (perl)",
    },
    { name = "fmt", lhs = "<leader>T", cmd = ("fmt -w %d"):format(TEXTWIDTH), desc = "Format paragraph (fmt)" },
    { name = "par", lhs = "<leader>tp", cmd = ("par T4 B=. %dqr"):format(TEXTWIDTH), desc = "Format paragraph (par)" },
}

for _, f in ipairs(formatters) do
    -- The callback that does the actual work (also what `.` re-invokes).
    _G.FarFormat[f.name] = function()
        filter_paragraph(f.cmd)
    end

    keymap.set("n", f.lhs, function()
        vim.go.operatorfunc = ("v:lua.FarFormat.%s"):format(f.name)
        return "g@l"
    end, { expr = true, silent = true, desc = f.desc })
end

-- Visual-mode fmt keeps filtering the active selection directly.
keymap.set("x", "<leader>T", ("!fmt -w %d<CR>"):format(TEXTWIDTH), { silent = true, desc = "Format selection (fmt)" })
-- rapidly flicking through opening files
keymap.set("n", "<C-right>", "<cmd>bn<CR>", { desc = "Next buffer" })
keymap.set("n", "<C-left>", "<cmd>bp<CR>", { desc = "Previous buffer" })
-- Use ALT and arrow keys for switching between split buffers
keymap.set("n", "<A-Left>", "<C-w>h", { desc = "Move to left split" })
keymap.set("n", "<A-Down>", "<C-w>j", { desc = "Move to below split" })
keymap.set("n", "<A-Up>", "<C-w>k", { desc = "Move to above split" })
keymap.set("n", "<A-Right>", "<C-w>l", { desc = "Move to right split" })
-- ,S - remove all trailing spaces
keymap.set("n", "<leader>S", ":%s/\\s\\+$//e<CR>", { desc = "Remove trailing whitespace" })
-- ,M - remove those bloody ^M's at the end of lines
keymap.set("n", "<leader>M", ":%s/\\r//g<CR>", { desc = "Remove ^M line endings" })
-- Toggle spell checking
keymap.set("n", "<leader>ss", "<cmd>setlocal spell!<CR>", { desc = "Toggle spell checking" })
keymap.set("n", "<leader>sd", "<cmd>setlocal spelllang=de<CR>", { desc = "Set spell language to German" })
keymap.set("n", "<leader>se", "<cmd>setlocal spelllang=en_us<CR>", { desc = "Set spell language to English" })
-- Toggle Inlay Hints
keymap.set("n", "<leader>ht", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle inlay hints" })
-- TagbarToggle
keymap.set("n", "<F4>", "<cmd>TagbarToggle<CR>", { silent = true, desc = "Toggle Tagbar" })
--
-- Bubble Lines
keymap.set("n", "<C-Down>", "<cmd>m .+1<CR>==", { silent = true, desc = "Move line down" })
keymap.set("n", "<C-Up>", "<cmd>m .-2<CR>==", { silent = true, desc = "Move line up" })
-- Bubble multiple lines
keymap.set("v", "<C-Down>", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selection down" })
keymap.set("v", "<C-Up>", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move selection up" })
-- Navigate to source tree of file whose buffer I was just editing
keymap.set("n", "<leader>.", "<cmd>tabedit %:p:h<CR>", { silent = true, desc = "Open file directory in tab" })
keymap.set("", "<leader>bl", function()
    vim.diagnostic.config({
        virtual_lines = not vim.diagnostic.config().virtual_lines,
        virtual_text = not vim.diagnostic.config().virtual_text,
    })
end, { desc = "Toggle diagnostic lines" })

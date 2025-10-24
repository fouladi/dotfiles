local opt = vim.opt

vim.g.mapleader = "," -- NOTE: Set leader to comma -  reverse char search

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

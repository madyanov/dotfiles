local keymap = vim.keymap
local all_modes = { "n", "v", "i", "c" }

vim.g.mapleader = " "

-- disable arrow keys
keymap.set(all_modes, "<Left>", "<NOP>")
keymap.set(all_modes, "<Right>", "<NOP>")
keymap.set(all_modes, "<Up>", "<NOP>")
keymap.set(all_modes, "<Down>", "<NOP>")

-- disable space
keymap.set({ "n", "v" }, "<Space>", "<NOP>")

-- easier escape
keymap.set("i", "jj", "<Esc>")

-- don't save deleted characters into register
keymap.set("n", "x", '"_x')

-- toggle search highlighting
keymap.set("n", "<C-H>", "<Cmd>set hlsearch!<CR>")

-- replace in selection
keymap.set("x", "<Leader>sv", ":s/\\%V/")

-- replace word under cursor
keymap.set("n", "<Leader>s*", ":%s/<C-R><C-W>/")

-- replace word under cursor inline with repeating
keymap.set("n", "c*", "*``cgn")
keymap.set("n", "c#", "#``cgN")

-- don't jump on search
keymap.set("n", "*", "*N")
keymap.set("n", "#", "#N")

-- cd to current directory
keymap.set("n", "cd", "<Cmd>d %:p:h<CR>")

-- dealing with word wrap
keymap.set("n", "k", 'v:count == 0 ? "gk" : "k"', { expr = true, silent = true })
keymap.set("n", "j", 'v:count == 0 ? "gj" : "j"', { expr = true, silent = true })

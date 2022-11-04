local keymap = vim.keymap
local all_modes = { "n", "x", "o", "i", "c" }

vim.g.mapleader = " "

-- disable arrow keys
keymap.set(all_modes, "<Left>", "<NOP>")
keymap.set(all_modes, "<Right>", "<NOP>")
keymap.set(all_modes, "<Up>", "<NOP>")
keymap.set(all_modes, "<Down>", "<NOP>")

-- disable space
keymap.set({ "n", "x", "o" }, "<Space>", "<NOP>")

-- easier save
keymap.set("n", "<Space>w", "<Cmd>update<CR>")

-- don't save deleted characters into register
keymap.set("n", "x", '"_x')

-- don't jump on search
keymap.set("n", "*", "*N")
keymap.set("n", "#", "#N")

-- easier escape
keymap.set("i", "jj", "<Esc>")

-- toggle search highlighting
keymap.set("n", "<C-H>", "<Cmd>set hlsearch!<CR>")

-- dealing with word wrap
keymap.set("n", "k", 'v:count == 0 ? "gk" : "k"', { expr = true, silent = true })
keymap.set("n", "j", 'v:count == 0 ? "gj" : "j"', { expr = true, silent = true })

-- replace word under cursor inline with repeating
keymap.set("n", "c*", "*``cgn")
keymap.set("n", "c#", "#``cgN")

-- replace in selection
keymap.set("x", "<Leader>sv", ":s/\\%V/")

-- replace word under cursor
keymap.set("n", "<Leader>s*", ":%s/<C-R><C-W>/")

-- cd to current directory
keymap.set("n", "<Leader>cd", "<Cmd>d %:p:h<CR>")

-- svart
keymap.set({ "n", "x", "o" }, "s", "<Cmd>Svart<CR>")
keymap.set({ "n", "x", "o" }, "S", "<Cmd>SvartRepeat<CR>")

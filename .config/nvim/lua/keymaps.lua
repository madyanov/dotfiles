local keymap = vim.keymap

vim.g.mapleader = " "

keymap.set({ "n", "v" }, "<Space>", "<Nop>")

keymap.set("i", "jk", "<Esc>")

-- don't save deleted characters into register
keymap.set("n", "x", '"_x')

-- replace in selection
keymap.set("x", "<Leader>sv", ":s/\\%V//g<Left><Left><Left>")

-- replace word under cursor
keymap.set("n", "<Leader>s*", ":%s/<C-R><C-W>//<Left>")

-- replace word under cursor inline with repeating
keymap.set("n", "c*", "*``cgn")
keymap.set("n", "c#", "#``cgN")

-- clear highlighting after search
keymap.set("n", "<C-L>", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>")

-- don't jump on search
keymap.set("n", "*", "*N")
keymap.set("n", "#", "#N")

-- cd to current directory
keymap.set("n", "cd", ":cd %:p:h<CR>")

-- Telescope

keymap.set("n", "<Leader>ff", "<Cmd>Telescope find_files<CR>")
keymap.set("n", "<Leader>fg", "<Cmd>Telescope live_grep<CR>")
keymap.set("n", "<Leader>fb", "<Cmd>Telescope buffers<CR>")
keymap.set("n", "<Leader>fh", "<Cmd>Telescope help_tags<CR>")

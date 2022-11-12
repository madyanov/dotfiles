local keymap = vim.keymap

vim.g.mapleader = " "

-- disable arrow keys
-- todo: remove
do
    local modes = { "n", "x", "o", "i", "c" }
    keymap.set(modes, "<Left>", "<NOP>")
    keymap.set(modes, "<Right>", "<NOP>")
    keymap.set(modes, "<Up>", "<NOP>")
    keymap.set(modes, "<Down>", "<NOP>")
end

-- disable space
-- todo: remove
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

-- inline replace word under cursor with repeating
keymap.set("n", "c*", "*``cgn")
keymap.set("n", "c#", "#``cgN")

-- replace in selection
keymap.set("x", "<Leader>sv", ":s/\\%V")

-- replace word under cursor
keymap.set("n", "<Leader>s*", ":%s/<C-R><C-W>/")

-- cd to current directory
keymap.set("n", "<Leader>cd", "<Cmd>cd %:p:h<CR>")

-- quickfix navigation
keymap.set("n", "]q", "<Cmd>cnext<CR>")
keymap.set("n", "[q", "<Cmd>cprevious<CR>")
keymap.set("n", "]Q", "<Cmd>clast<CR>")
keymap.set("n", "[Q", "<Cmd>cfirst<CR>")
keymap.set("n", "]<C-Q>", "<Cmd>cnfile<CR>")
keymap.set("n", "[<C-Q>", "<Cmd>cpfile<CR>")

-- toggle spellcheck
keymap.set("n", "<Leader>sp", "<Cmd>setlocal spell! spelllang=en_us,ru_ru<CR>")

-- svart
keymap.set({ "n", "x", "o" }, "s", "<Cmd>Svart<CR>")        -- begin exact search
keymap.set({ "n", "x", "o" }, "S", "<Cmd>SvartRegex<CR>")   -- begin regex search
keymap.set({ "n", "x", "o" }, "gs", "<Cmd>SvartRepeat<CR>") -- repeat with last searched query

-- fzf
keymap.set("n", "<Leader>ff", "<Cmd>Files<CR>")
keymap.set("n", "<Leader>fg", "<Cmd>Rg<CR>")

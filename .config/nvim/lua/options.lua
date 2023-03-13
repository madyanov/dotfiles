local set = vim.opt
local g = vim.g

-- Line numbers
set.number = true
set.relativenumber = true
set.signcolumn = "yes:1"

-- Search
set.ignorecase = true
set.smartcase = true
set.hlsearch = false -- Neovim default = true
set.incsearch = true -- Neovim default

-- Indentation
set.expandtab = true
set.tabstop = 4
set.shiftwidth = 4
set.shiftround = true
set.cindent = true
set.breakindent = true
set.list = true
set.listchars:append({ lead = "·" })
set.autoindent = true -- Neovim default
set.smarttab = true -- Neovim default

-- Completion
set.path = "**"
set.completeopt = { "menuone", "preview", "noselect", "noinsert" }
set.wildignore = { "**/*.git/**", "**/build/**", "**/.cache/**", "**/.clangd/**" }
set.wildmenu = true -- Neovim default

-- Buffers
set.hidden = true -- Neovim default
set.autoread = true -- Neovim default
set.switchbuf = "uselast" -- Neovim default

-- Status line
set.laststatus = 2
set.showcmd = true -- Neovim default
set.ruler = true -- Neovim default

-- Splits
set.splitbelow = true
set.splitright = true

-- Match
set.showmatch = true -- may be useful with low matchtime
set.matchtime = 1

-- Mouse
set.mouse = "" -- Neovim default = "nvi"
set.mousemodel = "extend"

-- Scroll
set.scrolloff = 5
set.sidescrolloff = 10

-- Folding
set.foldmethod = "indent"
set.foldlevel = 0 -- Default
set.foldnestmax = 1
set.foldopen = "hor,mark,percent,quickfix,search,tag,undo"
set.foldcolumn = "auto"

-- Netrw
g.netrw_keepdir = false
g.netrw_banner = false

-- Misc
set.iskeyword:remove("_")
set.isfname:remove("=")
set.undofile = true
set.updatetime = 500
set.timeoutlen = 1000 -- Vim default
set.ttimeoutlen = 50 -- Neovim default
set.backspace = { "indent", "eol", "start" } -- Neovim default

-- Appearance
set.cursorline = true
set.termguicolors = true

vim.cmd([[ colorscheme gruber ]])

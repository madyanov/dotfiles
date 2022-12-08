local keymap = vim.keymap

local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[ packadd packer.nvim ]])
        return true
    end

    return false
end

vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]])

local packer_bootstrap = ensure_packer()
local packer = require("packer")

packer.startup(function(use)
    use("wbthomason/packer.nvim")
    use("nvim-lua/plenary.nvim")

    use({
        "lewis6991/gitsigns.nvim",
        config = function() require("gitsigns").setup() end,
    })

    use("junegunn/fzf")
    use("junegunn/fzf.vim")

    use({
        "nvim-treesitter/nvim-treesitter",
        run = function()
            require("nvim-treesitter.install").update({ with_sync = true })
        end,
    })

    use("nvim-treesitter/playground")

    use("neovim/nvim-lspconfig")

    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-path")

    use("saadparwaiz1/cmp_luasnip")
    use("L3MON4D3/LuaSnip")

    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")

    use({
        "numToStr/Comment.nvim",
        config = function() require("Comment").setup() end,
    })

    use("rafamadriz/friendly-snippets")

    use("~/Development/gruber.vim")
    use("~/Development/svart.nvim")

    if packer_bootstrap then
        packer.sync()
    end
end)

-- treesitter
local treesitter = require("nvim-treesitter.configs")

treesitter.setup({
    auto_install = true,
    highlight = {
        enable = true,
        disable = {
            "markdown",
            "help",
            "diff",
            "make",
        },
        additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
    playground = { enable = true },
})

-- svart
keymap.set({ "n", "x", "o" }, "s", "<Cmd>Svart<CR>")
keymap.set({ "n", "x", "o" }, "S", "<Cmd>SvartRegex<CR>")
keymap.set({ "n", "x", "o" }, "gs", "<Cmd>SvartRepeat<CR>")

-- fzf
keymap.set("n", "<Leader>ff", "<Cmd>Files<CR>")
keymap.set("n", "<Leader>fg", "<Cmd>Rg<CR>")

-- cmp
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
    completion = {
        keyword_length = 2,
    },
    sources = {
        { name = "path" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-o>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm(),
    },
})

-- mason
local mason = require("mason")
local mason_lsp = require("mason-lspconfig")

mason.setup()
mason_lsp.setup({ automatic_installation = true })

-- lsp
local lsp = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local opts = { noremap = true, silent = true }
keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

local on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
    keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
    keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
    keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
    keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
    keymap.set("n", "<space>f", function() vim.lsp.buf.format { async = true } end, bufopts)
    keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
    keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
    keymap.set("n", "<space>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
end

lsp.sumneko_lua.setup({
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            telemetry = { enable = false },
        },
    },
})

local servers = { "clangd", "gopls" }
for _, server in ipairs(servers) do
    lsp[server].setup({
        on_attach = on_attach,
        capabilities = capabilities
    })
end

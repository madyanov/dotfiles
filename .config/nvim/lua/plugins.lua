local keymap = vim.keymap

-- packer
do
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
]]   )

    local packer_bootstrap = ensure_packer()
    local packer = require("packer")

    packer.startup(function(use)
        use("wbthomason/packer.nvim")
        use("nvim-lua/plenary.nvim")

        use({
            "lewis6991/gitsigns.nvim",
            config = function() require("gitsigns").setup() end,
        })

        use({
            "nvim-treesitter/nvim-treesitter",
            run = function()
                require("nvim-treesitter.install").update({ with_sync = true })
            end,
        })

        use("neovim/nvim-lspconfig")

        use("hrsh7th/nvim-cmp")
        use("hrsh7th/cmp-nvim-lsp")
        use("hrsh7th/cmp-path")
        use("hrsh7th/cmp-buffer")

        use("saadparwaiz1/cmp_luasnip")
        use("L3MON4D3/LuaSnip")

        use({
            "williamboman/mason.nvim",
            config = function() require("mason").setup() end,
        })

        use({
            "williamboman/mason-lspconfig.nvim",
            config = function() require("mason-lspconfig").setup({ automatic_installation = true }) end,
        })

        use({
            "numToStr/Comment.nvim",
            config = function() require("Comment").setup() end,
        })

        use("~/Development/gruber.vim")
        use("~/Development/svart.nvim")

        if packer_bootstrap then
            packer.sync()
        end
    end)
end

-- treesitter
do
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
    })
end


-- cmp
do
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    cmp.setup({
        completion = {
            keyword_length = 1,
        },
        sources = {
            { name = "nvim_lsp" },
            { name = "path" },
            { name = "buffer" },
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
            ["<CR>"] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = false,
            }),
        },
    })
end

-- lsp
do
    local lsp = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    local on_attach = function(_, bufnr)
        vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
        keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
        keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
        keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
        keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
        keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
        keymap.set("n", "<Leader>D", vim.lsp.buf.type_definition, bufopts)
        keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, bufopts)
        keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, bufopts)
        keymap.set("n", "<Leader>ft", function() vim.lsp.buf.format { async = true } end, bufopts)
        keymap.set("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
        keymap.set("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
        keymap.set("n", "<Leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
    end

    local servers = { "clangd" }
    for _, server in ipairs(servers) do
        lsp[server].setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end
end

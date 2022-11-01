local ensure_packer = function ()
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

packer.startup(function (use)
    use("wbthomason/packer.nvim")
    use("nvim-lua/plenary.nvim")

    use("lewis6991/gitsigns.nvim")

    use({
        "nvim-treesitter/nvim-treesitter",
        run = function ()
            require("nvim-treesitter.install").update({ with_sync = true })
        end
    })

    use("nvim-treesitter/playground")

    use("~/Development/gruber.vim")
    use("~/Development/svart.nvim")

    if packer_bootstrap then
        packer.sync()
    end
end)

-- gitsigns
local gitsigns = require("gitsigns")
gitsigns.setup()

-- treesitter
local treesitter = require("nvim-treesitter.configs")

treesitter.setup({
    ensure_installed = "all",
    auto_install = true,
    highlight = {
        enable = true,
        disable = { "markdown", "help" },
        additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
    playground = { enable = true },
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    -- NOTE: 依赖性插件
    { "folke/lazy.nvim" },
    { "nvim-lua/popup.nvim" },
    { "nvim-lua/plenary.nvim" },
    { "kyazdani42/nvim-web-devicons" },
    { "onsails/lspkind.nvim" },
    { "MunifTanjim/nui.nvim" },

    -- NOTE: core plugins
    { -- which key
        "folke/which-key.nvim",
        config = function()
            require("user.core.whichkey")
        end,
    },
    { -- syntax parser
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "HiPhish/nvim-ts-rainbow2",
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
        build = ":TSUpdate",
        config = function()
            require("user.core.treesitter")
        end,
    },
    { -- auto complete
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "rcarriga/cmp-dap",
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
            "honza/vim-snippets",
        },
        event = { "InsertEnter" },
        config = function()
            require("user.core.cmp")
        end,
    },
    { --fuzzy search
        "Yggdroot/LeaderF",
        build = ":LeaderfInstallCExtension",
        config = function()
            require("user.core.leaderf")
        end,
    },
    { --fuzzy search
        "nvim-telescope/telescope.nvim",
        dependencies = {
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            "nvim-telescope/telescope-project.nvim",
        },
        config = function()
            require("user.core.telescope")
        end,
    },
    { -- file manager
        "kyazdani42/nvim-tree.lua",
        config = function()
            require("user.core.nvim-tree")
        end,
    },
    { -- build and run
        "skywind3000/asynctasks.vim",
        dependencies = { "skywind3000/asyncrun.vim" },
        config = function()
            require("user.core.asynctasks")
        end,
    },
    { -- unit test
        "nvim-neotest/neotest",
        dependencies = {
            "antoinemadec/FixCursorHold.nvim",
            "nvim-neotest/neotest-python",
        },
        cmd = { "NeotestNearest", "NeotestCurrentFile" },
        config = function()
            require("user.core.neotest")
        end,
    },

    -- NOTE: lsp
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "tamago324/nlsp-settings.nvim",

            -- other lsp plugins
            "glepnir/lspsaga.nvim",
            "folke/trouble.nvim",
            "ray-x/lsp_signature.nvim",

            "jose-elias-alvarez/null-ls.nvim",
            "jay-babu/mason-null-ls.nvim",
        },
        event = { "BufEnter" },
        config = function()
            require("user.lsp")
        end,
    },

    -- NOTE: dap
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "williamboman/mason.nvim",
            "jayp0521/mason-nvim-dap.nvim",

            "theHamsta/nvim-dap-virtual-text",
            "rcarriga/nvim-dap-ui",
            "Weissle/persistent-breakpoints.nvim",
        },
        ft = { "python", "c", "cpp" },
        config = function()
            require("user.dap")
            require("user.dap.keymap").setup({ "*.py", "*.c", "*.cpp" })
        end,
    },

    -- the rest plugin configuratoins are placed in lua/user/conf/
    -- UI
    "rcarriga/nvim-notify",
    "stevearc/dressing.nvim",
    "goolord/alpha-nvim",
    "lukas-reineke/indent-blankline.nvim",
    { "akinsho/bufferline.nvim", version = "v3.*" },
    "nvim-lualine/lualine.nvim",
    "stevearc/aerial.nvim",
    -- color schemes
    "EdenEast/nightfox.nvim",

    -- NOTE: edit enhanced
    "echasnovski/mini.nvim",
    "numToStr/Comment.nvim",
    "windwp/nvim-autopairs",
    "meain/vim-printer",
    "theniceboy/antovim",
    "nvim-pack/nvim-spectre",
    "ur4ltz/move.nvim",
    "tpope/vim-repeat",
    "ThePrimeagen/refactoring.nvim",
    { -- fast jump
        "ggandor/leap.nvim",
        dependencies = { "ggandor/flit.nvim" },
    },

    -- NOTE: other tools
    "lewis6991/gitsigns.nvim",
    "sindrets/diffview.nvim",
    "skywind3000/vim-quickui",
    { "kevinhwang91/nvim-bqf", ft = "qf" },
    -- 'junegunn/fzf',
    { "voldikss/vim-translator", cmd = { "TranslateW" } },
    { "karb94/neoscroll.nvim", config = true },
    { "akinsho/toggleterm.nvim", version = "*" },
    "aserowy/tmux.nvim",
    -- language specified plugins configured in user/lang/<ft>.lua
    { -- generate python docstring
        "heavenshell/vim-pydocstring",
        build = "make install",
        ft = "python",
    },
    -- { dir = "~/.config/nvim/py-env.nvim", ft = "python" },
    { "lervag/vimtex", ft = { "tex" }, version = "*" },
}

require("lazy").setup(plugins)

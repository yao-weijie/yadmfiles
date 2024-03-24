local M = {}

local lazy_defaults = {
    change_detection = {
        enabled = false,
        notify = false,
    },
    dev = {
        path = "~/workspace/neovim/",
        fallback = true, -- 如果本地没有就用github 上的
    },
}

_G.pathlib = require("helper.path")

M.setup = function(...)
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system(
            "git clone --filter=blob:none --branch=stable https://github.com/folke/lazy.nvim.git " .. lazypath
        )
    end
    vim.opt.rtp:prepend(lazypath)

    local opts = ... or {}
    opts = vim.tbl_deep_extend("force", lazy_defaults, opts)

    vim.keymap.set("n", "<leader>L", "<cmd>Lazy<CR>", { desc = "lazy" })

    require("lazy").setup(opts)
end

return M

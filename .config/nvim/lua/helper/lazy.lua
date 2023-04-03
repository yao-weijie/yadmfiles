local M = {}

local lazy_defaults = {
    ui = {
        border = "single",
    },
    change_detection = {
        enabled = false,
        notify = false,
    },
}

M.setup = function(...)
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system(
            "git clone --filter=blob:none --branch=stable https://github.com/folke/lazy.nvim.git " .. lazypath
        )
    end
    vim.opt.rtp:prepend(lazypath)

    local opts = ... or {}
    opts = vim.tbl_deep_extend("keep", opts, lazy_defaults)

    require("lazy").setup(opts)

    vim.keymap.set("n", "<leader>L", "<cmd>Lazy<CR>", { desc = "lazy" })
end

return M

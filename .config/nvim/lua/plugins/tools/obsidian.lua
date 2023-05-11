return {
    "epwalsh/obsidian.nvim",
    version = "v1.*",
    cmd = { "ObsidianToday", "ObsidianOpen", "ObsidianNew", "ObsidianSearch" },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = {
        dir = "~/Documents/Obsidian-Vault",
        completion = {
            nvim_cmp = true,
        },
    },
}

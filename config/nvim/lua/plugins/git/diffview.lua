---@type LazySpec
return {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewToggleFiles" },
    opts = {
        enhanced_diff_hl = true, -- See ':h diffview-config-enhanced_diff_hl'
        file_panel = {
            win_config = {
                position = "left", -- One of 'left', 'right', 'top', 'bottom'
                listing_style = "tree", -- One of 'list' or 'tree'
                tree_options = { -- Only applies when listing_style is 'tree'
                    flatten_dirs = true, -- Flatten dirs that only contain one single dir
                    folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
                },
            },
        },
        file_history_panel = {
            win_config = {
                position = "bottom",
                log_options = {
                    max_count = 256, -- Limit the number of commits
                    follow = false, -- Follow renames (only for single file)
                    all = false, -- Include all refs under 'refs/' including HEAD
                    merges = false, -- List only merge commits
                    no_merges = false, -- List no merge commits
                    reverse = false, -- List commits in reverse order
                },
            },
        },
        keymaps = {
            disable_defaults = false, -- Disable the default key bindings
            -- The `view` bindings are active in the diff buffers, only when the current
            -- tabpage is a Diffview.
        },
    },
}

require("mini.cursorword").setup({
    delay = 100,
})

require("mini.ai").config = {
    -- Table with textobject id as fields, textobject specification as values.
    -- Also use this to disable builtin textobjects. See |MiniAi.config|.
    custom_textobjects = nil,

    -- Module mappings. Use `''` (empty string) to disable one.
    mappings = {
        -- Main textobject prefixes
        around = "a",
        inside = "i",

        -- Next/last textobjects
        around_next = "an",
        inside_next = "in",
        around_last = "al",
        inside_last = "il",

        -- Move cursor to corresponding edge of `a` textobject
        goto_left = "g[",
        goto_right = "g]",
    },

    -- Number of lines within which textobject is searched
    n_lines = 50,

    -- How to search for object (first inside current line, then inside
    -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
    -- 'cover_or_nearest', 'next', 'prev', 'nearest'.
    search_method = "cover_or_next",
}

require("mini.align").setup({
    -- Module mappings. Use `''` (empty string) to disable one.
    mappings = {
        start = "<leader>a",
        start_with_preview = "<leader>A",
    },

    -- Modifiers changing alignment steps and/or options
    modifiers = {
        -- Main option modifiers
        -- ['s'] = --<function: enter split pattern>,
        -- ['j'] = --<function: choose justify side>,
        -- ['m'] = --<function: enter merge delimiter>,

        -- -- Modifiers adding pre-steps
        -- ['f'] = --<function: filter parts by entering Lua expression>,
        -- ['i'] = --<function: ignore some split matches>,
        -- ['p'] = --<function: pair parts>,
        -- ['t'] = --<function: trim parts>,

        -- -- Delete some last pre-step
        -- ['<BS>'] = --<function: delete some last pre-step>,

        -- -- Special configurations for common splits
        -- ['='] = --<function: enhanced setup for '='>,
        -- [','] = --<function: enhanced setup for ','>,
        -- [' '] = --<function: enhanced setup for ' '>,
    },

    -- Default options controlling alignment process
    options = {
        split_pattern = "",
        justify_side = "left",
        merge_delimiter = "",
    },

    -- Default steps performing alignment (if `nil`, default is used)
    steps = {
        pre_split = {},
        split = nil,
        pre_justify = {},
        justify = nil,
        pre_merge = {},
        merge = nil,
    },
})

require("mini.surround").setup({

    -- Add custom surroundings to be used on top of builtin ones. For more
    -- information with examples, see `:h MiniSurround.config`.
    custom_surroundings = nil,

    -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
    highlight_duration = 500,

    -- Module mappings. Use `''` (empty string) to disable one.
    mappings = {
        -- 最常用的三个
        add = "ys", -- Add surrounding in Normal and Visual modes
        delete = "ds", -- Delete surrounding
        replace = "cs", -- Replace surrounding

        find = "", -- Find surrounding (to the right)
        find_left = "", -- Find surrounding (to the left)
        highlight = "", -- Highlight surrounding
        update_n_lines = "", -- Update `n_lines`

        suffix_last = "", -- Suffix to search with "prev" method
        suffix_next = "", -- Suffix to search with "next" method
    },

    -- Number of lines within which surrounding is searched
    n_lines = 20,

    -- How to search for surrounding (first inside current line, then inside
    -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
    -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
    search_method = "cover",
})

require("mini.move").setup({
    mappings = {
        -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
        left = "<M-h>",
        right = "<M-l>",
        down = "<M-j>",
        up = "<M-k>",

        -- Move current line in Normal mode
        line_left = "<M-h>",
        line_right = "<M-l>",
        line_down = "<M-j>",
        line_up = "<M-k>",
    },
})

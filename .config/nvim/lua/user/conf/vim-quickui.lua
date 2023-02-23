-- TODO
local call = vim.api.nvim_call_function

-- -- set menu style
-- vim.g.quickui_color_scheme = "gruvbox"
-- -- border style not work(bug?)
-- vim.g.quickui_border_style = 2
-- vim.g.quickui_show_tip = 1

-- file, project, preferences
local menu_file = {
    "&File",
    {
        { "&New File/Floder", "" },
        { "&Save All", "wa" },
        { "&Quit", "q" },
    },
}

-- undo, redo, find, replace, comment
local menu_edit = {
    "&Edit",
    {
        { "Find and Replace", 'lua require("spectre").open()' },
    },
}

local menu_lsp = {
    "&LSP",
    {
        { "Definition\t<Spec>fd", "Telescope lsp_definition" },
        { "Declaration\tgD", "Telescope lsp_declaration" },
        { "Implementation\t<Spec>fi", "Telescope lsp_implementation" },
        { "References\t<Spec>fr", "Telescope lsp_references" },
        { "List buf symbols\t<Spec>fs", "Telescope lsp_document_symbols" },
        { "List workspace symbols\t<Spec>fS", "Telescope lsp_workspace_symbols" },
        { "rename symbol\tgr", "lua vim.lsp.buf.rename()" },
    },
}

local menu_git = {
    "&Git",
    {
        { "&LazyGit\t", "LazyGit" },
        { "GitUI\t", "GitUI" },
        { "--", "" },
        { "DiffviewOpen", "DiffviewOpen" },
        { "DiffviewClose", "DiffviewClose" },
    },
}

-- run+debug
local menu_build = {
    "&Build",
    {
        { "Run   File\tF5", "AsyncTask file-run" },
        { "Build File\tF6", "AsyncTask file-build" },
        { "Run   Project\tShift-F5", "AsyncTask project-run" },
        { "Build Project\tShift-F6", "AsyncTask project-build" },
        { "List  Tasks", "AsyncTaskList" },
        { "--", "" },
        { "Unit Test", "" },
        { "--", "" },
        { "Start Debug\tF8", "DapContinue" },
        { "Toggole BreakPoint\t", "PBDapToggleBreakpoint" },
    },
}

local menu_help = {
    "&Help",
    {
        { "Check Health", "checkhealth" },
        { "About", "version" },
    },
}

call("quickui#menu#reset", {})
call("quickui#menu#install", menu_file)
call("quickui#menu#install", menu_edit)
call("quickui#menu#install", menu_lsp)
call("quickui#menu#install", menu_git)
call("quickui#menu#install", menu_build)
call("quickui#menu#install", menu_help)

local function make_context()
    local context = {
        { "Run File", "AsyncTask file-run" },
        { "Build File", "AsyncTask file-build" },
        { "Definition/References", "Lspsaga lsp_finder" },
    }
    return context
end

local context_opts = { index = "quickui#context#cursor" }

require("which-key").register({
    ["<leader>m"] = { "<cmd>QuickUI menu<CR>", "quickui menu" },
    ["<RightMouse>"] = {
        function()
            local context = make_context()
            call("quickui#context#open", { context, context_opts })
        end,
        "RightMouse menu",
    },
}, {})

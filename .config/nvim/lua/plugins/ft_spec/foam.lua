-- local builtins = require("null-ls").builtins
-- _G.toolset["foam"] = {

-- }

local foam_dict_name = {
    "blockMeshDict",
    "controlDict",
    "fvSchemes",
    "fvSolution",
}

-- local cwd = vim.fn.getcwd()

-- vim.g.is_foam_dir = false
-- if
--     vim.fn.isdirectory(cwd .. "/0") == 1
--     and vim.fn.isdirectory(cwd .. "/constant") == 1
--     and vim.fn.isdirectory(cwd .. "/system") == 1
-- then
--     vim.g.is_foam_dir = true
--     vim.notify("OpenFOAM case directory!")
-- end

-- if vim.g.is_foam_dir then
--     vim.api.nvim_create_autocmd({ "BufRead" }, {
--         callback = function(file)
--             local fpath = file.file
--             local suffix = vim.fn.fnamemodify(fpath, ":e")
--             if suffix == "" then
--                 -- no suffix  extension
--             end
--         end,
--     })
-- end

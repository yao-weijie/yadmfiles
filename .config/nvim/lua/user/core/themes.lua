local dark_themes = {
    "tokyonight",
    "tokyonight-moon",
    "tokyonight-night",
    "tokyonight-storm",
}
local light_themes = {
    "tokyonight-day",
}

math.randomseed(os.clock())
if vim.o.background == "dark" then
    vim.cmd("colorscheme " .. dark_themes[math.random(#dark_themes)])
else
    vim.cmd("colorscheme " .. light_themes[math.random(#light_themes)])
end

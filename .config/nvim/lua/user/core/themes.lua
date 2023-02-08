local dark_themes = {
    "nightfox",
    "duskfox",
    "nordfox",
    "carbonfox",
    "tokyonight",
    "tokyonight-moon",
    "tokyonight-night",
    "tokyonight-storm",
}
local light_themes = {
    "dayfox",
    "terafox",
    "tokyonight-day",
}

if vim.o.background == "dark" then
    vim.cmd("colorscheme " .. dark_themes[math.random(#dark_themes)])
else
    vim.cmd("colorscheme " .. light_themes[math.random(#light_themes)])
end

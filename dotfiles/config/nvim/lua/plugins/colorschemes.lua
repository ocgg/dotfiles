return {
    {
        "rebelot/kanagawa.nvim",
        priority = 1000,
        opts = {
            transparent = true, -- do not set background color
            colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
            overrides = function(colors)
                local theme = colors.theme
                return {
                    Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
                }
            end,
        },
    },
}

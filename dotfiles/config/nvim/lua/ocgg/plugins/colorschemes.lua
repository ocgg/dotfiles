return {
    {
        "rebelot/kanagawa.nvim",
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
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        -- config = true,
        config = function()
            vim.cmd.colorscheme("gruvbox")
            vim.cmd([[ highlight Normal guibg=#1e1e1e ]])
        end,
        opts = { contrast = "hard" },
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
    },
    {
        "marko-cerovac/material.nvim",
        lazy = false,
        priority = 1000,
        opts = {

            contrast = {
                cursor_line = true, -- Enable darker background for the cursor lin
            },
            plugins = {             -- Uncomment the plugins that you use to highlight them
                "nvim-cmp",
                "telescope",
                "nvim-tree",
            },
            high_visibility = {
                darker = true, -- Enable higher contrast text for darker style
            },
            disable = {
                colored_cursor = true, -- Disable the colored cursor
                -- background = true, -- uses your terminal background
            },
            lualine_style = "stealth", -- 'stealth' or 'default'
            custom_highlights = {
                CurSearch = { bold = true, bg = "#404040" },
                Search = { bg = "#383838" },
            },
        },
    },
}

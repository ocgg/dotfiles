return {
	{
		"tiagovla/tokyodark.nvim",
		lazy = false,
		priority = 1000,
	},
	-- gruvbox
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
	-- tokyonight
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
	},
	-- codedark (VScode like)
	{ "Mofiqul/vscode.nvim" },
	{ "aktersnurra/no-clown-fiesta.nvim" },
	{ "projekt0n/github-nvim-theme" },
	{
		"marko-cerovac/material.nvim",
		lazy = false,
		priority = 1000,
		opts = {

			contrast = {
				cursor_line = true, -- Enable darker background for the cursor lin
			},
			plugins = { -- Uncomment the plugins that you use to highlight them
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

return {
	"folke/which-key.nvim",
	event = "VimEnter", -- Sets the loading event to 'VimEnter'
	-- event = "VeryLazy",
	opts = {
		icons = {
			mappings = true, -- if Nerd Font
		},
		-- keys = {
		-- 	{
		-- 		"<leader>?",
		-- 		function()
		-- 			require("which-key").show({ global = false })
		-- 		end,
		-- 		desc = "Buffer Local Keymaps (which-key)",
		-- 	},
		-- },
		-- Document existing key chains
		spec = {
			{ "<leader>a", group = "GitHub Copilot menu" },
			{ "<leader>c", group = "[C]ode", mode = { "n", "x" } },
			{ "<leader>d", group = "[D]ocument" },
			{ "<leader>r", group = "[R]ename" },
			{ "<leader>s", group = "[S]earch" },
			{ "<leader>w", group = "[W]orkspace" },
			{ "<leader>t", group = "[T]oggle" },
			{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
			{ "<leader>f", group = "[F]ind" },
			{ "<leader>g", group = "[G]oto (Telescope LSP)" },
		},
	},
}

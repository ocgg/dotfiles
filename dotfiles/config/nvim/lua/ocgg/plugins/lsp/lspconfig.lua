return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "folke/neodev.nvim", opts = {} },
		{ "j-hui/fidget.nvim", opts = {} },
	},
	config = function()
		local nvim_lsp = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")

		-- local protocol = require("vim.lsp.protocol")

		local on_attach = function(client, bufnr)
			-- format on save
			-- if client.server_capabilities.documentFormattingProvider then
			-- 	vim.api.nvim_create_autocmd("BufWritePre", {
			-- 		group = vim.api.nvim_create_augroup("Format", { clear = true }),
			-- 		buffer = bufnr,
			-- 		callback = function()
			-- 			vim.lsp.buf.format()
			-- 		end,
			-- 	})
			-- end
		end

		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		mason_lspconfig.setup_handlers({
			-- The first entry (without a key) will be the default handler
			-- and will be called for each installed server that doesn't have
			-- a dedicated handler.
			function(server)
				nvim_lsp[server].setup({
					on_attach = on_attach,
					capabilities = capabilities,
				})
			end,
			-- Next, you can provide a dedicated handler for specific servers.
			-- For example, a handler override for the `rust_analyzer`:
			-- ["ruby_lsp"] = function()
			-- 	nvim_lsp["ruby_lsp"].setup({
			-- 		on_attach = on_attach,
			-- 		capabilities = capabilities,
			-- 	})
			-- end,
		})
	end,
}

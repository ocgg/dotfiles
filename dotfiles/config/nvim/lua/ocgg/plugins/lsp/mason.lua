return {
    {
        'williamboman/mason-lspconfig.nvim',
        event = { "BufReadPre", "BufNewFile" },
        dependencies = { 'williamboman/mason.nvim' }
    },
    {
        "williamboman/mason.nvim",
        dependencies = {
            -- "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
        },
        config = function()
            require("mason").setup()

            require("mason-lspconfig").setup({
                automatic_installation = true,
                ensure_installed = {
                    "bashls",
                    "cssls",
                    "emmet_language_server",
                    "eslint",
                    "html",
                    "jsonls",
                    "lua_ls",
                    "marksman", -- markdown
                    "pyright",
                    "standardrb",
                    "ruby_lsp",
                },
            })

            require("mason-tool-installer").setup({
                ensure_installed = {
                    -- linters
                    "erb-lint",
                    "eslint_d",
                    "htmlhint",
                    "markdownlint",
                    "pylint",
                    "shellcheck",
                    "stylelint",
                    -- formatters
                    "beautysh", -- bash
                    "black",    -- python
                    "erb-formatter",
                    "htmlbeautifier",
                    "isort", -- python
                    "prettier",
                    "stylua",
                },
            })
        end,
    }
}

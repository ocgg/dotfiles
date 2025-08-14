return {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
    opts = {
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
            -- -- linters
            -- "erb-lint",
            -- "eslint_d",
            -- "htmlhint",
            -- "markdownlint",
            -- "pylint",
            -- "shellcheck",
            -- "stylelint",
            -- -- formatters
            -- "beautysh", -- bash
            -- "black",    -- python
            -- "erb-formatter",
            -- "htmlbeautifier",
            -- "isort", -- python
            -- "prettier",
            -- "stylua",
        },
    },
}

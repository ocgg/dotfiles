vim.lsp.config('ruby_lsp', {
    init_options = {
        formatter = "standard",
        linters = { "standard" },
    },
    on_attach = function(client)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
    end
})

vim.lsp.enable({
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
})

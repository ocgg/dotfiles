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
